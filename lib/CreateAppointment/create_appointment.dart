import 'package:denuka/Login/login.dart';
import 'package:denuka/app.dart';
import 'package:denuka/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../appointments/appointment.dart';
import 'bloc/create_appointment_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CreateApp extends StatelessWidget {
  const CreateApp({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Create an Appointment'),
        elevation: 0,
      ),
      body: BlocProvider(
        create: (context) => CreateAppointmentBloc(),
        child: CreateAppCotent(userId: user),
      ),
    );
  }
}

class CreateAppCotent extends StatefulWidget {
  const CreateAppCotent({Key? key, required this.userId}) : super(key: key);
  final User userId;

  @override
  State<CreateAppCotent> createState() => _CreateAppCotentState();
}

class _CreateAppCotentState extends State<CreateAppCotent> {
  TextEditingController appointmentNamecontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController timecontroller = TextEditingController();

  final MaskTextInputFormatter timeMaskFormatter =
      MaskTextInputFormatter(mask: '##:##:##', filter: {"#": RegExp(r'[0-9]')});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateAppointmentBloc, CreateAppointmentState>(
        listener: (context, state) {
      if (state is CreateAppSuccessState) {
        Navigator.pop(context);
      }
    }, builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 40, 40),
        child: Column(
          children: [
            const Spacer(),
            TextField(
              controller: appointmentNamecontroller,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.book_online),
                  border: OutlineInputBorder(),
                  hintText: 'Enter Appointment Name'),
            ),
            const Padding(padding: EdgeInsets.all(20.0)),
            TextField(
              controller: locationcontroller,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.pin_drop),
                  border: OutlineInputBorder(),
                  hintText: 'Enter Location'),
            ),
            const Padding(padding: EdgeInsets.all(20.0)),
            TextField(
              controller: datecontroller,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.calendar_month),
                  border: OutlineInputBorder(),
                  hintText: 'Enter Date'),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100));

                if (pickedDate != null) {
                  print(
                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(
                      formattedDate); //formatted date output using intl package =>  2021-03-16
                  setState(() {
                    datecontroller.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {}
              },
            ),
            const Padding(padding: EdgeInsets.all(20.0)),
            TextField(
              controller: timecontroller,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.schedule),
                  border: OutlineInputBorder(),
                  hintText: 'Enter Time'),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: false),
              inputFormatters: <TextInputFormatter>[timeMaskFormatter],
            ),
            const Padding(padding: EdgeInsets.all(20.0)),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(500.0, 50.0),
                    primary: Colors.black,
                    onPrimary: Colors.white),
                onPressed: () {
                  context.read<CreateAppointmentBloc>().add(AppSubmitted(
                        //pass Submiited state of input values
                        userId: widget.userId.id.toString(),
                        appointmentName: appointmentNamecontroller.text,
                        location: locationcontroller.text,
                        date: datecontroller.text,
                        time: timecontroller.text,
                      ));

                  // Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           //use to route
                  //           builder: ((context) => MyAppointment(user: userId))));
                },
                child: const Text('Create Appointment'))
          ],
        ),
      );
    });
  }

  ScaffoldFeatureController buildErrorLayout() =>
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Signup Failure! Please try again'),
        ),
      );
}
