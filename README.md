# PruebaMovies IOS


Resumen
La aplicación maneja una arquitectura VIPER, trabaja con tres librerías Alamofire para las peticiones HTTP, YouTube player para reproducirlos videos y ViewAnimator para algunas animacones; tiene dos vistas el home donde se muestra las tres categorías de movies y el resultado de lel buscador online en tablas que al presionarlas permite mostrar mas información de la película. cuando no hay conexion desaparece de la toolbar el buscador online y aparecen en las tres categorias sus filtros

———————————————————————————————————————
———————————————————————————————————————


MODULO MOVIES.  -> Home de la app

MoviesRouter: Permite la navegación  a otras vistas (DetalView)

Capa de interfaz
MoviesView
Esta clase recibe las interacciones del usuario y se las comunica al presenter cuando es necesario, es la encargada de mostrar los datos y comunicarse con el presenter cuando lo requiere

MoviesViewController
Esta clase esta encargada de mostrar los datos en una tabla, de recibir las interacciones del usuario y los estados de la app

Capa de datos
MoviesEntity
Aquí se encuentra la representación del request que devuelve la API cuando se llama los servicios que retornan las 3 categorías de movies y el filtro, y los objetos internos del request como Movie es la representación de los results que están anidados en el request y e que se utiliza para mostrar en la aplicación 

Capa de presentación 
MoviesPreseter
Recibe los datos de la vista y en caso de que requiera alguna lógica lo comunica al interactor y la respuesta de este ultimo la envía a la vista

Capa de negocio
MoviesInteractor: Esta clase se encarga de obtener los datos de la capa de red o de memoria cuando no hay conexión a red, el filtro de películas y el guardado de estas.

MoviesConfigurator: Esta clase permite configurar todos los protocolos

MovieTableViewCell
Esta clase nos permite mostrar de una forma mas amigable los datos que tenemos de las películas en la tabla para lo cual también se crea un vista con el mismo nombre donde se muestra el diseño

———————————————————————————————————————
MODULO DETAIL -> Muestra el detalle de las películas

Capa de interfaz
DetailView
Esta clase recibe las interacciones del usuario y se las comunica al presenter cuando es necesario, es la encargada de mostrar los datos y comunicarse con el presenter cuando lo requiere

DetailViewController
Esta clase esta encargada de mostrar los datos en una tabla, de recibir las interacciones del usuario y los estados de la app
Aquí se hace uso de la librería de YouTube para mostrar los video de las películas siempre y cuanto estas lo tengan

Capa de datos
DetailEntity
Aquí se encuentra la representación del request que devuelve la API cuando se llama al servicio para mostrar el detalle de una movie, y los objetos internos del request como Movie es la representación de los results que están anidados en el request y e que se utiliza para mostrar en la aplicación 

Capa de presentación 
DetailPreseter
Recibe los datos de la vista y en caso de que requiera alguna lógica lo comunica al interactor y la respuesta de este ultimo la envía a la vista

Capa de negocio
DetailInteractor: Esta clase se encarga de obtener el detalle de las películas  de la capa de red.

DetailConfigurator: Esta clase permite configurar todos los protocolos

———————————————————————————————————————

RED
La clase Networking se encarga de hacer los requests a la API según los parámetros enviados del Interactor que hace el llamado a esta.
Para estas transacciones se hace uso de la librería Alamofire.

Reachability: Esta clase permite identificar si la app cuenta con conexión a internet

———————————————————————————————————————

AppConstants
En este archivo se guardan todos los datos de la API, el dominio, el path de las peticiones a la api, muy utiles para simplificar el proceso de las peticiones

Extensions
Aqui se agregan algunas extensiones utiles para trabajar con imágenes y views

———————————————————————————————————————

PERSISTENCIA
Para la persistencia de datos se hace uso de la clase CoreDataStack, esta permite guardar las películas en las tres categorías( popular, upcoming, toprate), leerlas y eliminarlas.

———————————————————————————————————————
Pruebas unitarias

DataExample
Aqui se crean funciones que entregan datos de prueba para ser usados en las pruebas y mocks de peticiones red simuladas

MovieTest
Esta clase nos permite simular los llamados a la API para probar el modulo de movies

CoreDataStackTest
Esta clase nos permite probar la funciones para leer, eliminar, guardar y comprobar la existencia de movies en CoreData.

———————————————————————————————————————
———————————————————————————————————————
———————————————————————————————————————
Responsabilidad Unica
Este principio indica que las clases deben tener responsabilidad sobre una sola parte de la funcionalidad, todas sus operaciones deben estar estrechamente relacionadas con esa responsabilidad y tener bajas relaciones con otras clases

Características de un buen Código 

Que exista una buena abstracción de lo que se trabaja esto quiere decir que no deben haber funcionalidades de mas u características que no se están usando.

El nombramiento de variables y funciones deben ser una representación de lo que hacen o representan.

Que exista un bajo acoplamiento y una alta cohesion, sobre todo la cohesion es muy importante por que en caso de actualización o modificación del software facilita ese proceso.

El hacer uso de alguna arquitectura la cual también debería ser evaluada según el tamaño de la app que se desarrolla.
