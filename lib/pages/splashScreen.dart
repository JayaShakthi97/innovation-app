import 'package:flutter/material.dart';
import 'package:innovation_flutter_app/bloc/categoryBloc.dart';
import 'package:innovation_flutter_app/bloc/taskBloc.dart';
import 'package:innovation_flutter_app/utils/route_util.dart';
import 'package:innovation_flutter_app/widgets/bodyContainer.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Provider.of<CategoryBloc>(context, listen: false).getCategories();
    Provider.of<TaskBloc>(context, listen: false).getTodayTasks();
    Provider.of<TaskBloc>(context, listen: false).getTomorrowTasks();
    Provider.of<TaskBloc>(context, listen: false).getUpcomingTasks();
    Future.delayed(Duration(milliseconds: 600))
        .then((_) => RouteUtil.homePage(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyContainer(
        child: Center(
          child: Text("ToDo App"),
        ),
      ),
    );
  }
}
