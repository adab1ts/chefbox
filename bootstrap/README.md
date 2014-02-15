# CONTENIDO

La carpeta __bootstrap__ contiene los siguientes ficheros y carpetas:

* `README.md`  - contiene instrucciones de cómo ejecutar el proceso de instalación.
* `setup.sh`   - prepara todo lo necesario para poder ejecutar el proceso de instalación.
* `install.sh` - ejecuta de forma efectiva el proceso de instalación de software.
* `config/*`   - contiene ficheros de configuración necesarios para el proceso.
* `keys/*`     - contiene claves criptográficas para asegurar las comunicaciones durante el proceso.


# PROCESO

El proceso consta de dos fases:

## Fase 1:

En esta fase preparamos el sistema para poder ejecutar la fase 2.  

Entre otras tareas, es instalado un sencillo [MTA](http://en.wikipedia.org/wiki/Message_transfer_agent)  
para poder enviar por mail un informe al finalizar cada una de las fases del proceso.  
Para ello, es necesario que proporciones una dirección de correo de _Gmail_ y su correspondiente contraseña  
cuando se te requiera. No temas, esta contraseña nunca será revelada ni llegará a mi conocimiento,  
simplemente es necesaria para configurar el servicio de correo, de la misma manera que lo hacen otros clientes,  
como por ejemplo _Mozilla Thunderbird_.

Haz doble-clic con el botón izquierdo del ratón sobre el fichero `setup.sh`.  
A la pregunta _¿Quiere ejecutar o ver su contenido?_ responde pulsando en _Ejecutar en un terminal_.  

En esta fase, debes atender el procedimiento hasta que finalice, puesto que te requerirá en diferentes ocasiones  
que instroduzcas tu contraseña de usuario.

Una vez finalice el procedimiento, __cierra la sesión y vuelve a iniciar una nueva__.

## Fase 2:

Antes de proceder con la segunda fase, es necesario que me comuniques el fin de la primera.  

De forma remota y segura instalaré en tu máquina los paquetes necesarios para poder continuar.  
Una vez instalados (5 mins), te comunicaré que ya puedes proceder con la fase 2.  

Podrás iniciar su ejecución en el momento que desees, haciendo doble-clic con el botón izquierdo del ratón  
sobre el fichero `install.sh`. De nuevo, responde pulsando en _Ejecutar en un terminal_.  

En este instante empezará un proceso desatendido de instalación de paquetes de entre 40 y 60 minutos.  
Es importante que te asegures de tener conexión en todo momento y de tener la máquina enchufada a la corriente.  
Durante el inicio del proceso aparecen algunos _WARNS_ que puedes ignorar.  

Una vez finalice, __el procedimiento reiniciará el sistema__.

En ese momento podrás __eliminar de forma segura__ el contenido de la carpeta __bootstrap__,  
conservando, eso sí, los ficheros `install.sh` y `README.md` para futuras actualizaciones.


# PRIMEROS PASOS

En tu escritorio verás la carpeta __PrimerosPasos__ con instrucciones de cómo proceder a continuación,  
además de una guía sobre tu plataforma.

