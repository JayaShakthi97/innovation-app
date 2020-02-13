import 'package:flutter/material.dart';
import 'package:innovation_flutter_app/models/category.dart';
import 'package:innovation_flutter_app/repository/categoryRepository.dart';

class CategoryBloc with ChangeNotifier {
  final CategoryRepository _categoryRepository = new CategoryRepository();

  List<Category> _categoryList = [];
  bool _loading = true;

  List<Category> get categories => _categoryList;

  bool get isLoading => _loading;

  getCategories() async {
    this._categoryList = await this._categoryRepository.getCategories();
    this.loading = false;
  }

  insertCategory(Category category) async {
    this.loading = true;
    await _categoryRepository.insertCategory(category);
    getCategories();
  }

  set loading(bool value) {
    this._loading = value;
    notifyListeners();
  }
}
