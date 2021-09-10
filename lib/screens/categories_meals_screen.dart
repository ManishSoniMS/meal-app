import 'package:flutter/material.dart';
import '../model/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  final List<Meal> availableMeals;
  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String? categoryTitle;
  List<Meal>? displayedMeals;

  bool _loadedInitData = false;

  /// initState doesn't contain context as it runs before the widget is created.
  @override
  void initState() {
    super.initState();
  }

  /// didChangeDependencies is similar to initState function.
  /// however, didChangeDependencies contains context.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    /// ModelRoute is use to pass arguments without using constructors.
    /// since the data is coming from a widget it contains context.
    if (!_loadedInitData) {
      final routeArgs =
      ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      final String? categoryId = routeArgs["id"];
      categoryTitle = routeArgs["title"];
      displayedMeals = widget.availableMeals
          .where(
            (meal) => meal.categories.contains(categoryId),
      )
          .toList();
      _loadedInitData = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      body: ListView.builder(
        itemCount: displayedMeals!.length,
        itemBuilder: (context, index) {
          return MealItem(
            id: displayedMeals![index].id,
            title: displayedMeals![index].title,
            imageURL: displayedMeals![index].imageUrl,
            duration: displayedMeals![index].duration,
            complexity: displayedMeals![index].complexity,
            affordability: displayedMeals![index].affordability,
            // removeItem: _removeMeal,
          );
        },
      ),
    );
  }
}
