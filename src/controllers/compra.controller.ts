import { plainToClass } from "class-transformer";
import { Request, Response } from "express";
import { validate } from "class-validator";
import { Compras, Detalles, Productos } from "../config/models";
import { CompraDto} from "../dtos/request/compra.dto";
import conexion from '../config/sequelize'
import { RequestUser } from "../middlewares/validator";
import { configure, merchant_orders, payment, preferences } from "mercadopago";

import { CreatePreferencePayload } from "mercadopago/models/preferences/create-payload.model";


export const crearCompra = async (req: RequestUser, res: Response)=> {
    const validador = plainToClass(CompraDto, req.body);
    const errores = await validate(validador);

    if(errores.length !== 0){
        // TODO: indicar los errores correctamente cuando se produzcan a raiz de un sub-error
        // if (errores[0].children) {
        //   console.log(errores[0].children[0].children);
        // }
        const mensaje_error = errores.map((error) => error.children);
        const mensaje_error_final = mensaje_error.map((error)=>
            error?.map((error_hijo) => {
                console.log(error_hijo);

                return error_hijo.children 
                    ? error_hijo.children.map(
                        (error_hijo_hijo) => error_hijo_hijo.constraints
                        )
                    : null;
            })
        );
               
            

        return res.status(400).json({
            content: mensaje_error,
            message: "Campos invalidos",
        });
    }

    const trasaccion = await conexion.transaction();
    try{
        let total = 0.0;
        const nuevaCompra = await Compras.create(
        {
            compraFecha: new Date(),
            compraTotal: total,
            usuarioId: req.usuario?.getDataValue("usuarioId"),
        },
        { transaction: trasaccion }
    );
    await Promise.all(
        validador.detalle.map(async (detalle_compra) => {
            const producto = await Productos.findByPk(detalle_compra.producto, {
                attributes: ["productoCantidad", "productoPrecio"],
            });
            if (!producto) {
                throw new Error(`Producto ${detalle_compra.producto} no existe`);
            }
            // ahora validamos si hay la cantidad suficiente
            if(detalle_compra.cantidad > producto.getDataValue('productoCantidad')){
                console.log('no hay cantidad');
                
                throw new Error(`Producto ${detalle_compra.producto} no hay suficiente cantidades`);
            };
            
            
            // ahora creamos el detalle de ese item
            await Detalles.create(
                {
                    productoId: detalle_compra.producto,
                    compraId: nuevaCompra.getDataValue("compraId"),
                    detalleCantidad: detalle_compra.cantidad,
                    detalleTotal:
                        detalle_compra.cantidad * producto.getDataValue("productoPrecio"),

                },
                {transaction : trasaccion}
            );
                
                

            //disminuir la cantidad del item
            // Update productos SET cantidad = cantidad -1 WHERE id = '..';
            await Productos.update(
                {
                    productoCantidad:
                        producto.getDataValue("productoCantidad") - detalle_compra.cantidad,
                },
                {
                    where: {
                        productoId: detalle_compra.producto,
                    },
                    transaction: trasaccion,
                }
            );
           
            total +=detalle_compra.cantidad * producto.getDataValue("productoPrecio");
            await Compras.update(
                {
                    compraTotal: total,
                },
                {
                    where: {
                        compraId: nuevaCompra.getDataValue("compraId"),
                    },
                    transaction: trasaccion,
                }
            );
            
    }))
/*
        await Promise.all([validador.detalle.map(async(detalle_compra) => {
            const producto = await Productos.findByPk(detalle_compra.producto);
            if (!producto) {
                throw new Error(`Producto ${detalle_compra.producto} no existe`);
            }
            // ahora validamos si hay la cantidad suficiente
            if(detalle_compra.cantidad > producto.getDataValue('productoCantidad')){
                console.log('no hay cantidad');
                
                throw new Error(`Producto ${detalle_compra.producto} no hay suficiente cantidades`);
            };
            console.log({
                productoId: detalle_compra.producto,
                compraId: nuevaCompra.getDataValue("compraId"),
                detalleCantidad: detalle_compra.cantidad,
                detalleTotal:
                    detalle_compra.cantidad * producto.getDataValue("productoPrecio"),

            });
            
            // ahora creamos el detalle de ese item
            await Detalles.create(
                {
                    productoId: detalle_compra.producto,
                    compraId: nuevaCompra.getDataValue("compraId"),
                    detalleCantidad: detalle_compra.cantidad,
                    detalleTotal:
                        detalle_compra.cantidad * producto.getDataValue("productoPrecio"),

                },
                {transaction : trasaccion}
            );
                console.log(detalle_compra.cantidad);
                

            //disminuir la cantidad del item
            // Update productos SET cantidad = cantidad -1 WHERE id = '..';
            await Productos.update(
                {
                    productoCantidad:
                        producto.getDataValue("productoCantidad") - detalle_compra.cantidad,
                },
                {
                    where: {
                        productoId: detalle_compra.producto,
                    },
                    transaction: trasaccion,
                }
            );
            return
                
        })])
*/
        await trasaccion.commit()
        return res.status(201).json({
            message: "Compra realizada exitosamente",
            content: nuevaCompra,
        });

    }catch(error: unknown){
        await trasaccion.rollback();
        return res.status(500).json({
            message: 'Error al crear la compra',
            content: error instanceof Error ? error.message : "",
        });
    }

    return res.json({
        message: "Compra creada exitosamente"
    });
};

export const crearPreferencia = async (req: Request, res:Response) => {
    // el metodo configure me sirve para configurar mi mercadopago en toda la aplicacion, sele tiene que proveer los campos access:token e integrator_id
    // access_token => token que se usara POR CADA APLICACION (sirve para que MP sepa a que negocio tiene que depositar y ademas en el extractro de cuenta del comprador colocar correctamente el nombre del negocio)
    // integrator_id => indentificacion del desarrolladorque efectuo la integracion (sirve para que MP reconozca quien fue el que implmento y asi brindale mejores beneficios) (disminuye la comision por venta y otros beenficios mas)
    configure({
        access_token: 
        'APP_USR-8208253118659647-112521-dd670f3fd6aa9147df51117701a2082e-677408439',
        integrator_id: 'dev_24c65fb163bf11ea96500242ac130004',
    });
    const payload: CreatePreferencePayload = { 

        back_urls:{
            success: 'google.com',
            failure: 'youtube.com',
            pending: 'gmail.com'
        },
        auto_return: "approved",
        payer: {
        name: 'Lalo',
        surname: 'Landa',
        // address: {
        //     street_name: 'Falsa',
        //     street_number: "123",
        //     zip_code: "1111",
        // },
        email: "test_user_46542185@testuser.com",
    // phone: {
    //     area_code: '11',
    //     number: '22223333',
    // },
    identification: {
        number: '22334445',
        type: 'DNI'
    }
    },
    items: [{
        id: '12',
        title: 'Yogurt Griego de 1lt.',
        description: 'Sabroso yogurt de tierras griegas',
        picture_url: 'https:// ...',
        category_id: '001',
        quantity: 2,
        unit_price: 12.50,
        currency_id: 'PEN'

        },
    ],
    payment_methods: {
        // excluded_payment_methods => excluir los metodos de pago
        excluded_payment_methods: [{ id: "master" }, { id: "debmaster" }],
        // excluded_payment_types => excluir los tipos de pago
        // excluded_payment_types: [{ id: "atm" }],
        // installments =x numero maximo de cuoutas permitido en el caso que sea una tajerta de creadito
        installments: 6
    },
    notification_url: 
    'https://bodega-mp-renzo.herokuapp.com/mp-notificaciones'
    };
    try {
        const rptaMP = await preferences.create(payload);

        console.log(rptaMP);

        return res.json({
            message: "Preferencia creada exitosamente",
            content: rptaMP
        });
    } catch(e) {
        console.log(e);

        return res.json({
            message: "Error al crear la preferencia"
        });
    }   
};

export const mpNotificaciones =  async (req:Request, res: Response)=>{
    console.log("------BODY-----");
    console.log(req.body);
    console.log("-----QUERY PARAMS-------");
    console.log(req.query);
    // iterar ya sea el merchant_order o el payment para:
    //1. buscar el nodo de items
    //2. iterar los items y buscar en la bd dichos productos para hacer su descuento (quitar el inventario)
    //3. guardar ese merchant_order o payment en el modelo de compra (reciense genera el registro)
    if(req.query?.topic && req.query.topic === 'merch_order') {
        const { id } = req.query;
        const data = await merchant_orders.findById(String(id));
        if (data.body.order_status === 'paid'){
            // dispararia su eveno para completar el pago
            // 1. enviar un correo al usuario indicando que el pago se realizo exitosamente y estan preparando el producto para enviarlo
            //2. notificar al area de despacho o alamacen apra que comience a prepara el (los) productos
            //3. remover AHORA si el item del inventario

        }
    }


    return res.status(200).send("ok");
}