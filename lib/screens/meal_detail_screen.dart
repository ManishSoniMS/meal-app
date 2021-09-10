import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  final toggleFavourite;
  final isMealFavourite;
  MealDetailScreen(this.toggleFavourite, this.isMealFavourite);

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text("${selectedMeal.title}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: deviceHeight * 0.3,
              width: deviceWidth,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTile(deviceHeight, context, "Ingredients"),
            buildContainer(
              deviceHeight,
              deviceWidth,
              ListView.builder(
                itemCount: selectedMeal.ingredients.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: deviceHeight * 0.01,
                          horizontal: deviceWidth * 0.03),
                      child: Text("${selectedMeal.ingredients[index]}"),
                    ),
                  );
                },
              ),
            ),
            buildSectionTile(deviceHeight, context, "Steps"),
            buildContainer(
              deviceHeight,
              deviceWidth,
              ListView.builder(
                itemCount: selectedMeal.steps.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: deviceHeight * 0.01,
                          horizontal: deviceWidth * 0.03),
                      leading: CircleAvatar(
                        child: Text("# ${index + 1}"),
                      ),
                      title: Text("${selectedMeal.steps[index]}"),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: deviceHeight * 0.04),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isMealFavourite(mealId) ? Icons.star : Icons.star_border_outlined,
        ),
        onPressed: () => toggleFavourite(mealId),
        //     () {
        //   ///can pass any data through pop method to last screen
        //   Navigator.of(context).pop(mealId);
        // },
      ),
    );
  }

  Widget buildSectionTile(
      double deviceHeight,
      BuildContext context,
      String text,
      ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.01),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(
      double deviceHeight,
      double deviceWidth,
      Widget child,
      ) {
    return Container(
      width: deviceWidth * 0.8,
      height: deviceHeight * 0.27,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(deviceWidth * 0.02),
      child: child,
    );
  }
}
