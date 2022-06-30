import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/screens/add_activity.dart';
import 'package:todo/utilities/activity_list_template.dart';


class ActivityList extends StatefulWidget {
  const ActivityList({Key? key}) : super(key: key);

  @override
  State<ActivityList> createState() => _ActivityListState();
}

class _ActivityListState extends State<ActivityList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Activities',
          style: GoogleFonts.montserrat(
            fontSize: 22.0,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            height: 80.0,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xff1b1f36),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: ActivityListTemplate(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            Navigator.pushNamed(context, '/addActivity');
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    ); 
  }
}