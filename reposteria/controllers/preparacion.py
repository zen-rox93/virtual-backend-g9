from models.preparacion import PreparacionModel
from flask_restful import Resource, reqparse
from conexion_bd import base_de_datos

class PreparacionesController(Resource):
    serializador = reqparse.RequestParser(bundle_errors=True)
    serializador.add_argument(
        'orden',
        
        required=True,
        type=int,
        help='Falta el orden',
        location='json'
        
    )
    serializador.add_argument(
        'descripcion',
        required=True,
        type=str,
        help='Falta la descripcion',
        location='json'
    )
    serializador.add_argument(
        'receta_id',
        type=int,
        required=True,
        help='Falta la receta_id',
        location='json'

    )
    def get(self, id):
        preparacion = base_de_datos.session.query(PreparacionModel).filter(
            PreparacionModel.preparacionId == id).first()
        # print(preparacion.prepraracionRecetas)
        preparacionDict = preparacion.__dict__.copy()
        del preparacionDict['_sa_instance_state']
        return {
            "message": None,
            "Content": preparacionDict
        }

    def post(self):
        data = self.serializador.parse_args()
        print(data)
        nuevaPreparacion = PreparacionModel(
            preparacionOrden =data['orden'],
            receta = data['receta_id'], 
            preparacionDescripcion=data['descripcion'])
        base_de_datos.session.add(nuevaPreparacion)
        base_de_datos.session.commit()
        nuevaPreparacionDict = {
            "prepracionId": nuevaPreparacion.preparacionId,
            "preparacionOrden": nuevaPreparacion.preparacionOrden,
            "preparacionDescripcion": nuevaPreparacion.preparacionDescripcion,
            "receta_id": nuevaPreparacion.receta
        }

        return {
            "message": "Preparacion registrada exitosamente",
            "content": nuevaPreparacionDict   
        }, 201