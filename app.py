import re
from flask import Flask
from flask_restful import Api
from config.conexion_bd import base_de_datos
from models.Tarea import TareaModel
from controllers.Usuario import (RegistroController, 
                                UsuarioController)
from flask_jwt import JWT
from config.seguridad import autenticador, identificador
from dotenv import load_dotenv
from datetime import timedelta
from os import environ
from config.configuracion_jwt import manejo_error_JWT

load_dotenv()


app = Flask(__name__)
api = Api(app)
#config son las variables de configuracion de mi proyecto de flask DEBUG=TRUE, PORT= 5000, ENVIRONMENT=DEVELOPMENT
app.config['SQLALCHEMY_DATABASE_URI']= environ.get('DATA_BASE_URI')
app.config['SQLALCHMEY_TRACK_MODIFICATIONS'] = False
#contraseña de la token
app.config['SECRET_KEY'] = environ.get('JWT_SECRET')
#cambia la fecha de expiracion de la token expresado en timedelta
app.config['JWT_EXPIRATION_DELTA'] = timedelta(minutes=30)
#cambia el parametro en el cual se pedira el nombre del usuario
app.config['JWT_AUTH_USERNAME_KEY'] = 'email'
#cambia el endpoint n el cual se hara la authentication
app.config['JWT_AUTH_URL_RULE'] = '/login'


jsonwebtoken = JWT(app=app, authentication_handler=autenticador,
                    identity_handler=identificador)

print(app.config)
jsonwebtoken.jwt_error_callback = manejo_error_JWT

base_de_datos.init_app(app)
base_de_datos.create_all(app=app)


@jsonwebtoken.jwt_payload_handler
def definir_playload(identity):
    print(identity)
    return {
        "iat": 1,
        "exp": 1,
        "nbf": 1,
        "usuario": identity.id,
        "nombre": identity.username
    }

#Rutas
api.add_resource(RegistroController, '/registro')
# api.add_resource(LoginController, '/login')
api.add_resource(UsuarioController, '/usuario')


if __name__ == '__main__':
    app.run(debug=True)