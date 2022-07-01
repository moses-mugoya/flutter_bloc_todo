import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:todo/models/activity.dart';
import 'package:todo/network/custom_exceptions.dart';
import 'package:todo/repository/activity_repository.dart';

part 'activity_event.dart';
part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {

  final ActivityRepository activityRepository;

  ActivityBloc(this.activityRepository) : super(ActivityInitial()) {
    on<LoadActivityEvent>((event, emit) async {
      emit(ActivityLoading());
      try{
        final activities = await activityRepository.getActivities();
        emit(ActivitiesLoaded(activities));
      }catch (e) {
        emit(ActivityErrorState(message: e.toString()));
      }
    });

    on<AddActivityEvent>((event, emit) async{
      emit(ActivityAddedLoading());
      try{
        await activityRepository.addActivity(event.name, event.description);
        emit(ActivityAdded());
      } on CustomException catch (customError) {
        emit(ActivityAddedErrorState(message: customError.errors));
      }
      
    });
  }
}
