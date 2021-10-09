import { Tarea } from "../config/models";
import {Op} from 'sequelize'


export const serializadorTarea = (req, res, next)=>{
    const data = req.body;
    const dataTarea = {
        tareaNombre: data.nombreTarea,
        tareaDias: data.diasTarea,
        tareaHora: data.horaTarea
    };

    if(dataTarea.tareaNombre){
        req.body = dataTarea;
        next();
    } else {
        return res.status(400).json({
            message: "Falta el nombreTarea",
            content: null,
        });
    }
};

export const crearTarea = async(req, res)=> {

    const data = req.body;
    try{
       const nuevaTarea = await Tarea.create(data);
       return res.status(201).json({
           message: "Tarea creada exitosamente",
           content: nuevaTarea,
       });
    } catch (error) {
        return res.status(500).json({
            message: "error al crear la tarea",
            content: error,
        });
    }
      
};

export const listarTareas = async (req, res)=>{
    const tareas = await Tarea.findAll();

    return res.json({
        content: tareas,
        message: null,
    });
};

export const actualizarTarea = async (req, res) => {
    const { id } = req.params;

    const [total, model] = await Tarea.update(req.body, {
        where: {tareaId :id},
        returning: true,
    });

    console.log(total);
    console.log(model);

    if(total === 0){
        return res.status(404).json({
            message: "No se encontro tarea a actualizar",
            content: null,
        });
    }

    return res.json({
        message: "Tarea actulizada exitosamente",
        content: model[0],
    });
};

export const eliminarTarea = async (req, res)=>{
    const {id} = req.params;
    const resultado = await Tarea.destroy({where: {tareaId: id} });
    
    const message =
        resultado !== 0
            ? "Tarea eliminada exitosamente"
            : "No se encontro la tarea a eliminar";
    console.log(resultado);

    return res.status(resultado !== 0 ? 200 : 404).json({
        message,
    });
};

export const devolverTarea = async (req, res) => {
    const {id} = req.params;
    const tarea = await Tarea.findOne({where:{ tareaId: id }});

    return res.json({
        // si tarea == null entonces el message sera null caso contrario indicara 'Tarea no encontrada'
        message: tarea ? null : "Tarea no encontrada",
        content: tarea,
    });
};

export const filtrarTareas = async(req,res)=>{
    const { dias, hora, nombre } =req.query;
    const tareas = await Tarea.findAll({
        where:{
            tareaNombre:{
                [Op.like]: "%" + nombre + "%",
            },
            tareaHora: hora,
            //Todo: revisar la forma en al cual se pueda hacer un where en un array en postgresql con sequelize
            
            tareaDias: {
                [Op.in]: dias,
            },
        }, 
        // si queremos indicar que columanas queremos retornar entonces usaremos el atributo attributes indicando en un array indicando como primer parametro el nombre de la col. en la bd y como segundo el alias
        // attributes: [["nombre", "nombrecito" ], "tareaDia"],
        //si queremos excluir una determinada columna 0 columanas
        attributes:{
            exclude: ["createdAt", "fecha_de_actualizacion"],
        },
        logging: console.log,
    });

    return res.json({
        content: tareas,
    });
};