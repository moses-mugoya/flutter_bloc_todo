import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/models/activity.dart';
import 'package:todo/repository/activity_repository.dart';
import 'package:todo/utilities/activity_tile.dart';

import '../bloc/activity_bloc.dart';

class ActivityListTemplate extends StatefulWidget {
  const ActivityListTemplate({Key? key}) : super(key: key);

  @override
  State<ActivityListTemplate> createState() => _ActivityListTemplateState();
}

class _ActivityListTemplateState extends State<ActivityListTemplate> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ActivityBloc>(
      create: (context) =>
          ActivityBloc(RepositoryProvider.of<ActivityRepository>(context))
            ..add(LoadActivityEvent()),
      child: BlocBuilder<ActivityBloc, ActivityState>(
        builder: (context, state) {
          if(state is ActivityErrorState){
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(fontSize: 16, color: Colors.red),
              ),
            );

          }else if(state is ActivitiesLoaded){
            return ListView.builder(
            itemCount: state.activities.length,
            itemBuilder: (context, index) {
              return ActivityTile(activity: state.activities[index]);
            },
          );
        }
        return const Center(
              child: CircularProgressIndicator()
              );
          
        },
      ),
    );
  }
}
