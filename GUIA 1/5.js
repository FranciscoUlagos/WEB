/*5. Realizar un programa que permita al usuario ingresar su estatura y peso, para que se
muestre en el navegador su IMC correspondiente. Además de mostrar el IMC, indicar si está
en la categoría de: “Bajo Peso”, “Peso Normal” o “Sobrepeso”.*/


var altura = prompt("Ingrese su altura en metros con punto\nEjemplo: 1.70");
var peso = prompt("Ingrese su peso en kg");

imc = peso/(altura*altura)
alert("Su indice de masa corporal es: "+imc);
if(imc>24.9){
    alert("Usted esta en sobrepeso");
}else if(imc<18.5)
{
    alert("Usted esta en bajo peso");
}
else
{
    alert("Usted esta en peso normal");
}


