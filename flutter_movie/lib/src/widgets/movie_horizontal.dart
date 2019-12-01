import 'package:flutter/material.dart';
import 'package:flutter_movie/src/models/movie_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Movie> movies;
  //Para que ejecute la siguiente pagina
  final Function siguientePagina;
  //Constructor
  MovieHorizontal({@required this.movies, @required this.siguientePagina});
  final _pageController = new PageController(
      //Iinicializamos con un valor
      initialPage: 1,
      //Se muestra las tarjetas del footer
      viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    //Tamanio  de   la pagina
    final _screenSize = MediaQuery.of(context).size;
    //Este pagecontroler se va activar cada vez que se mueva  el control horizonal de movies populares
    _pageController.addListener(() {
      //Calculamos el tamanio del controller, horizontal.
      //Antes que llege al final  -200 cargamos mas data
      //Infinite scroll horizontal
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        siguientePagina();
      }
    });
    return Container(
      //Solo ocupara el 20 %  de toda la pagina
      height: _screenSize.height * 0.25,
      //[PageView]  : Renderiza todos los elementos no importa la cantidad
      //[PageView.build] :  Renderiza solo los elementos necesarios
      child: PageView.builder(
          pageSnapping: false,
          //Controlador de la  pagina
          controller: _pageController,
          // children: _tarjetas(context),
          //Cuantos items va renderizar
          itemCount: movies.length,
          // Ya  no usamos el children,  creamos el  item builder(funcion) donde recibe el indice y el contexto
          //Con el indice obtenemos los valores del arreglo de  peliculas
          itemBuilder: (context, i) {
            //Llamamos al metodo de crear tarjeta
            return _tarjeta(context, movies[i]);
          }),
    );
  }

  //**Metodo de crear tarjetas */
  Widget _tarjeta(BuildContext context, Movie movie) {
    final Container tarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          //**Bordear las imagenes footer */
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(movie.getPosterImg()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              fit: BoxFit.cover,
              height: 160.0,
            ),
          ),
          //**Separacion */
          SizedBox(height: 5.0),
          //**Configurando text footer */
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
    //Este Objeto Escucha eventos click, tap y muchos mas...
    return GestureDetector(
      onTap: () {
        //Cuando presionamos en una  pelicula  de la parte horizontal
        //Nos vamos al page pelicula  detalle. donde le enviamos como argumento
        //el objeto de la pelicula completa
        Navigator.pushNamed(context, '/detail', arguments: movie);
      },
      child: tarjeta,
    );
  }

  //Creamos varias tarjetas. en  base a las peliculas
  List<Widget> _tarjetas(BuildContext context) {
    //**Mapeamos las movies y lo convertimos a to  list, lo que requiere la funcion */
    return movies.map((movie) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            //**Bordear las imagenes footer */
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(movie.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            //**Separacion */
            SizedBox(height: 5.0),
            //**Configurando text footer */
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();
  }
}
