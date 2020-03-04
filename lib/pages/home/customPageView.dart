import 'package:flutter/material.dart';
import 'package:innovation_flutter_app/bloc/categoryBloc.dart';
import 'package:innovation_flutter_app/pages/home/customPage.dart';
import 'package:innovation_flutter_app/widgets/ScreenTransition.dart';
import 'package:provider/provider.dart';

class CustomPageView extends StatefulWidget {
  @override
  _CustomPageViewState createState() => _CustomPageViewState();
}

class _CustomPageViewState extends State<CustomPageView> {
  final PageController pageController = PageController(viewportFraction: 0.95);

  int currentPage = 0;
  RevealData revealData;

  @override
  void initState() {
    pageController.addListener(() {
      int next = pageController.page.round();
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryBloc>(
      builder: (_, categoryBloc, __) => PageView.builder(
          scrollDirection: Axis.horizontal,
          controller: pageController,
          itemCount: categoryBloc.categories.length,
          itemBuilder: (context, int index) {
            bool active = index == currentPage;
            return CustomPage(
              category: categoryBloc.categories[index],
              active: active,
            );
          }),
    );
  }
}
