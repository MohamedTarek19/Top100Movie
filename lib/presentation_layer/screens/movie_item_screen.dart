import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider_riverpod/data/models/model.dart';

class MovieItemScreen extends StatelessWidget {
  TopImdbMovies MovieItem;
  late String geners;

  MovieItemScreen({Key? key, required this.MovieItem}) : super(key: key);

  Widget buildSliverAppBar(double width ,Orientation orientation) {
    return SliverAppBar(
      expandedHeight: orientation == Orientation.portrait?500:300,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Container(
            width: width,
            color: const Color.fromRGBO(0, 0, 0, 0.5),
            child: Padding(
              padding: orientation == Orientation.portrait?const EdgeInsets.all(0): const EdgeInsets.only(left: 50),
              child: Text('${MovieItem.title}',
                textAlign: orientation == Orientation.portrait? TextAlign.center:TextAlign.start,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 19),
              ),
            )),
        background: Hero(
          tag: MovieItem.title,
          child: CachedNetworkImage(
            imageUrl: MovieItem.image,
            fit: orientation == Orientation.portrait?BoxFit.fill: BoxFit.fitHeight,
            //placeholder:(context, url) => Lottie.asset('assets/imageLoading.json',fit: BoxFit.fill),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    geners = '';
    MovieItem.genre.forEach((element) {
      geners+= (element +', ');
    });
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(MediaQuery.of(context).size.width,MediaQuery.of(context).orientation),
          SliverList(delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).orientation == Orientation.portrait?
                  MediaQuery.of(context).size.height*0.8:
                  MediaQuery.of(context).size.height*1.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Description : ',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,),),
                      SizedBox(width: MediaQuery.of(context).size.width,child: SingleChildScrollView(child: Text('\n${MovieItem.description}',style: const TextStyle(fontSize: 15,),))),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Release year: ',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,),),
                      SizedBox(width: MediaQuery.of(context).size.width,child: SingleChildScrollView(child: Text('\n${MovieItem.year}',style: const TextStyle(fontSize: 15,),))),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Genere: ',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,),),
                      SizedBox(width: MediaQuery.of(context).size.width,child: SingleChildScrollView(child: Text('\n[${geners}]',style: const TextStyle(fontSize: 15,),))),

                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Rating: ',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,),),
                      SizedBox(width: MediaQuery.of(context).size.width,child: SingleChildScrollView(child: Text('\n[${MovieItem.rating} / 10]',style: const TextStyle(fontSize: 15,),))),

                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Rank: ',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,),),
                      SizedBox(width: MediaQuery.of(context).size.width,child: SingleChildScrollView(child: Text('\n[${MovieItem.rank}]',style: const TextStyle(fontSize: 15,),))),

                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Level: ',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,),),
                      SizedBox(width: MediaQuery.of(context).size.width,child: SingleChildScrollView(child: Text('\n[${MovieItem.id}]',style: const TextStyle(fontSize: 15,),))),


                    ],
                  ),
                ),
              ),
            ]
          ))
        ],
      ),
    );
  }
}
