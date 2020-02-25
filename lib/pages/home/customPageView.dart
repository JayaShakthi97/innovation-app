import 'package:flutter/material.dart';
import 'package:innovation_flutter_app/bloc/categoryBloc.dart';
import 'package:innovation_flutter_app/models/category.dart';
import 'package:innovation_flutter_app/pages/home/customPage.dart';
import 'package:innovation_flutter_app/utils/app_constant.dart';
import 'package:innovation_flutter_app/utils/date_util.dart';
import 'package:innovation_flutter_app/utils/route_util.dart';
import 'package:innovation_flutter_app/widgets/ScreenTransition.dart';
import 'package:provider/provider.dart';

class CustomPageView extends StatefulWidget {
  final String day;
  final DateTime date;

  const CustomPageView({Key key, this.day, this.date}) : super(key: key);

  @override
  _CustomPageViewState createState() => _CustomPageViewState();
}

class _CustomPageViewState extends State<CustomPageView> {
  final PageController pageController = PageController(viewportFraction: 0.9);

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

  _openCategoryFullViewPage(Category category) {
    RouteUtil.categoryFullViewPage(category, widget.day, context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                widget.day +
                    (widget.date == null
                        ? ' '
                        : ' | ' +
                            DateUtil.getFormattedDate(
                                widget.date.millisecondsSinceEpoch)),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: AppConstant.FONT_MEDIUM,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Consumer<CategoryBloc>(
              builder: (_, categoryBloc, __) => SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: pageController,
                    itemCount: categoryBloc.categories.length,
                    itemBuilder: (context, int index) {
                      bool active = index == currentPage;
                      return CustomPage(
                        category: categoryBloc.categories[index],
                        day: widget.day,
                        active: active,
                        onPressed: () => _openCategoryFullViewPage(
                            categoryBloc.categories[index]),
                      );
                    }),
              ),
            ),
          ]),
    );
  }
}
