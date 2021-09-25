from rest_framework import serializers
from .models import ClienteModel, ProductoModel

class ProductoSerializer(serializers.ModelSerializer):
    class Meta:
        # esto vinculara el serializador con el modelo respectivo para jlar sus atributos y hacer validaciones correspondientes
        model = ProductoModel
        # indica que campos tengo q mostrar para deserealizacion
        # fields = '__all__' =>  indicara que haremos uso de todas los atributos del modelo

        fields='__all__'
        # exclude = ['campo1','campo2'] => excluira tanto de la peticion como del retorno de elementos los atributos indicados
        # exclude = ['productoId']

        # no se puede utilizar los dos atributos al mismo tiempo, es decir, o usamos el exclude o usamos el fields 

class ClienteSerializer(serializers.ModelSerializer):

    class Meta:
        model = ClienteModel
        fields = '__all__'
         