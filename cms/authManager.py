from django.contrib.auth.models import BaseUserManager
# BaseUserManager = sirve para modificar el comportamiento de la creacion de un usuario x consola, nos permite modificar por ockpleto al modelo auth
#UserManager = nos permite modificar campos como el firstName y lastName, agregar nuevos campos

class ManejoUsuarios(BaseUserManager):

    def create_user(self, email, nombre, apellido, tipo, password= None):
        """CREACION DE UN USUARIO"""
        if not email:
            raise ValueError('El usuario tiene que tener un correo valido')
        # validar mi correo
        email = self.normalize_email(email)
        # creo mi instancia del usuario
        usuarioCreado = self.model(usuarioCorreo=email, usuarioNombre=nombre, usuarioApellido=apellido, usuario=tipo)

        # set_password() = encriptara la contraseña
        usuarioCreado.set_password(password)
        #sirve para referencia a que bse de datos  estoy haciendo la creacion, esto se utilizara mas que todo para cuando tengamos multiples bases de datos en nuestro proyecto
        usuarioCreado.save(using=self._db)

        return usuarioCreado

    def create_superuser(self, email, nombre, apellido, tipo, password):
        """Creacion de un superus usuario (administrador)"""
        nuevoUsuario = self.create_user(
            email, nombre, apellido, tipo, password)

        nuevoUsuario.is_superuser=True
        nuevoUsuario.is_staff = True
        nuevoUsuario.save(using=self._db)

