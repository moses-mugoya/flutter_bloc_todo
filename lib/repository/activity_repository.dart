
import 'package:dio/dio.dart';
import 'package:todo/models/activity.dart';
import 'package:todo/network/dio_client.dart';

class ActivityRepository{

  DioClient dioClient = DioClient();

  Future<List<Activity>> getActivities() async{
    Response response = await dioClient.getRequest('/activities/list');


    final body = response.data;
    List<Activity> activities = body
          .map<Activity>(
            (dynamic item) => Activity.fromJson(item),
          )
          .toList(); 
      return activities;
  }

  Future<void> addActivity(name, description) async{
     var activity = {'name': name, 'description': description};
     Response response = await dioClient.postRequest('/activities/create/', activity);
     final body = response.data;
    return body;
  }

}