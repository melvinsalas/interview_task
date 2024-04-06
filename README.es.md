# tarea_de_entrevista

Un nuevo proyecto Flutter.

## Empezando

Este proyecto es un punto de partida para una aplicación Flutter.

Algunos recursos para empezar si este es tu primer proyecto Flutter:

- [Tutorial: Escribe tu primera aplicación Flutter](https://docs.flutter.dev/get-started/codelab)
- [Recetario: Ejemplos útiles de Flutter](https://docs.flutter.dev/cookbook)

Para ayuda para empezar con el desarrollo de Flutter, visita la
[documentación en línea](https://docs.flutter.dev/), que ofrece tutoriales,
ejemplos, orientación sobre desarrollo móvil y una referencia completa de API.


# Tarea de Entrevista para Desarrollador Senior de Flutter

**Resumen:** Como desarrollador senior de Flutter, a menudo se te encargará arquitectar e implementar flujos de navegación complejos dentro de la aplicación. Esta evaluación se centra en evaluar tu competencia en la navegación de la aplicación.

## Instrucciones:

1. Configura un nuevo proyecto Flutter con FVM.
2. Crea las pantallas y componentes necesarios basados en los requisitos proporcionados.
3. Escribe código limpio, eficiente y bien documentado.
4. Utiliza la navegación declarativa de Flutter, ya sea a través del paquete go_router o directamente utilizando el SDK de Flutter Router.
5. Usa bibliotecas según consideres necesario. Sin embargo, mantenlo lo más simple posible.
6. Asegúrate de que la aplicación funcione en la web (ejecución local solamente, no es necesario desplegarla en ningún lado).
7. La lógica es más importante que la interfaz de usuario, así que puedes diseñarla como desees siempre y cuando cumpla con los requisitos.
8. Al completar, limpia la carpeta de construcción del proyecto, comprime la carpeta del proyecto y envíala.

## Requisitos:
1. __Flujo de Autenticación:__
    - Implementa un flujo de autenticación simple con una página de inicio de sesión (no se necesita página de registro).
    - Autentica a través de una API gratuita, por ejemplo, https://dummyjson.com/docs/auth (o cualquier otra que prefieras), y almacena el token de autenticación para más adelante.
    - Tras una autenticación exitosa, navega al usuario a una página de inicio donde se muestren los datos del usuario con un botón de cierre de sesión.
    - En una página de inicio, actualiza los datos del usuario cada 10 segundos llamando a https://dummyjson.com/auth/me. (¡Actualízalo solo cuando el perfil esté visible!)
    - Si el token de autenticación caduca durante alguna solicitud de API, simplemente navega a la página de inicio de sesión. (no es necesario manejar la redirección después del inicio de sesión)
    - Inicia sesión automáticamente si la aplicación se inicia mientras hay un token de autenticación disponible y no ha caducado.
    - Restringe la navegación a todas las páginas cuando no haya un token de autenticación. Simplemente navega a la página de inicio de sesión.
2. __Vista de Productos Dinámicos:__
    - Agrega una navegación inferior a la página de inicio, que contenga las opciones "Perfil" y "Productos". (Esta parte es la opción "Productos". Mueve los detalles del usuario a la opción "Perfil".)
    - Solicita productos desde https://dummyjson.com/docs/products cada 30 segundos, pero cada vez genera un valor aleatorio de salto para la solicitud (`total=100`. `limit=10`. aleatoriza solo `skip=<0;90>`). ¡Actualiza solo cuando los Productos estén visibles!
    - Agrega 2 campos adicionales al esquema del producto además de los que se encuentran en la respuesta de la API:
        - __refreshed__ - número de veces que este producto se ha descargado. Tipo int (predeterminado a 1).
        - __amount__ - número de veces que este producto se comprará. Tipo int (predeterminado a 0)
    - Cuando obtengas nuevos datos, agrégalos a los que ya tienes almacenados. Si es un producto que no tenías antes, simplemente agrégalo. Si es un producto que ya tenías, incrementa su valor de `refreshed` en +1 y luego sobrescribe el antiguo.
    - Muestra productos (también los campos `refreshed` y `amount`) en una tabla y actualízala automáticamente en función de los datos almacenados. ¡No uses setState() de StatefulWidget para esto!
    - Cuando toques cualquier producto, muestra sus detalles en un diálogo con botones "+" y "-", que modifican el valor de `amount`, botón "Guardar" que actualiza el producto y botón "Eliminar" que establece `amount=0`. (tanto "Guardar" como "Eliminar" cierran el diálogo)
3. __Navegador Anidado (BONO):__
    - ¡Utiliza navegación imperativa (= navegación antigua pre-Router) solo en esta nueva sección!
    - Agrega una tercera opción - "Venta" - a la navegación inferior en la página de inicio.
    - La primera página aquí es una página de carrito de compras donde se muestra una lista de todos los productos que tienen `amount>0` (simplemente un "2x Nombre del producto" para cada uno está bien) o solo "Vacío" si no se ha seleccionado ningún producto y un botón "Pagar" en la parte inferior.
        - Cuando toques cualquier producto, usa el mismo diálogo que en el Requisito #2, pero no olvides que estás utilizando la navegación imperativa en esta sección.
        - Cuando presiones el botón "Pagar", navega a una página de pago.
    - En la página de pago, muestra un botón "Pagar" en el centro y un botón "atrás" en la parte superior izquierda.
        - Cuando presiones el botón "Pagar", navega a una página de éxito.
    - En el éxito, simplemente muestra "Venta exitosa" y navega de vuelta a la página de carrito de compras después de 5 segundos. No muestres ningún botón de retroceso aquí.
        - establece `amount=0` en todos los productos también, así que cuando vuelvas el carrito esté vacío.

__Nota:__ No dudes en hacer cualquier pregunta aclaratoria si es necesario. ¡Buena suerte!
