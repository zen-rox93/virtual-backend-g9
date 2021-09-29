from django.urls import path
from .views import (BuscadorClienteController, ClienteController, OperacionController, 
                    ProductosController, 
                    PruebaController, 
                    ProductoController,
                    ClienteController,
                    BuscadorClienteController,
                    OperacionController,
                    OperacionesController)

urlpatterns = [
    path('prueba/', PruebaController.as_view()),
    path('productos/', ProductosController.as_view()),
    path('producto/<int:id>', ProductoController.as_view()),
    path('clientes/', ClienteController.as_view()),
    path('buscar-cliente/', BuscadorClienteController.as_view()),
    path('operacion/', OperacionController.as_view()),
    path('operacion/<int:id>', OperacionesController.as_view()),
]