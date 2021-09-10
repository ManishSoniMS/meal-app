import 'package:flutter/material.dart';
import './dummy_data.dart';
import './model/meal.dart';
import './my_routes.dart';
import './screens/categories_meals_screen.dart';
import './screens/categories_screen.dart';
import './screens/filters_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    "Gluten": false,
    "Vegan": false,
    "Vegetarian": false,
    "Lactose": false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters["Gluten"] == true && !meal.isGlutenFree) {
          return false;
        }
        if (_filters["Vegan"] == true && !meal.isVegan) {
          return false;
        }
        if (_filters["Vegetarian"] == true && !meal.isVegetarian) {
          return false;
        }
        if (_filters["Lactose"] == true && !meal.isLactoseFree) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  bool _isMealFavourite(String id) {
    return _favouriteMeals.any((meal) => meal.id == id);
  }

  void _toggleFavourite(String mealId) {
    final existingIndex = _favouriteMeals.indexWhere(
      (meal) => meal.id == mealId,
    );
    if (existingIndex >= 0) {
      setState(() {
        _favouriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favouriteMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: "Raleway",
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: "RobotoCondensed",
                fontWeight: FontWeight.bold,
              ),
            ),
      ),

      /// initialRoute: "/", /// default value "/"
      routes: {
        MyRoutes.tabs_screen: (context) => TabsScreen(_favouriteMeals),
        MyRoutes.category_screen: (context) => CategoriesScreen(),
        MyRoutes.category_meals: (context) =>
            CategoryMealsScreen(_availableMeals),
        MyRoutes.meal_detail: (context) =>
            MealDetailScreen(_toggleFavourite, _isMealFavourite),
        MyRoutes.filter_screen: (context) =>
            FilterScreen(_filters, _setFilters),
      },
      // onGenerateRoute: (settings){
      //   print(settings.arguments);
      //   if(settings.name =="/home"){
      //     return ...; // navigate  screen
      //   }else if(settings.name =="/settings"){
      //     return ...; // navigate to another screen
      //   }
      // /// will navigate to prescribed screen if no route was mentioned before
      //   return CupertinoPageRoute(builder: (context)=> CategoriesScreen());
      // },
      // /// come in handy when flutter is unable to build a screen with all other measures
      // onUnknownRoute: (settings) {
      //   return CupertinoPageRoute(builder: (context) => CategoriesScreen());
      // },
    );
  }
}
