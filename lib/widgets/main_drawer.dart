import 'package:flutter/material.dart';

import '../my_routes.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  Widget buildListTile({
    required String routeName,
    required IconData icon,
    required String text,
  }) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushReplacementNamed(routeName);
      },
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 24,
          fontFamily: "RobotoCondensed",
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Drawer(
      child: Column(
        children: [
          Container(
            height: deviceHeight * 0.2,
            width: deviceWidth,
            color: Theme.of(context).accentColor,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(deviceWidth * 0.05),
            child: Text(
              "Cooking Up!",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(height: deviceHeight * 0.02),
          buildListTile(
            routeName: MyRoutes.tabs_screen,
            icon: Icons.restaurant,
            text: "Meals",
          ),
          buildListTile(
            routeName: MyRoutes.filter_screen,
            icon: Icons.settings,
            text: "Filters",
          ),
        ],
      ),
    );
  }
}
