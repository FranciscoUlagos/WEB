/*1. Crear un algoritmo que solicite al usuario un número entero positivo. Luego, utilizar un
bucle para calcular la suma de todos los números pares desde 1 hasta el número ingresado
por el usuario. Mostrar el resultado en el navegador.*/

var numero = prompt("Ingrese un numero");
alert ("Sumare los numeros pares desde el 1 hasta el numero que usted ingreso");
var suma=0;
var i=2;
while(i<=numero){
    suma=suma+i;
    i=i+2;
}
alert("La suma de los numeros pares es: "+suma);