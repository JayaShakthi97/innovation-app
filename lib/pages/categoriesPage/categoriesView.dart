import 'package:flutter/material.dart';
import 'package:innovation_flutter_app/bloc/categoryBloc.dart';
import 'package:innovation_flutter_app/models/category.dart';
import 'package:innovation_flutter_app/pages/categoriesPage/dialogBox.dart';
import 'package:innovation_flutter_app/widgets/bodyContainer.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  void initState() {
    Provider.of<CategoryBloc>(context, listen: false).getCategories();
    super.initState();
  }

  void _newCategoryFormDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CategoryFormDialog();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryBloc>(builder: (_, category, __) {
      print('building');
      return Scaffold(
        body: BodyContainer(
          child: Column(children: <Widget>[
            Expanded(
              child: category.isLoading == true
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : category.categories.length > 0
                      ? ListView.builder(
                          itemCount: category.categories.length,
                          itemBuilder: (context, index) => CategoryItem(
                              category: category.categories[index]),
                        )
                      : Center(
                          child: Text("No Categories"),
                        ),
            ),
            Row(children: <Widget>[
              Expanded(
                child: Container(
                  child: FloatingActionButton.extended(
                      onPressed: () => _newCategoryFormDialog(),
                      label: Text('Add Category')),
                ),
              ),
            ]),
          ]),
        ),
      );
    });
  }
}

class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: <Widget>[
        Icon(category.icon),
        Text(category.title),
        Container(
          height: 20.0,
          width: 40.0,
          color: category.color,
        ),
      ]),
    );
  }
}
