import 'package:flutter/material.dart';
import '../MovieDatabase.dart';
import '../views/gridMovieItem.dart';

final database = DatabaseProvider();

class PopularMoviesScreen extends StatefulWidget {
  const PopularMoviesScreen({Key? key}) : super(key: key);

  @override
  State<PopularMoviesScreen> createState() => _PopularMoviesScreenState();
}

class _PopularMoviesScreenState extends State<PopularMoviesScreen> {
  List<Movie>? _movies;
  int columnCount = 1;
  List<Widget> items = <Widget>[
    Column(
      children: const [CircularProgressIndicator()],
    )
  ];

  Future<void> getMovies() async {
    // database.open();
    _movies = await database.movies();
    print("movies");
    setState(() {
      if (_movies != null) {
        items = _movies!.map<Widget>((movie) {
          return GridMovieItem(
            movie: movie,
          );
          // return Text(movie.title);
        }).toList();
        return;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMovies();
  }

  @override
  Widget build(BuildContext context) {

    if(MediaQuery. of(context).size.width > 600)
      columnCount = 2;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: const Text("Popular movies", style: TextStyle(fontSize: 24),),
          padding: EdgeInsets.only(top: 16, bottom: 16, left: 16),
        ),
        Expanded(
          child: GridView.count(
            restorationId: 'grid_view_demo_grid_offset',
            crossAxisCount: columnCount,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            padding: const EdgeInsets.all(8),
            childAspectRatio: 2,
            children: items,
          ),
        ),
      ],
    ));
  }
}