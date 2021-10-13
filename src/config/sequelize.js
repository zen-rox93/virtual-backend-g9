import {Sequelize} from 'sequelize';
require("dotenv").config();

export const conexion = new Sequelize(
    process.env.DATABASE_URL,
    { 
    logging: false,
    // para pdoer usar bd remotas de postgres que requieran configuracion especial
    dialectOptions: 
        process.env.NODE_ENV === "production"
        ? {
            ssl: {
                rejectUnauthorized: false,
            },
        } 
    : {},
}
     // logging => indica si se quiere mostrar o no las consultas a la bd
);