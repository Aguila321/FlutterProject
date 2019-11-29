import 'package:flutter/material.dart';
import 'package:flutter_movie/src/models/movie_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Movie> movies;

  MovieHorizontal({@required this.movies});
  @override
  Widget build(BuildContext context) {
    //Tamanio  de   la pagina
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      //Solo ocupara el 20 %  de toda la pagina
      height: _screenSize.height * 0.25,
      child: PageView(
        pageSnapping: false,
        //Controlador de la  pagina
        controller: PageController(
            //Iinicializamos con un valor
            initialPage: 1,
            //Se muestra las tarjetas del footer
            viewportFraction: 0.3),
        children: _tarjetas(context),
      ),
    );
  }

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
