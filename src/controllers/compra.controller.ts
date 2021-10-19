import { plainToClass } from "class-transformer";
import { Request, Response } from "express";
import { validate } from "class-validator";
import { Compras, Detalles, Productos } from "../config/models";
import { CompraDto} from "../dtos/request/compra.dto";
import conexion from '../config/sequelize'
import { RequestUser } from "../middlewares/validator";


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