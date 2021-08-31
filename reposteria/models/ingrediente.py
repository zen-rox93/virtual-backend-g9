from conexion_bd import base_de_datos
from sqlalchemy import Column

class IngredientesModel(base_de_datos.Model):
    __tablename__ = 'ingredientes'

    IngredienteId = Column()