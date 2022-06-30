import 'package:flutter/material.dart';
import 'package:todo/models/activity.dart';


class ActivityTile extends StatelessWidget {
  final Activity? activity;
  const ActivityTile({Key? key, this.activity}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const FlutterLogo(size: 56.0),
        title: Text('${activity?.name}'),
        subtitle: Text('${activity?.description}'),
        trailing: const Icon(Icons.more_vert),
      ),
    );
   
  }
}
