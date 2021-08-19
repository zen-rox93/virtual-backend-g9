#list > listas
#ordenadas, y modificables

colores = ['morado', 'azul', 'rosado', 'amarillo']
mezclada = ['otono', 14, False, 15.2, [1,2,3]]

#imprimir la primera posicion

#en Python si la posicion no existe, lanzara un error, a diferencia de JS que indicara undefined
print(colores[0])
#al usar valores negativos en las posiciones de la lista, se 'invertira' y podemos recorrer dicha lista
print(colores[-1])

#Las posciones que sean desde la 1 hasta < 3

print(colores[1:3])

#toda la lista hasta la posicion  < 2
print(colores[:2])

#sirve para copiar EL contenido de la lista mas no su ubicacion de memoria
colores_2 = colores[:]
print (id(colores_2))
print(id(colores))

print(colores[1:-1])


# metodo para agregar un elemento a una lista
colores.append('naranaja')
print(colores)

#metodo para eliminar un valor
#1. solamente si existe lo eliminara, sino lanzara un error
colores.remove('azul')
print(colores)

#2 Si queremos eleiminarlo y ademas guardar el valor eliminado en una variable
color_eliminado = colores.pop(0)
print(colores)
print(color_eliminado)

#3 el metodo para eliminar el valor
# este metodo tambien sirve para eliminar variables
# nombre = "eduardo"
# del nombre
# print (nombre)

del colores[0]
print(colores)


#sacar la longitud de la lista
print(len(colores))

#Tuplas
#la tupla a diferencia de la lista es una coleccion de datos ordenada Pero que una vez creada no se puede editar

notas = (10, 15, 20, 9, 17, 10, 10, 10, 10)
print(notas[0])
print(notas[0:2])
print(len(notas))

#repeticion de numeros 10
print(notas.count(10))

#Diccionario
#coleccion de datos
persona = {
    'nombre' : 'Eduardo',
    'apellido': 'de Rivero',
    'correo' : 'correo@gmail.com',
    'edad' : 28,
    'donacion_orgnaos' : True,
    'hobbies' : [
        {
            'nombre' : 'Valor drones',
            'conocimiento' : 'avanzado'
        },
        {
            'nombre' : 'Montar bici',
            'conocimiento' : 'intermedio'
        }

    ]

}
persona['edad'] = 35
persona['nacionalidad'] = 'peruano'
print(persona["edad"])
print(persona['nombre'])
print(persona)

#imprimir el primer hobby de la persona 
#volar drones
print(persona['hobbies'][0]['nombre'])


#forma de extraer solo las llaves
print(persona.keys())

#forma de extraer solamente los valores
print(persona.values())

persona.clear()
print(persona)

#Conjuntos
#Es una coleccion de datos desordenada, una vez creado no podemos acceder a sus posiciones ya que estara ordenada aletoriamente.
#se puede editar mas no se puede ingresar a sus elementos por sus posiciones

alumnos = {'Kevin', 'Katherine', 'Ricardo', 'Aylin', 'Carlos', 'Eduardo' }
print(alumnos)
alumnos('Diego')
print(alumnos)
alumnos.remove('Eduardo')
print(alumnos)

# generalmente se usa para guardar valores sin la necesidad de llaves
cursos = {'matematica', 'cta', 'biologia', 'comunicacion'}
print('matematicas' in cursos)