import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_guide/controllers/auth.dart';
import 'package:emailjs/emailjs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookAppointScreen extends StatefulWidget {
  const BookAppointScreen({Key? key, required this.consultDoc})
      : super(key: key);
  final Map<String, dynamic> consultDoc;

  @override
  State<BookAppointScreen> createState() => _BookAppointScreenState();
}

class _BookAppointScreenState extends State<BookAppointScreen> {
  final Map<DateTime, List> _events = {};
  DateTime _selectedDay = DateTime.now();
  String _selectedTime = '';
  @override
  Widget build(BuildContext context) {
    final auth = context.read<Auth>();

    return SingleChildScrollView(
      child: Column(
        children: [
          // list tile with back arrow as leading
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              tileColor: HexColor("#40A49C"),
              leading: IconButton(
                icon: const Icon(
                  FontAwesomeIcons.angleLeft,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              trailing: IconButton(
                icon: const Icon(
                  FontAwesomeIcons.circleInfo,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
              title: Text(
                widget.consultDoc['name'],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              subtitle: const Text(
                "1 hour",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w200,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 8.w,
              top: 8.h,
              bottom: 8.h,
            ),
            child: Row(
              children: [
                Text(
                  "Select Date",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 300.h,
                width: 300.w,
                child: Calendar(
                  startOnMonday: true,

                  weekDays: const [
                    'MON',
                    'TUE',
                    'WED',
                    'THU',
                    'FRI',
                    'SAT',
                    'SUN'
                  ],
                  //eventsList: _eventList,
                  isExpandable: true,
                  eventDoneColor: Colors.green,
                  hideTodayIcon: true,
                  hideBottomBar: true,
                  selectedColor: HexColor("#40A49C"),
                  selectedTodayColor: Colors.green,
                  todayColor: Colors.blue,
                  eventColor: null,
                  // locale: 'de_DE',
                  //todayButtonText: 'Heute',
                  //allDayEventText: 'Ganztägig',
                  multiDayEndText: 'Ende',
                  isExpanded: true,
                  expandableDateFormat: 'EEEE, dd. MMMM yyyy',
                  datePickerType: DatePickerType.date,
                  dayOfWeekStyle: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontWeight: FontWeight.w400,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 8.w,
              top: 8.h,
              bottom: 8.h,
            ),
            child: Row(
              children: [
                Text(
                  "Select Time",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: [
                // time cards from 9am to 5pm
                for (int i = 9; i < 18; i++) buildTimeCard("$i:00"),
              ],
            ),
          ),

          // raised confirm button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 300.w,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () async {
                  Map<String, dynamic> templateParams = {
                    'from_name': auth.currentUser!.name,
                    'to_name': widget.consultDoc['name'],
                    "message":
                        "You have a new appointment on ${DateFormat.yMd().format(_selectedDay)} at $_selectedTime, please check your calendar and confirm the appointment. respond to email, ${auth.currentUser!.email} or call ${auth.currentUser!.phone} to confirm appointment.",
                    "email": widget.consultDoc['email'],
                  };

                  try {
                    await EmailJS.send(
                      'service_kbw6v0y',
                      'template_c9p7dfl',
                      templateParams,
                      const Options(
                        publicKey: 'user_8UNYp8xeBJ8vx4Ut6rGG2',
                        privateKey: 'ff1f46b45abe3a818614bc94851ecfcd',
                      ),
                    );
                    print('SUCCESS!');
                  } catch (error) {
                    print(error.toString());
                  }
                  // add appointment to firestore
                  FirebaseFirestore.instance.collection("appointments").add({
                    "consultant": widget.consultDoc['name'],
                    "date": _selectedDay,
                    "time": _selectedTime,
                  }).then((value) => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text("Appointment Booked"),
                            content: const Text(
                                "Your appointment has been booked successfully. You will receive a confirmation email shortly."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          )).catchError(
                      (error) => print("Failed to add appointment: $error")));
                },
                child: const Text(
                  "Confirm Appointment",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: HexColor("#40A49C"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTimeCard(String time) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTime = time;
        });
      },
      child: Card(
        color: _selectedTime == time ? HexColor("#40A49C") : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          height: 50.h,
          width: 100.w,
          child: Center(
            child: Text(
              time,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: _selectedTime == time ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
