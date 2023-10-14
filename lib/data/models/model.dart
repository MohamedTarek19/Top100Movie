class TopImdbMovies {
  late int rank;
  late String title;
  late String description;
  late String image;
  late List<dynamic> genre;
  late String rating;
  late String id;
  late int year;

  TopImdbMovies.fromjson(Map<String, dynamic> json) {
    rank = json['rank'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    genre = json['genre'];
    rating = json['rating'];
    id = json['id'];
    year = json['year'];
  }
}
