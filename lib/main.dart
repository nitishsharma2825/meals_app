import 'package:flutter/material.dart';
import './screens/filters_screen.dart';
import './dummy_data.dart';
import './models/meals.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import 'screens/category_meals_screen.dart';
import 'screens/categories_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String,bool> _filters= {
    'gluten':false,
    'lactose':false,
    'vegan':false,
    'veg':false
  };
  List<Meal> availableMeals= DUMMY_MEALS;
  List<Meal> favouriteMeals=[];

  void toggleFavMeals(String mealId){
  final existingIndex = favouriteMeals.indexWhere((meal) => mealId==meal.id);
  if(existingIndex>=0){
    setState(() {
      favouriteMeals.removeAt(existingIndex);
    });
  }
  else{
    setState(() {
      favouriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id==mealId));
    });
  }
  }

  bool isFavourite(String id){
    return favouriteMeals.any((meal) => meal.id == id);
  }


  void _setFilters(Map<String,bool> curFilters){
    setState(() {
      _filters = curFilters;
         availableMeals= DUMMY_MEALS.where((meal){
        if(!meal.isGlutenFree&&_filters['gluten']==true){
          return false;
        }
        if(!meal.isLactoseFree&&_filters['lactose']==true){
          return false;
        }
        if(!meal.isVegan&&_filters['vegan']==true){
          return false;
        }
        if(!meal.isVegetarian&&_filters['veg']==true){
          return false;
        }
        return true;
      }).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText2: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          bodyText1: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          headline6: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),

      ),
      //home:CategoriesScreen(),
      routes: { //map<String,Function>
        '/':(context){return TabScreen(favouriteMeals);}, //home route
        '/category-item-meals':(context){return CategoryMealScreen(availableMeals);},
        '/meal-detail':(context){return MealDetailScreen(toggleFavMeals,isFavourite);},
        '/filters-screen':(context){return FilterScreen(_setFilters,_filters);}
      },
      onGenerateRoute: (settings){  //used when routes are generated dynamically and not defined on routes
        print(settings.name); //name of route
        print(settings.arguments);//arguments passed through that route
        return MaterialPageRoute(builder: (context){return CategoriesScreen();});
      },
      onUnknownRoute: (settings){  // when a route is not defined on routes as well as Ongenerateroute, it is used
        return MaterialPageRoute(builder: (context){return CategoriesScreen();});
      },
    );
  }
}

