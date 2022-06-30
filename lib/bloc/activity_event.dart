part of 'activity_bloc.dart';

@immutable
abstract class ActivityEvent {}

class LoadActivityEvent extends ActivityEvent{}

class AddActivityEvent extends ActivityEvent{
  final Activity activity;

  AddActivityEvent(this.activity);
  
}
