import 'package:flutter/material.dart';
import 'package:next_movie_app/config/themes/app_themes.dart';
import 'package:next_movie_app/utils/constants/router_strings/router_strings.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({
    Key? key,
  }) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, RouterStrings.favoriteRoute);
        break;
      case 1:
        Navigator.pushNamed(context, RouterStrings.searchRoute);
        break;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).bottomAppBarColor,
      selectedItemColor: AppThemes.darkSecondaryColor,
      unselectedItemColor: AppThemes.darkSecondaryColor,
      // currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.star_border_rounded),
          label: 'Favorite',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_sharp),
          label: 'Search',
        )
      ],
    );
  }
}
