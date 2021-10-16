import comprasModel from "../models/compras.model";
import detallesModel from "../models/detalles.model";
import productosModel from "../models/productos.model";
import usuariosModel from "../models/usuarios.model";

//Relaciones
export const Compras = comprasModel();
export const Detalles = detallesModel();
export const Productos = productosModel();
export const Usuarios = usuariosModel();
// Productos.sync({alter:true})
Productos.hasMany(Detalles, {
    foreignKey: {name: "productoId", allowNull: false, field: "producto_id" },
});
Detalles.belongsTo(Productos, {
    foreignKey: {name: "productoId", allowNull: false, field: "producto_id"}
});

Compras.hasMany(Detalles, {
    foreignKey: {name:"compraId", allowNull: false, field: "compra_id"},
});
Detalles.belongsTo(Compras, {
    foreignKey: {name: "compraId", allowNull: false, field: "compra_id"},
});


// hacer la relacion entre usuario y compras

Usuarios.hasMany(Compras, {
    foreignKey: {name: "usuarioId", allowNull: false, field: "usuario_id"},
});

Compras.belongsTo(Usuarios, {
    foreignKey: {name: "usuarioId", allowNull: false, field: "usuario_id"}
});