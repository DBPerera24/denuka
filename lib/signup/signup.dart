import 'package:denuka/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/signup_bloc.dart';

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Signup Page'),
        elevation: 0,
      ),
      body: BlocProvider(
        create: (context) => SignupBloc(),
        child: const SignupPageContent(),
      ),
    );
  }
}

class SignupPageContent extends StatefulWidget {
  const SignupPageContent({Key? key}) : super(key: key);

  @override
  State<SignupPageContent> createState() => _SignupPageContentState();
}

class _SignupPageContentState extends State<SignupPageContent> {
  TextEditingController firstNamecontroller = TextEditingController();
  TextEditingController lastNamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController pwcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupBloc, SignupState>(listener: (context, state) {
      // buildErrorLayout();

      if (state is SignupSuccessState) {
        Navigator.push(
            context,
            MaterialPageRoute(
                //use to route
                builder: ((context) => const Login())));
      }
      if (state is SignupFailureState) {
        buildErrorLayout();
      }
    }, builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 40, 40),
        child: Column(
          children: [
            const Spacer(),
            TextField(
              controller: firstNamecontroller,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.badge),
                  border: OutlineInputBorder(),
                  hintText: 'Enter First Name'),
            ),
            const Padding(padding: EdgeInsets.all(20.0)),
            TextField(
              controller: lastNamecontroller,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.badge),
                  border: OutlineInputBorder(),
                  hintText: 'Enter Last Name'),
            ),
            const Padding(padding: EdgeInsets.all(20.0)),
            TextField(
              controller: emailcontroller,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.mail),
                  border: OutlineInputBorder(),
                  hintText: 'Enter Email'),
            ),
            const Padding(padding: EdgeInsets.all(20.0)),
            TextField(
              controller: pwcontroller,
              obscureText: true,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  border: OutlineInputBorder(),
                  hintText: 'Enter Password'),
            ),
            const Padding(padding: EdgeInsets.all(20.0)),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(500.0, 50.0),
                    primary: Colors.black,
                    onPrimary: Colors.white),
                onPressed: () {
                  context.read<SignupBloc>().add(SignupSubmitted(
                        //pass Submiited state of input values
                        firstName: firstNamecontroller.text,
                        lastName: lastNamecontroller.text,
                        email: emailcontroller.text,
                        password: pwcontroller.text,
                      ));
                },
                child: const Text('Sign Up'))
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
