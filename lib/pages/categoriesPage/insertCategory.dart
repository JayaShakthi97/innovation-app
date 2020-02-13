import 'package:flutter/material.dart';
import 'package:innovation_flutter_app/bloc/categoryBloc.dart';
import 'package:innovation_flutter_app/models/category.dart';
import 'package:provider/provider.dart';

class InsertCategoryPage extends StatelessWidget {
  void _insertCategory(BuildContext context) {
    Provider.of<CategoryBloc>(context, listen: false)
        .insertCategory(new Category("New new", Icons.comment, Colors.amber));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RaisedButton(
          onPressed: () {
            _insertCategory(context);
            Navigator.pop(context);
          },
          child: Text('Insert'),
        ),
      ),
    );
  }
}
