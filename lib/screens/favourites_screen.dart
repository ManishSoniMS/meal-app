import 'package:flutter/material.dart';
import '../model/meal.dart';
import '../widgets/meal_item.dart';

class FavouritesScreen extends StatelessWidget {
  final List<Meal> favouriteMeals;
  FavouritesScreen(this.favouriteMeals);

  @override
  Widget build(BuildContext context) {
    return favouriteMeals.isEmpty
        ? Center(
            child: Text("You have no favourite yet - start adding some!"),
          )
        : ListView.builder(
            itemCount: favouriteMeals.length,
            itemBuilder: (context, index) {
              return MealItem(
                id: favouriteMeals[index].id,
                title: favouriteMeals[index].title,
                imageURL: favouriteMeals[index].imageUrl,
                duration: favouriteMeals[index].duration,
                complexity: favouriteMeals[index].complexity,
                affordability: favouriteMeals[index].affordability,
              );
            },
          );
  }
}
