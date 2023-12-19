/*4. Solicitar al usuario que ingrese una serie de números separados por comas. Encontrar y
mostrar el número más grande entre los números ingresados.*/

let numeros = prompt("Ingrese una serie de números separados por comas");
let arreglo = numeros.split(",");
let maximo = Math.max(...arreglo);
alert("El número más grande es " + maximo);