import re
from flask import Flask, current_app
from flask_restful import Api
from config.conexion_bd import base_de_datos
from controllers.Tarea import TareasController
from controllers.Usuario import (RegistroController, 
                                UsuarioController,
                                ResetearPasswordController)
from flask_jwt import JWT
from config.seguridad import autenticador, identificador
from dotenv import load_dotenv
from datetime import timedelta, datetime
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
#cambia el prefijo de la token (la palara previa a la token)
app.config['JWT_AUTH_HEADER_PREFIX'] = 'BEARER'


jsonwebtoken = JWT(app=app, authentication_handler=autenticador,
                    identity_handler=identificador)

print(app.config)
jsonwebtoken.jwt_error_callback = manejo_error_JWT

base_de_datos.init_app(app)
base_de_datos.create_all(app=app)


@jsonwebtoken.jwt_payload_handler
def definir_playload(identity):
    # print(identity)
    # print(current_app.config)
    creation = datetime.utcnow()
    expiration = creation + current_app.config.get('JWT_EXPIRATION_DELTA')
    not_before_delta = creation + \
                        current_app.config.get('JWT_NOT_BEFORE_DELTA')
    user = {
        "id": identity.id,
        "correo": identity.username
    }
    print(current_app.config.get('JWT_EXPIRATION_DELTA'))
    return {
        "iat": creation,
        "exp": expiration,
        "nbf": not_before_delta,
        "usuario": user,
        
    }

#Rutas
api.add_resource(RegistroController, '/registro')
# api.add_resource(LoginController, '/login')
api.add_resource(UsuarioController, '/usuario')
api.add_resource(TareasController, '/tareas')
api.add_resource(ResetearPasswordController, '/reset-password')

if __name__ == '__main__':
    app.run(debug=True)