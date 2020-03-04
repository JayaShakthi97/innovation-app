import 'package:flutter/material.dart';
import 'package:innovation_flutter_app/models/category.dart';
import 'package:innovation_flutter_app/pages/addTask/createTaskPage.dart';
import 'package:innovation_flutter_app/pages/categoriesPage/categoriesView.dart';
import 'package:innovation_flutter_app/pages/categoriesPage/insertCategory.dart';
import 'package:innovation_flutter_app/pages/categoryFullView/categoryFullViewPage.dart';
import 'package:innovation_flutter_app/pages/chat/chatPage.dart';
import 'package:innovation_flutter_app/pages/chat/personPage.dart';
import 'package:innovation_flutter_app/pages/home/home.dart';

class RouteUtil {
  static void categoryFullViewPage(
      Category category, String day, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryFullViewPage(
          category: category,
          day: day,
        ),
      ),
    );
  }

  static void createTaskPage(BuildContext context, {bool updating}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateTaskPage(isUpdating: updating),
      ),
    );
  }

  static void categoryPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoriesPage(),
      ),
    );
  }

  static void insertCategoryPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InsertCategoryPage(),
      ),
    );
  }

  static void homePage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  static void chatPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(),
      ),
    );
  }

  static void personPage(BuildContext context, String name) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PersonPage(
          name: name,
        ),
      ),
    );
  }
}
