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

  String name = "";
  String description = "";
  String nameError = "";
  String descriptionError = "";
  bool isDisabled = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController desController = TextEditingController();



  @override
  void dispose() {
    nameController.dispose(); 
    desController.dispose();   
    super.dispose();
  }

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

                if(state is ActivityAddedErrorState){
                    setState(() {
                        
                     if(state.errType == 'custom'){
                        if(state.message['name'] == null){
                          nameError = "";
                        }else{
                          nameError = state.message['name'][0];
                        }
                        if(state.message['description'] == null){
                            descriptionError = "";
                        }else{
                          descriptionError = state.message['description'][0];
                        }
                     }else{
                       showAlertDialog(context, state.message);
                     }
                    });
                    nameController.text = name;
                    desController.text = description;


                }else{
                  setState(() {
                    nameError = "";
                    descriptionError = "";
                  });
                }
              },
              builder: (context, state) {
              //    if(state is ActivityAddedErrorState){
              //      if(nameError == "" || descriptionError == ""){
              //          return null;
              //      }
                
              // }else
              if(state is ActivityAddedLoading){
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
                            controller: nameController,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
                              fillColor: Colors.blue.withOpacity(0.1),
                              hintText: 'Activity Name',
                              errorText: nameError == "" ? null: nameError,
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
                                if (name.length < 5){
                                  nameError = "Name too short";
                                }else{
                                  nameError = "";
                                }

                                if(name != "" && description != ""){
                                  isDisabled = false;
                                }else{
                                  isDisabled = true;
                                }
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: desController,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
                              fillColor: Colors.blue.withOpacity(0.1),
                              hintText: 'Description',
                              errorText: descriptionError == "" ? null : descriptionError,
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
                          
                                if(name != "" && description != "" ){
                                  isDisabled = false;
                                }else{
                                  isDisabled = true;
                                }
     
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 45.0,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: isDisabled ? null : () { 
                                if (formKey.currentState!.validate()) {
                                    context.read<ActivityBloc>().add(AddActivityEvent(name, description));
                                    FocusManager.instance.primaryFocus?.unfocus();
                                } 
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)
                                ),
                

                              ),
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

  showAlertDialog(BuildContext context, String errorMessage) {

  // set up the button
  Widget okButton = TextButton(
    child: const Text("Close"),
    onPressed: () { 
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Error!",
    style: TextStyle(
      color: Colors.red,
    ),
    
    ),
    content: Text(errorMessage),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

}
