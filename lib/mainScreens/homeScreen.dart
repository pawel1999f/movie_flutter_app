import 'package:flutter/material.dart';
import 'package:movies_app/homeScreens/popularMovies.dart';
import 'package:movies_app/homeScreens/topMoviesScreen.dart';
import '../MovieDatabase.dart';
import '../homeScreens/newsScreen.dart';
import 'AccountScreen.dart';
import 'SearchScreen.dart';

final database = DatabaseProvider();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  late TabController _tabController;

  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'News'),
    Tab(text: 'Popular'),
    Tab(text: 'Top'),
  ];

  @override
  void initState() {
    super.initState();
    // database.open();
    database.addInitialMovies();
    database.addInitialNews();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("home build");
    var bottomNavigationBarItems = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        icon: Icon(Icons.add_comment),
        label: "aa",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.calendar_today),
        label: "bb",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.account_circle),
        label: "cc",
      ),
    ];

    final bnb = BottomNavigationBar(
      items: bottomNavigationBarItems,
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );

    double width = MediaQuery.of(context).size.width;

    NavigationRail navRail = NavigationRail(
      selectedIndex: _currentIndex,
      // groupAlignment: groupAligment,
      onDestinationSelected: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
      extended: (width > 800),
      destinations: const <NavigationRailDestination>[
        NavigationRailDestination(
          icon: Icon(Icons.favorite_border),
          selectedIcon: Icon(Icons.favorite),
          label: Text('First'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.bookmark_border),
          selectedIcon: Icon(Icons.book),
          label: Text('Second'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.star_border),
          selectedIcon: Icon(Icons.star),
          label: Text('Third'),
        ),
      ],
    );

    if (_currentIndex == 0) {
      if (width > 600) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Tabs Demo'),
            ),
            body: Row(
              children: [
                navRail,
                Expanded(
                    child: Container(
                        padding: EdgeInsets.only(bottom: 16),
                        child: Column(
                          children: [
                            Expanded(child: NewsScreen()),
                            Expanded(child: PopularMoviesScreen()),
                            // Expanded(child: TopMoviesScreen()),
                          ],
                        )))
              ],
            ));
      }

      return Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              controller: _tabController,
              tabs: myTabs,
            ),
            title: const Text('Tabs Demo'),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [NewsScreen(), PopularMoviesScreen(), TopMoviesScreen()],
          ),
          bottomNavigationBar: bnb);
    }

    if (_currentIndex == 1) {
      if (width > 600) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('SearchScreen'),
            ),
            body: Row(
              children: [navRail],
            ));
      }
      return Scaffold(
          appBar: AppBar(
            title: const Text('SearchScreen'),
          ),
          body: const SearchScreen(),
          bottomNavigationBar: bnb);
    }

    if (width > 600) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('AccountScreen'),
          ),
          body: Row(
            children: [navRail],
          ));
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('AccountScreen'),
        ),
        body: const AccountScreen(),
        bottomNavigationBar: bnb);
  }
}
