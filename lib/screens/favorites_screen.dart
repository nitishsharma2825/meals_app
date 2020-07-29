import 'package:flutter/material.dart';
import 'package:mealsapp/models/meals.dart';
import '../widgets/meals_item.dart';

class FabScreen extends StatelessWidget {
  final List<Meal> favouriteMeals;
  FabScreen(this.favouriteMeals);

  @override
  Widget build(BuildContext context) {
    if(favouriteMeals==null){
      return Center(
        child: Text('You have no favourite meals - add some'),
      );
    }
    else{
      return ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            id: favouriteMeals[index].id,
            title: favouriteMeals[index].title,
            imageUrl: favouriteMeals[index].imageUrl,
            affordability: favouriteMeals[index].affordability,
            complexity: favouriteMeals[index].complexity,
            duration: favouriteMeals[index].duration,
          );
        },
        itemCount: favouriteMeals.length,
      );
    }
  }
}
