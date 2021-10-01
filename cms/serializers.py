from django.core.files.base import ContentFile
from rest_framework import serializers
from .models import PlatoModel, UsuarioModel
from django.core.files.storage import default_storage
from django.core.files.uploadedfile import InMemoryUploadedFile
from django.conf import settings 

class RegistroSerializer(serializers.ModelSerializer):
    # forma 1 = declara el atributo modificado sus validaciones a nivel de modelo y poniendo nuevas validaciones 

    #password = serializers.CharField(write_only=True, required=True)

    


    def save(self):
        usuarioNombre = self.validated_data.get(
            'usuarioNombre')
        usuarioApellido = self.validated_data.get(
            'usuarioApellido')
        usuarioCorreo = self.validated_data.get(
            'usuarioCorreo')
        usuarioTipo = self.validated_data.get(
            'usuarioTipo')
        password = self.validated_data.get(
            'password')

        nuevoUsuario = UsuarioModel(usuarioNombre= usuarioNombre, 
                                usuarioApellido= usuarioApellido, 
                                usuarioCorreo= usuarioCorreo, 
                                usuarioTipo= usuarioTipo)

        nuevoUsuario.set_password(password)

        nuevoUsuario.save()
        return nuevoUsuario

    class Meta:
        model = UsuarioModel
        # fields = '__all__'
        exclude = ['groups', 'user_permissions', 'is_superuser', 'last_login', 'is_active', 'is_staff']

        #forma 2
        extra_kwargs = {
            'password': {
                'write_only':True,
            }
        }

class PlatoSerializer(serializers.ModelSerializer):

    class Meta:
        model = PlatoModel
        fields = '__all__'

class ImagenSerializer(serializers.Serializer):
    # max_length = indica el maximo de caracteres en el nombre de un archivo
    # use_url = si es True, el valor de la url sear usado para mostrar la ubicacion del archivo.Si es Fale entonces se usara el nombre del archivo (False es su valor x defecto)
    archivo = serializers.ImageField(
        max_length=20, use_url=True)

    def save(self):
        archivo: InMemoryUploadedFile = self.validated_data.get('archivo')

        # para ver el tipo de archivo que es
        print(archivo.content_type)
        # para ver el nombre del archivo
        print(archivo.name)
        # para vaer el tamaño del archivo expresado en bytes
        print(archivo.size
        )
        # NOTA:una vez que se usa el metodo read se elimina la infor de ese archivo en al memoria ram
        ruta = default_storage.save(archivo.name , ContentFile(archivo.read()))
        return settings.MEDIA_URL + ruta