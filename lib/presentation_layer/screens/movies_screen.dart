import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:provider_riverpod/business_logic/cubit/movies_cubit.dart';
import 'package:provider_riverpod/data/models/model.dart';
import 'package:provider_riverpod/presentation_layer/screens/movie_item_screen.dart';
import 'package:provider_riverpod/widgets/movie_item.dart';

class MoviesScreen extends StatefulWidget {
  MoviesScreen({Key? key}) : super(key: key);

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  late List<TopImdbMovies> allMovies;

  List<TopImdbMovies>? filteredMovies;

  TextEditingController SearchController = TextEditingController();

  bool _isSearching = false;

  void searchForMovies(String input){
    if(input != null || input.isNotEmpty){
      filteredMovies =
          allMovies.where((element) => element.title.toLowerCase().contains(input.toLowerCase())).toList();
    }
  }

  @override
  Widget build(BuildContext context) {

    final currentCount = (MediaQuery.of(context).size.width ~/ 250).toInt();
    final minCount = 4;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('T O P   1 0 0   M O V I E'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.92,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).orientation == Orientation.portrait?
                    MediaQuery.of(context).size.height * 0.06:MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Center(
                        child: TextField(
                          controller: SearchController,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Colors.black,
                            hoverColor: Colors.blue,
                            prefixIcon:_isSearching?IconButton(onPressed: (){
                              setState(() {
                                filteredMovies = [];
                                _isSearching = false;
                                SearchController.text = '';
                              });
                            },icon: const Icon(Icons.cancel_outlined,color: Colors.red,),): null,
                            suffixIcon: const Icon(
                              Icons.search,
                              size: 30,
                            ),
                            suffixIconColor: Colors.black,
                            focusedBorder: InputBorder.none,
                            hintText: 'Search for a Movie',
                            hintStyle: const TextStyle(color: Colors.grey),

                          ),
                          onTap: (){
                            setState(() {
                              if(_isSearching == false||SearchController.text.isEmpty){
                                filteredMovies = [];
                                _isSearching = true;
                              }
                            });
                          },
                          onChanged: (input){
                            setState(() {
                              print('################${input}##################');
                              searchForMovies(input);
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(25)
                    ),
                    height: MediaQuery.of(context).orientation == Orientation.landscape || MediaQuery.of(context).size.height <= 500?
                      MediaQuery.of(context).size.height * 0.59:MediaQuery.of(context).size.height * 0.78,
                    width: MediaQuery.of(context).size.width,
                    child: BlocConsumer<MoviesCubit, MoviesState>(
                      listener: (context,state){
                        allMovies = context.read<MoviesCubit>().Movies ?? [];
                      },
                      builder: (context, state) {
                        return state is MoviesOnLoaded
                            ? GridView.builder(
                          scrollDirection: MediaQuery.of(context).orientation == Orientation.landscape ||
                          MediaQuery.of(context).size.height<=500?
                          Axis.horizontal: Axis.vertical,
                                itemCount:_isSearching? filteredMovies?.length:
                                    context.read<MoviesCubit>().Movies?.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return movieItem(
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height,
                                      topMovie:_isSearching? filteredMovies![index] : context.read<MoviesCubit>().Movies![index]);
                                },
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisExtent: MediaQuery.of(context).orientation == Orientation.portrait? 250 :200,
                                        crossAxisCount:
                                        MediaQuery.of(context).orientation == Orientation.portrait?
                                        (MediaQuery.of(context).size.width <= 300 || MediaQuery.of(context).size.height <= 500? 1:
                                        MediaQuery.of(context).size.width <= 380? 2:
                                        MediaQuery.of(context).size.width <= 520? 3:4
                                        ) : 1,
                                        // childAspectRatio: (MediaQuery.of(context).size.width /
                                        //     MediaQuery.of(context).size.height / 1.4),
                                        // ((MediaQuery.of(context).size.width * 0.3) /
                                        //     (MediaQuery.of(context).size.height * 0.2)),
                                    ),
                              )
                            : state is MoviesOnLoading
                                ? Lottie.asset('assets/loading.json',
                                    fit: BoxFit.fill)
                                : Text('${state is MoviesOnError?}');
                      },
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
