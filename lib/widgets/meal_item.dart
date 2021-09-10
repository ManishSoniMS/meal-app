import 'package:flutter/material.dart';
import '../model/meal.dart';
import '../my_routes.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageURL;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  ///use this function to delete recipes from list of favourites

  const MealItem({
    required this.id,
    required this.title,
    required this.imageURL,
    required this.duration,
    required this.complexity,
    required this.affordability,
  });

  String get complexityText {
    switch (complexity) {
      case Complexity.Simple:
        return "Simple";
      // break;
      case Complexity.Challenging:
        return "Challenging";
      // break;
      case Complexity.Hard:
        return "Hard";
      // break;
      default:
        return "Unknown";
    }
  }

  String get affordabilityText {
    switch (affordability) {
      case Affordability.Affordable:
        return "Affordable";
      // break;
      case Affordability.Pricey:
        return "Pricey";
      // break;
      case Affordability.Luxurious:
        return "Luxurious";
      // break;
      default:
        return "Unknown";
    }
  }

  /// argument pass through pop method provides future
  /// which can be access by .then((event) => null) method
  /// the value passed through pop method will stored in event
  void selectMeal(BuildContext context) {
    Navigator.of(context)
        .pushNamed(
      MyRoutes.meal_detail,
      arguments: id,
    )
        .then(
      (result) {
        if (result != null) {
          // removeItem(result);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    imageURL,
                    height: deviceHeight * 0.3,
                    width: deviceWidth,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: deviceHeight * 0.025,
                  right: deviceWidth * 0.025,
                  child: Container(
                    width: deviceWidth * 0.7,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(
                      vertical: deviceHeight * 0.01,
                      horizontal: deviceWidth * 0.05,
                    ),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.schedule),
                      SizedBox(width: 8),
                      Text("$duration min"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.work),
                      SizedBox(width: 8),
                      Text(complexityText),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.money),
                      SizedBox(width: 8),
                      Text(affordabilityText),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
