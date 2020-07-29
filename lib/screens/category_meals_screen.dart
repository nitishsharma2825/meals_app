import 'package:flutter/material.dart';
import 'package:mealsapp/models/meals.dart';
import 'package:mealsapp/widgets/meals_item.dart';
import '../dummy_data.dart';

class CategoryMealScreen extends StatefulWidget {
//  final String id;
//  final String categoryTitle;
//  CategoryMealScreen({this.id,this.categoryTitle});
final List<Meal> availableMeals;
CategoryMealScreen(this.availableMeals);


  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  bool isDatainit = false;

  String categoryTitle;
  String categoryId;
  List categoryMeals;
  @override
  void initState() {  // Perfect for initialisation but we use context inside so build is called every time
//    final routeArgs =
//    ModalRoute.of(context).settings.arguments as Map<String, String>;
//      categoryTitle = routeArgs['title'];
//      categoryId = routeArgs['id'];
//      categoryMeals = DUMMY_MEALS.where((meal) {
//      return meal.categories.contains(categoryId);
//    }).toList();
//    super.initState();
  }
  @override
  void didChangeDependencies() {
    if(isDatainit==false){
      final routeArgs =
      ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      categoryId = routeArgs['id'];
      categoryMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
    }
    isDatainit=true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            id: categoryMeals[index].id,
            title: categoryMeals[index].title,
            imageUrl: categoryMeals[index].imageUrl,
            affordability: categoryMeals[index].affordability,
            complexity: categoryMeals[index].complexity,
            duration: categoryMeals[index].duration,
          );
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
