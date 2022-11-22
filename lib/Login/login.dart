import 'package:denuka/appointments/appointment.dart';
import 'package:denuka/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/login_bloc.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Login Page'),
        elevation: 0,
      ),
      body: BlocProvider(
        create: (context) => LoginBloc(),
        child: const LoginPageContent(),
      ),
    );
  }
}

class LoginPageContent extends StatefulWidget {
  const LoginPageContent({Key? key}) : super(key: key);

  @override
  State<LoginPageContent> createState() => _LoginPageContentState();
}

class _LoginPageContentState extends State<LoginPageContent> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController pwcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
      // buildErrorLayout();

      if (state is LoginSuccessState) {
        Navigator.push(
            context,
            MaterialPageRoute(
                //use to route
                builder: ((context) => MyAppointment(user: state.user))));
      }
      // if (state is LoginFailure) {
      //   buildErrorLayout();
      // }
    }, builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 40, 40),
        child: Column(
          children: [
            const Spacer(),
            TextField(
              controller: emailcontroller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Enter Email'),
            ),
            const Padding(padding: EdgeInsets.all(20.0)),
            TextField(
              controller: pwcontroller,
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Enter Password'),
            ),
            const Padding(padding: EdgeInsets.all(20.0)),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(500.0, 50.0),
                    primary: Colors.black,
                    onPrimary: Colors.white),
                onPressed: () {
                  context.read<LoginBloc>().add(Submitted(
                      //pass Submiited state of input values
                      email: emailcontroller.text,
                      password: pwcontroller.text));
                },
                child: const Text('Log In')),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  const Text('New to App?'),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150.0, 20.0),
                        primary: const Color.fromARGB(255, 7, 113, 243),
                        onPrimary: Colors.white),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              //use to route
                              builder: ((context) => const Signup())));
                    },
                    child: const Text('Register'),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  buildErrorLayout() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        content: Text('Please enter email/password!'),
      ),
    );
  }
}
