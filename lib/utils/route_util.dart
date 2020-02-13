import 'package:flutter/material.dart';
import 'package:innovation_flutter_app/models/category.dart';
import 'package:innovation_flutter_app/pages/addTask/createTaskPage.dart';
import 'package:innovation_flutter_app/pages/categoriesPage/categoriesView.dart';
import 'package:innovation_flutter_app/pages/categoriesPage/insertCategory.dart';
import 'package:innovation_flutter_app/pages/categoryFullView/categoryFullViewPage.dart';

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

  static void createTaskPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateTaskPage(),
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
}
