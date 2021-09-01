from flask import Flask
from conexion_bd import base_de_datos
from models.ingrediente import IngredienteModel
from models.receta import RecetaModel
from models.preparacion import PreparacionModel
from models.recetas_ingredientes import RecetaIngredienteModel

from controllers.ingrediente import IngredientesController
from flask_restful import Api
from os import environ
from dotenv import load_dotenv
load_dotenv()

# print(environ.get('DATABASE_URI'))

app = Flask(__name__)
api = Api(app=app)
#                                        mysql://username: password@host/db_name
app.config['SQLALCHEMY_DATABASE_URI'] = environ.get('DATABASE_URI')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
#inicia la conexion con la bd para darle las credenciales definidas en el app.config

base_de_datos.init_app(app)

# creara las tablas aun no mapeadas y si todo esta bien no deolvera nada
base_de_datos.create_all(app=app)

@app.route("/")
def initial_controller():
    return {
        "message": "Bienvenido a mi API de REPOSTERIA 🦆"
    }

# Zona de enrutamiento
api.add_resource(IngredientesController, '/ingredientes')

if __name__ == '__main__':
    app.run(debug=True)