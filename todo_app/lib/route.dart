import 'package:flutter/material.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/screens/home_screen.dart';
import 'package:to_do_list/screens/task_add_screen.dart';
import 'package:to_do_list/screens/time_task_screen.dart';
import 'package:to_do_list/widgets/task_details_screen.dart';

Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case HomeScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      );
    case TaskAddScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const TaskAddScreen(),
      );
    case TaskDetailsScreen.routeName:
      var task = routeSettings.arguments as Task;
      return MaterialPageRoute(
        builder: (_) => TaskDetailsScreen(
          task: task,
        ),
      );
    case TimeTaskScreen.routeName:
      var name = routeSettings.arguments.toString();
      return MaterialPageRoute(
        builder: (_) => TimeTaskScreen(
          name: name,
        ),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      );
  }
}
