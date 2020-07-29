import 'package:flutter/material.dart';
import 'package:mealsapp/models/meals.dart';
import '../widgets/MainDrawer.dart';
import './categories_screen.dart';
import './favorites_screen.dart';

class TabScreen extends StatefulWidget {
  final List<Meal> favouriteMeals;
  TabScreen(this.favouriteMeals);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String,Object>> pages;
  int selectedIndex=0;
  @override
  void initState() {
    pages=[
      {
        'page':CategoriesScreen(),
        'title':'Categories'
      },
      {
        'page':FabScreen(widget.favouriteMeals),
        'title':'Favourites'
      }
    ];
    super.initState();
  }
  void _selectPages(int index){
  setState(() {
    selectedIndex=index;
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pages[selectedIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: pages[selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).accentColor,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          currentIndex: selectedIndex,
          onTap: _selectPages,
          items: [
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).primaryColor,
          icon: Icon(Icons.category),
          title: Text('Categories')
        ),
        BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            title: Text('Favourites')
        ),
      ]),
    );
  }
}
