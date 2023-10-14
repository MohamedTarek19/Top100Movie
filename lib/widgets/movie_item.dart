import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider_riverpod/data/models/model.dart';
import 'package:provider_riverpod/presentation_layer/screens/movie_item_screen.dart';

class movieItem extends StatelessWidget {
  double height;
  double width;
  TopImdbMovies topMovie;
  movieItem({
    super.key,
    required this.width,
    required this.height,
    required this.topMovie,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
          return MovieItemScreen(
              MovieItem: topMovie);
        }));
      },
      child: Hero(
        tag: topMovie.title,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: height * 0.2,
            width: width * 0.3,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding:
                          const EdgeInsets.only(bottom: 2.0),
                          child: Container(
                            width: width * 0.4,
                            decoration: BoxDecoration(
                              color: Colors.purple[900],
                              borderRadius:
                              BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius:
                              BorderRadius.circular(20),
                              child: CachedNetworkImage(imageUrl: topMovie.image,
                                fit: BoxFit.fill,
                                placeholder:(context, url) => Lottie.asset('assets/imageLoading.json',fit: BoxFit.fill),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width:width,
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SingleChildScrollView(child: Text('${topMovie.title}')),
                          )),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: this.height*0.001,
                  left: MediaQuery.of(context).orientation == Orientation.portrait?
                  this.width*0.01:this.width*0.001,
                  child: Container(
                    height: MediaQuery.of(context).orientation == Orientation.portrait?
                    this.height*0.04:
                        this.height*0.08
                    ,
                    width: MediaQuery.of(context).orientation == Orientation.portrait?
                    this.width*0.17: this.width*0.1,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      shape:BoxShape.rectangle,
                    ),
                    child: Center(
                      child: Text('${topMovie.id}',style: TextStyle(color: Colors.black,fontSize: 15),),

                    ),
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).orientation == Orientation.portrait?
                  this.height*0.09:this.height*0.19,
                  right: 0,
                  child: Container(
                    height: 30,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20)),
                      color: Colors.grey[900],
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.star,color: Colors.yellow[700], size: 20,),
                          Text('${topMovie.rating}',style: TextStyle(color: Colors.white,fontSize: 15),),
                        ],
                      ),

                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}