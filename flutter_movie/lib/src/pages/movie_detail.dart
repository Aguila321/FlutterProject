import 'package:flutter/material.dart';
import 'package:flutter_movie/src/models/actors_model.dart';
import 'package:flutter_movie/src/models/movie_model.dart';
import 'package:flutter_movie/src/providers/movie_provider.dart';

class MovieDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //recuperamos el valor de los argumentos. enviados desde el home_page ['horizontal image'];
    final Movie movie = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        _createAppbar(movie),
        //**Otra opcion aparte del listview*/
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(
              height: 10.0,
            ),
            _posterTittle(movie, context),
            _movieDescription(movie),
            _createCasting(movie),
          ]),
        )
      ],
    ));
  }

  Widget _createAppbar(Movie movie) {
    //**Aplicando Un appbar personalizado muy diferente a la clasica */
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.only(right: 10.0, left: 10.0),
          child: Text(
            movie.title,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
        background: FadeInImage(
          //Obtenemos la imagen invocando al metodo del modelo
          image: NetworkImage(movie.getBackgroundImg()),
          // Mientras carga la imagen del metodo, traemos un gif.
          placeholder: AssetImage('assets/img/loading.gif'),
          // Tiempo de duracion
          fadeInDuration: Duration(milliseconds: 150),
          // El ancho de la imagen se  adapta
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  //** */
  Widget _posterTittle(Movie movie, BuildContext context) {
    return Container(
      //Un Padding al container
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      //El  row que abarca tanto la imagen y su informacion
      child: Row(
        children: <Widget>[
          ///**Dando border a  la  imagen */
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: NetworkImage(movie.getPosterImg()),
              height: 150.0,
            ),
          ),
          //**Para dar un espacio entre los dos widget */
          SizedBox(width: 30.0),
          //**Widget que se adapta al espacio restante, despues de la imagen
          //**Donde se pone el titulo y subtitulo
          Flexible(
            //Esta columna contendra informacion de la pelicula
            child: Column(
              //Para que el texto inicie  de la izquierda y no centrado
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  movie.title,
                  //Temas de texto
                  style: Theme.of(context).textTheme.title,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  movie.originalTitle,
                  style: Theme.of(context).textTheme.subhead,
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(
                      movie.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subhead,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _movieDescription(Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _createCasting(Movie movie) {
    final movieProvider = new MoviesProvider();
    movieProvider.getCast(movie.id.toString());

    return FutureBuilder(
      future: movieProvider.getCast(movie.id.toString().trim()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _createActorsPageView(snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _createActorsPageView(List<Actor> data) {
    //**Page view builder que hace scroll de manera horizontal, para ver los actores */
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        //Funciona al hacer scroll se mantiene en movimiento el scroll
        pageSnapping: false,
        itemCount: data.length,
        controller: PageController(viewportFraction: 0.3, initialPage: 1),
        itemBuilder: (context, i) {
          //*Para la creacion de cada tarjeta
          return _actorTarjeta(data[i]);
        },
      ),
    );
  }

  //Funcion que sirve para crear la tarjeta, del actor y su nombre
  Widget _actorTarjeta(Actor actor) {
    return Container(
      //**Esta columna ira el actor foto y nombre  */
      child: Column(
        children: <Widget>[
          //Para dar border a cada imagen
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
                image: NetworkImage(actor.getPhoto()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                height: 150.0,
                //Adapta al imagen para que, ninguna imagen se vea pequenia o grande. todos igualados
                fit: BoxFit.cover),
          ),
          Text(
            actor.name,
            //*Si la longitud de la letra es muy largo, esta propiedad lo pone '...'
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
