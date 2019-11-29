import 'package:flutter/material.dart';
import 'package:flutter_movie/src/models/movie_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

//Estaq clase es un  widget personalizado,  de swiper de tarjetas (carrusel)
class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

//Constructor, al  momento de invocar esta clase  la propiedad movies es requerido
  CardSwiper({@required this.movies});
  @override
  Widget build(BuildContext context) {
    //Cada movil tiene diferente tamanio  con este media query lo compatibilizamos con todos
    final screenSize = MediaQuery.of(context).size;

    return Container(
      //dando padding topa los item del swiper
      padding: EdgeInsets.only(top: 10.0),

      //usa todo el ancho posible
      // width: double.infinity,

      child: Swiper(
        itemHeight: screenSize.height * 0.5,
        //el tamanio delos items para el carrusel (swiper)
        itemWidth: screenSize.width * 0.7,
        itemBuilder: (BuildContext context, int index) {
          //Customizando los items y dando borders a  la imagen
          return ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              //traemos la imagen del servicio web, con el metodo de  la clase. y usando el index del teambuilder
              child: ClipRect(
                child: FadeInImage(
                  image: NetworkImage(movies[index].getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  //la imagen se adapta a todo el ancho que tiene
                  fit: BoxFit.cover,
                ),
              ));
        },
        itemCount: movies.length,
        //modo de carrusel
        layout: SwiperLayout.STACK,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }
}
