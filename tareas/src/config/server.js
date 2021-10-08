import express, { json } from "express";
import { tareasRouter } from "../routes/tareas.routes";
import { conexion } from "./sequelize";


export class Server{
    constructor(){
        this.app = express()
        // indicara si el contenido dela izquierda es verdadero (tiene un valor) entonces usara el contenido de la derecha
        //diferencia con el nullish operator => NCO valida que no sea ni NULL ni UNIDEFINED y el logical OR valida que no sea undefined
        this.puerto = process.env.PORT || 8000;
        this.bodyParser()
        this.rutas()
    }
    bodyParser(){
        this.app.use(json())
    }
    rutas() {
        this.app.get("/", (req, res) => {
            res.json({
                message: "Bienvenido a mi API",
            });
        });
        this.app.use(tareasRouter);
    }
    start() {
        this.app.listen(this.puerto, async() => {
            console.log(
                `Servidor corriendo exitosamente en el puerto ${this.puerto}`
            );

            try {
                await conexion.sync();
                console.log("Base de datos conectada exitosamente")
            } catch (error) {
                console.log(error);
            }
        });
    }
}