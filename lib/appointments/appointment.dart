import 'package:denuka/CreateAppointment/create_appointment.dart';
import 'package:denuka/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../CreateAppointment/models/appointment_model.dart';
import 'appointment_repository.dart';

class MyAppointment extends StatefulWidget {
  const MyAppointment({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  State<MyAppointment> createState() => _MyAppointmentState();
}

class _MyAppointmentState extends State<MyAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('My Appointments'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add_circle,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  //use to route
                  builder: ((context) => CreateApp(
                      user: widget.user)))); //widget.user = final User user
        },
      ),
      body: StreamBuilder(
          //builds itself based on the latest snapshot of interaction with a stream.

          // used to listen to the change of new state
          stream: Stream.fromFuture(AppointmentRepository()
              .getAppointment(userId: widget.user.id.toString())),

          //builder - returning widgets only
          builder: (BuildContext context,
              AsyncSnapshot<List<ApponintmentModel>> appointment) {
            //assign the list to appointment
            if (appointment.hasData) {
              return ListView.builder(
                  itemCount: appointment.data!.length,
                  itemBuilder: (BuildContext context, data) {
                    final date =
                        DateTime.parse('${appointment.data![data].date}');
                    String day = date.day.toString();

                    String month = DateFormat.MMM().format(date);

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                          leading: SizedBox(
                            height: 50,
                            width: 50,
                            child: Column(
                              children: [
                                Text(
                                  day,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  month,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          title: SizedBox(
                              height: 50,
                              width: 50,
                              child: Column(
                                children: [
                                  Text(
                                    '${appointment.data![data].appointmentName}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                ],
                              )),
                          subtitle: SizedBox(
                              height: 50,
                              width: 50,
                              child: Column(
                                children: [
                                  Text('${appointment.data![data].time}'),
                                ],
                              )),
                          trailing: Text('${appointment.data![data].location}'),
                          onTap: null),
                    );
                  });
            } else {
              return const SizedBox(
                child: Text('No data'),
              );
            }
          }),
    );
  }
}
