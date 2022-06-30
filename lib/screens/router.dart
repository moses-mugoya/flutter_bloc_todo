// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/screens/activity_list.dart';
import 'package:todo/screens/add_activity.dart';

import '../repository/activity_repository.dart';

class AppRouter {
  Route? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => RepositoryProvider(
                  create: (context) => ActivityRepository(),
                  child: const ActivityList(),
                ));
      case "/addActivity":
        return MaterialPageRoute(
            builder: (_) => RepositoryProvider(
                  create: (context) => ActivityRepository(),
                  child: const AddActivity(),
                ));
      default:
        return null;
    }
  }
}
