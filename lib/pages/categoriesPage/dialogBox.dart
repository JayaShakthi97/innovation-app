import 'package:flutter/material.dart';
import 'package:innovation_flutter_app/bloc/categoryBloc.dart';
import 'package:innovation_flutter_app/models/category.dart';
import 'package:innovation_flutter_app/utils/app_constant.dart';
import 'package:provider/provider.dart';

class CategoryFormDialog extends StatefulWidget {
  final Category category;

  const CategoryFormDialog({Key key, this.category}) : super(key: key);

  @override
  _CategoryFormDialogState createState() => _CategoryFormDialogState();
}

class _CategoryFormDialogState extends State<CategoryFormDialog> {
  bool _isUpdating = false;
  final TextEditingController _name = TextEditingController();
  int _selectedIcon = 0;
  int _selectedColor = 0;
  bool _nameValid = true;

  @override
  void initState() {
    if (widget.category != null) {
      _isUpdating = true;
      _name.text = widget.category.title;
      _selectedIcon = AppConstant.ICON_DATA.indexOf(widget.category.icon);
      _selectedColor =
          AppConstant.COLOR_VALUES.indexOf(widget.category.color.value);
    }
    super.initState();
  }

  void _saveCategory() {
    if (_name.text.isEmpty) {
      setState(() {
        _nameValid = false;
      });
      return;
    }
    String categoryName = _name.text;
    IconData iconData = AppConstant.ICON_DATA[_selectedIcon];
    Color color = Color(AppConstant.COLOR_VALUES[_selectedColor]);
    if (!_isUpdating) {
      Provider.of<CategoryBloc>(context, listen: false)
          .insertCategory(new Category(categoryName, iconData, color));
    } else {
      Provider.of<CategoryBloc>(context, listen: false).updateCategory(
          new Category.update(
              widget.category.id, categoryName, iconData, color));
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 600),
        curve: Curves.fastOutSlowIn,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Color(AppConstant.COLOR_VALUES[_selectedColor]),
        ),
        child: Container(
          height: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: TextField(
                  controller: _name,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      hintText: 'Category name',
                      errorText: _nameValid ? null : "Name cannot be empty"),
                ),
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: AppConstant.ICON_DATA.length,
                  itemBuilder: (_, index) => IconButton(
                      iconSize: 35.0,
                      icon: Icon(AppConstant.ICON_DATA[index]),
                      color: _selectedIcon == index ? Colors.blue : null,
                      onPressed: () {
                        setState(() {
                          _selectedIcon = index;
                        });
                      }),
                ),
              ),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: AppConstant.COLOR_VALUES.length,
                  itemBuilder: (_, index) => InkWell(
                    onTap: () {
                      setState(() {
                        _selectedColor = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      padding: EdgeInsets.all(10),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: _selectedColor == index
                                ? Colors.blue
                                : Colors.white,
                            width: 2.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(AppConstant.COLOR_VALUES[index]),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Row(children: <Widget>[
                Expanded(
                  child: Container(
                    child: FloatingActionButton.extended(
                        onPressed: () => _saveCategory(),
                        label: Text('Add Category')),
                  ),
                ),
              ]),
            ]),
          ),
        ),
      ),
    );
  }
}
