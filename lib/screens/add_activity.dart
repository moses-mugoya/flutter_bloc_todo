import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/models/activity.dart';

import '../bloc/activity_bloc.dart';
import '../repository/activity_repository.dart';

class AddActivity extends StatefulWidget {
  const AddActivity({Key? key}) : super(key: key);

  @override
  State<AddActivity> createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {
  final formKey = GlobalKey<FormState>();

  late final Activity activity;

  String name = "";
  String description = "";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            ActivityBloc(RepositoryProvider.of<ActivityRepository>(context)),
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Add Activity'),
              centerTitle: true,
            ),
            body: BlocConsumer<ActivityBloc, ActivityState>(
              listener: (context, state) {
                if(state is ActivityAdded){
                  Navigator.pushNamed(context, '/');
                }
              },
              builder: (context, state) {
                 if(state is ActivityAddedErrorState){
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(fontSize: 16, color: Colors.red),
                ),
              );
              }else if(state is ActivityAddedLoading){
                return const Center(
                  child: CircularProgressIndicator()
                );
              }
              return Material(
                child: Form(
                  key: formKey,
                  child: ListView(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 60),
                    children: [
                      Column(
                        children: <Widget>[
                          Text(
                            'Add Activity',
                            style: GoogleFonts.montserrat(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
                              fillColor: Colors.blue.withOpacity(0.1),
                              hintText: 'Activity Name',
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            validator: (value) {
                              return value!.isEmpty
                                  ? 'Name cannot be empty'
                                  : null;
                            },
                            onChanged: (val) {
                              setState(() {
                                name = val.trim();
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
                              fillColor: Colors.blue.withOpacity(0.1),
                              hintText: 'Description',
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            validator: (value) {
                              return value!.isEmpty
                                  ? 'Description cannot be empty'
                                  : null;
                            },
                            onChanged: (val) {
                              setState(() {
                                description = val.trim();
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          Container(
                            height: 45.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.blue[500],
                            ),
                            child: InkWell(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  activity = Activity(
                                      name: name, description: description);
                                      context.read<ActivityBloc>().add(AddActivityEvent(activity));
                                }
                              },
                              child: Center(
                                child: Text(
                                  'Add',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 17.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
                
              },
            )));
  }
}