/*3. Crear un programa que pida al usuario una contraseña. Luego, verificar si la contraseña
ingresada cumple con ciertos criterios, como tener al menos 8 caracteres, incluir al menos
una letra mayúscula y un número. Mostrar un mensaje en el navegador indicando si la
contraseña es válida o no.*/

function validarContrasena(contraseña) {
    var regex = /^(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/;
    return regex.test(contraseña);
  }
  
var contraseña = prompt("Ingrese una contraseña con las siguientes restricciones:\nAl menos 8 caracteres\nIncluir al menos una letra mayuscula y un numero");
alert ("La contraseña es: "+contraseña);

    if (validarContrasena(contraseña)) {
    alert("La contraseña es válida");
  } else {
    alert("La contraseña no es válida");
  }
