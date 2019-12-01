import 'package:flutter/material.dart';
import 'package:flutter_movie/src/providers/movie_provider.dart';
import 'package:flutter_movie/src/widgets/card_swiper_widget.dart';
import 'package:flutter_movie/src/widgets/movie_horizontal.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    moviesProvider.getPopularity();
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies on Cinema'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      // el texto del hello world, baja a la zona segura y no se muestra en el encabezado
      // body: SafeArea(
      //   child: Text('Hello Word!!!!!!!!!!!!!!'),
      // ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
            _footer(context),
          ],
        ),
      ),
    );
  }

  Widget _swiperTarjetas() {
    moviesProvider.getEnCines();
    return FutureBuilder(
      future: moviesProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(
            movies: snapshot.data,
          );
        } else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return new Container(
      //todo el ancho
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //**Ajustando el texto  padding */
          Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Popularity  Movies',
                //Configurar de  una manera global toda la  aplicacion, asignando estilos generales
                style: Theme.of(context).textTheme.subhead,
              )),
          SizedBox(
            height: 5.0,
          ),
          //Se ejecuta cada vez que introduzcan informacion al stream
          StreamBuilder(
            //obteniendo los valores
            stream: moviesProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              //Imprimimos la lista de Peliculas el titulo
              // snapshot.data?.forEach((p) => print(p.title));
              if (snapshot.hasData) {
                return MovieHorizontal(
                  movies: snapshot.data,
                  //Ejecuta la siguiente pagina segun el scroll
                  siguientePagina: moviesProvider.getPopularity,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          //**  El future builder solo se ejecuta una vez */
          // FutureBuilder(
          //   future: moviesProvider.getPopularity(),
          //   builder: (BuildContext context, AsyncSnapshot snapshot) {
          //     //Imprimimos la lista de Peliculas el titulo
          //     // snapshot.data?.forEach((p) => print(p.title));
          //     if (snapshot.hasData) {
          //       return MovieHorizontal(movies: snapshot.data);
          //     } else {
          //       return Center(child: CircularProgressIndicator());
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}
