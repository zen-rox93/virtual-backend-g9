numero1 = 10
numero2 = 80

persona1 = "Eduardo"
persona2 = "Ricardo"

# SUMA
#Nota: si las dos o mas variables son numericas se realizara la suma, pero si son string se concatenaran
# en el caso de JS si se puede sumar diferentes tipos de variables, en el caso de Python
print(numero1 + numero2)
print(persona1 + persona2)
numero1_string = str(numero1)
print (numero1_string + persona1) #Da "error"

# RESTA

print(numero1 - numero2)
#no se puede usar la resta en variables que no sean numericas 
#print(persona 1 - persona2)

# MULTIPLICACION

print(numero1 * numero2)
print(persona1 * 2)
# La multiplicacion de 10 y 80 es: 800

print(f"La multiplicacionde {numero1} y {numero2} es {numero1 * numero2}")

# DIVISION
#toda division aun asi sea entera siempre sera flotante (tiene una parte netera y una parte decimal)
print(numero2 / numero1)
print(numero1 / numero2)

# MODULO
#el modulo es el resultado de la division
#el modulo es el reciduo de la division
print(numero2 % numero1)
print(numero1 % numero2)

#COCIENTE #Es solo la parte entera, la division es diferente es la parte entero y inexacta
print(numero2 // numero1)
print(numero1 // numero2)