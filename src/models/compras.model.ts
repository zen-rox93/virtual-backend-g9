import {DataTypes} from 'sequelize'
import conexion from "../config/sequelize";

export default () =>
    conexion.define('compras', {
        compraId: {
            primaryKey: true,
            type: DataTypes.UUID,
            defaultValue: DataTypes.UUIDV4,
            field: 'id'
        },
        compraFecha: {
            type: DataTypes.DATE,
            field: 'fecha',
            allowNull: false,
            defaultValue: new Date()
        },
        compraTotal: {
            type: DataTypes.DECIMAL(5, 2),
            field: "total",
            validate: {
                min: 0,
            },
            allowNull: false,
        },
        },

        {
            tableName: "compras",
            timestamps: false,
        }
    );