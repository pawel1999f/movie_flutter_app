import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseProvider {

  // late Database database;

  Future<Database> open() async {
    // Avoid errors caused by flutter upgrade.
    // Importing 'package:flutter/widgets.dart' is required.
    // WidgetsFlutterBinding.ensureInitialized();
    // Open the database and store the reference.
    return openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'movie_database.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) async {
        // Run the CREATE TABLE statement on the database.
        await db.execute(
            'CREATE TABLE news(id INTEGER PRIMARY KEY, title TEXT, text TEXT, publishedOn TEXT, author TEXT, image TEXT)'
        );
        await db.execute(
          'CREATE TABLE movies(id INTEGER PRIMARY KEY, title TEXT, genre TEXT, release INTEGER, director TEXT, image TEXT) '
        );

        // addInitialMovies();
        // addInitialNews();
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    print("opened");
    // print(await news());
  }

    // Define a function that inserts dogs into the database
    Future<void> insertMovie(Movie movie) async {
      // Get a reference to the database.
      final db = await open();

      // Insert the Dog into the correct table. You might also specify the
      // `conflictAlgorithm` to use in case the same dog is inserted twice.
      //
      // In this case, replace any previous data.
      await db.insert(
        'movies',
        movie.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    // Define a function that inserts dogs into the database
    Future<void> insertNews(News news) async {
      // Get a reference to the database.
      final db = await open();

      // Insert the Dog into the correct table. You might also specify the
      // `conflictAlgorithm` to use in case the same dog is inserted twice.
      //
      // In this case, replace any previous data.
      await db.insert(
        'news',
        news.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    // A method that retrieves all the dogs from the dogs table.
    Future<List<Movie>> movies() async {
      // Get a reference to the database.
      final db = await open();

      // Query the table for all The Dogs.
      final List<Map<String, dynamic>> maps = await db.query('movies');

      // Convert the List<Map<String, dynamic> into a List<Dog>.
      return List.generate(maps.length, (i) {
        return Movie(
          id: maps[i]['id'],
          title: maps[i]['title'],
          genre: maps[i]['genre'],
          release: maps[i]['release'],
          director: maps[i]['director'],
          image: maps[i]['image'],
        );
      });
    }

    Future<List<News>> news() async {
      // Get a reference to the database.
      final db = await open();

      // Query the table for all The Dogs.
      final List<Map<String, dynamic>> maps = await db.query('news');

      // Convert the List<Map<String, dynamic> into a List<Dog>.
      return List.generate(maps.length, (i) {
        return News(
          id: maps[i]['id'],
          title: maps[i]['title'],
          text: maps[i]['text'],
          publishedOn: maps[i]['publishedOn'],
          author: maps[i]['author'],
          image: maps[i]['image'],
        );
      });
    }

    Future<void> addInitialMovies() async {
      var lotr1 = const Movie(
        id: 0,
        title: 'WŁADCA PIERŚCIENI: DRUŻYNA PIERŚCIENIA',
        genre: 'Fantasy',
        release: 2001,
        director: 'Peter Jackson',
        image: 'https://picsum.photos/id/1074/400/400',
      );

      var lotr2 = const Movie(
        id: 1,
        title: 'WŁADCA PIERŚCIENI: DWIE WIEŻE',
        genre: 'Fantasy',
        release: 2002,
        director: 'Peter Jackson',
        image: 'https://picsum.photos/id/1074/400/400',
      );

      var starwars6 = const Movie(
        id: 2,
        title: 'GWIEZDNE WOJNY: CZĘŚĆ VI - POWRÓT JEDI',
        genre: 'Sci-Fi',
        release: 1983,
        director: 'George Lucas',
        image: 'https://picsum.photos/id/1074/400/400',
      );

      var starwars4 = const Movie(
        id: 3,
        title: 'GWIEZDNE WOJNY: CZĘŚĆ IV - NOWA NADZIEJA',
        genre: 'Sci-Fi',
        release: 1977,
        director: 'George Lucas',
        image: 'https://picsum.photos/id/1074/400/400',
      );

      await insertMovie(lotr1);
      await insertMovie(lotr2);
      await insertMovie(starwars6);
      await insertMovie(starwars4);

      print(await movies());
      print("ddd");
    }

    Future<void> addInitialNews() async {
      var news1 = const News(
        id: 0,
        title: 'NEWS 1',
        text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In nec lobortis justo. Vivamus gravida at enim nec pretium. Suspendisse potenti. Fusce euismod urna ac odio scelerisque tempor. Proin tincidunt suscipit venenatis. Sed eu enim finibus, tincidunt mi et, maximus elit. Nullam odio sapien, volutpat non justo vel, varius dapibus arcu. Maecenas vel finibus risus.',
        publishedOn: '20.10.2022',
        author: 'Jan Kowalski',
        image: 'https://picsum.photos/id/1074/400/400',
      );

      var news2 = const News(
        id: 1,
        title: 'NEWS 2',
        text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In nec lobortis justo. Vivamus gravida at enim nec pretium. Suspendisse potenti. Fusce euismod urna ac odio scelerisque tempor. Proin tincidunt suscipit venenatis. Sed eu enim finibus, tincidunt mi et, maximus elit. Nullam odio sapien, volutpat non justo vel, varius dapibus arcu. Maecenas vel finibus risus.',
        publishedOn: '21.10.2022',
        author: 'Jan Kowalski',
        image: 'https://picsum.photos/id/1074/400/400',
      );

      var news3 = const News(
        id: 2,
        title: 'NEWS 3',
        text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In nec lobortis justo. Vivamus gravida at enim nec pretium. Suspendisse potenti. Fusce euismod urna ac odio scelerisque tempor. Proin tincidunt suscipit venenatis. Sed eu enim finibus, tincidunt mi et, maximus elit. Nullam odio sapien, volutpat non justo vel, varius dapibus arcu. Maecenas vel finibus risus.',
        publishedOn: '22.10.2022',
        author: 'Jan Kowalski',
        image: 'https://picsum.photos/id/1074/400/400',
      );

      var news4 = const News(
        id: 3,
        title: 'NEWS 4',
        text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In nec lobortis justo. Vivamus gravida at enim nec pretium. Suspendisse potenti. Fusce euismod urna ac odio scelerisque tempor. Proin tincidunt suscipit venenatis. Sed eu enim finibus, tincidunt mi et, maximus elit. Nullam odio sapien, volutpat non justo vel, varius dapibus arcu. Maecenas vel finibus risus.',
        publishedOn: '23.10.2022',
        author: 'Jan Kowalski',
        image: 'https://picsum.photos/id/1074/400/400',
      );

      await insertNews(news1);
      await insertNews(news2);
      await insertNews(news3);
      await insertNews(news4);

      print(await news());
    }
}

class Movie {
  final int id;
  final String title;
  final String genre;
  final int release;
  final String director;
  final String image;

  const Movie({
    required this.id,
    required this.title,
    required this.genre,
    required this.release,
    required this.director,
    required this.image,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'genre': genre,
      'release': release,
      'director': director,
      'image': image,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Movie{id: $id, title: $title, genre: $genre, release: $release, director: $director, image: $image}';
  }
}

class News {
  final int id;
  final String title;
  final String text;
  final String publishedOn;
  final String author;
  final String image;

  const News({
    required this.id,
    required this.title,
    required this.text,
    required this.publishedOn,
    required this.author,
    required this.image,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'text': text,
      'publishedOn': publishedOn,
      'author': author,
      'image': image,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'News{id: $id, title: $title, text: $text, publishedOn: $publishedOn, author: $author, image: $image}';
  }
}