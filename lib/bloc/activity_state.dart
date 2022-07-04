// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'activity_bloc.dart';

@immutable
abstract class ActivityState {}

class ActivityInitial extends ActivityState {}

class ActivityLoading extends ActivityState {}

class ActivityAddedLoading extends ActivityState{}

class ActivityErrorState extends ActivityState {

  final String message;
  ActivityErrorState({
    required this.message,
  });

}

class ActivitiesLoaded extends ActivityState{
  final List<Activity> activities;
  ActivitiesLoaded(this.activities);

}

class ActivityAddedErrorState extends ActivityState {

  var message;
  String errType;
  ActivityAddedErrorState({
    required this.message,
    required this.errType
  });

}

class ActivityAdded extends ActivityState{

}
