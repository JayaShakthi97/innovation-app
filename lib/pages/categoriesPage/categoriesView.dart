import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:innovation_flutter_app/bloc/categoryBloc.dart';
import 'package:innovation_flutter_app/models/category.dart';
import 'package:innovation_flutter_app/pages/categoriesPage/dialogBox.dart';
import 'package:innovation_flutter_app/utils/app_constant.dart';
import 'package:innovation_flutter_app/widgets/bodyContainer.dart';
import 'package:innovation_flutter_app/widgets/categoryIcon.dart';
import 'package:innovation_flutter_app/widgets/pageHeader.dart';
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
    return Consumer<CategoryBloc>(builder: (_, categoryBloc, __) {
      return Scaffold(
        body: BodyContainer(
          child: Column(children: <Widget>[
            CategoryViewHeader(),
            Expanded(
              child: categoryBloc.isLoading == true
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : categoryBloc.categories.length > 0
                      ? ListView(children: [
                          ExpansionPanelList(
                            expansionCallback: (index, isExpanded) {
                              setState(() {
                                categoryBloc.categories[index].expanded =
                                    !isExpanded;
                              });
                            },
                            children: categoryBloc.categories
                                .map((category) => ExpansionPanel(
                                      canTapOnHeader: true,
                                      headerBuilder: (context, isExpanded) =>
                                          CategoryItemHeader(
                                        category: category,
                                      ),
                                      body:
                                          CategoryItemBody(category: category),
                                      isExpanded: category.isExpanded,
                                    ))
                                .toList(),
                          ),
                        ])
                      : Center(child: Text("No Categories")),
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

class CategoryViewHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: PageHeader(
        title: "Categories",
        iconData: Icons.arrow_back,
      ),
    );
  }
}

class CategoryItemHeader extends StatelessWidget {
  final Category category;

  const CategoryItemHeader({Key key, @required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Row(children: <Widget>[
        CategoryIcon(
          icon: category.icon,
          color: category.color,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            category.title,
            style: TextStyle(fontSize: AppConstant.FONT_MEDIUM_LARGE),
          ),
        ),
      ]),
    );
  }
}

class CategoryItemBody extends StatelessWidget {
  final Category category;

  const CategoryItemBody({Key key, @required this.category}) : super(key: key);

  void _editCategoryFormDialog(BuildContext context, Category category) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CategoryFormDialog(category: category);
        });
  }

  void _deleteCategory(BuildContext context) {
    Provider.of<CategoryBloc>(context, listen: false)
        .deleteCategory(category.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: <Widget>[
        Expanded(child: Container()),
        IconButton(
          icon: Icon(Icons.edit, color: Colors.blue,),
          onPressed: () => _editCategoryFormDialog(context, category),
        ),
        SizedBox(
          width: 5.0,
        ),
        IconButton(
          icon: Icon(Icons.delete, color: Colors.red,),
          onPressed: () => _deleteCategory(context),
        ),
      ]),
    );
  }
}
