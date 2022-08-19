import 'package:flutter/material.dart';
import 'package:newsapp/view/details_screen.dart';
import 'package:newsapp/view/favorites_screen.dart';
import 'package:newsapp/view/news_screen.dart';

int _selectedIndex = 0;

class MyBottomNavigationBar extends StatefulWidget {
  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

Route _createRouteNewsScreen() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => NewsScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createRouteFavoritesScreen() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        FavoritesScreen(favoriteArticleList),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        backgroundColor: Color(0xFF232946),
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent[100],
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.home,
            ),
            label: "News",
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.favorite_border_sharp,
            ),
            label: "Favorites",
          ),
        ],
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
          if (_selectedIndex == 0) {
            Navigator.pushReplacement(context, _createRouteNewsScreen());
          } else if (_selectedIndex == 1) {
            Navigator.pushReplacement(context, _createRouteFavoritesScreen());
          }
        });
  }
}
