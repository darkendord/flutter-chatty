import 'package:chat_app/modules/main/tabs/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

/*
*************************
When refactoring:
*************************

- implement bloc pattern.
- implement text input controller.

 */

final FirebaseAuth _auth = FirebaseAuth.instance;

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  static String id = "registration_screen";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email = "";
  String password = "";
  bool showSpinner = false;

  void spinner() {
    setState(() {
      showSpinner = !showSpinner;
    });
  }

  void resetFields() {
    setState(() {
      email = "";
      password = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: "logo",
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                decoration:
                    kTextFieldDecoration.copyWith(hintText: "Enter your Email"),
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                decoration: kTextFieldDecoration.copyWith(
                    hintText: "Enter your password."),
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              const SizedBox(
                height: 24.0,
              ),
              _registrationButton(
                  context, email, password, spinner, resetFields),
            ],
          ),
        ),
      ),
    );
  }
}

Padding _registrationButton(context, String email, String password,
    Function spinner, Function resetFields) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    child: Material(
      color: Colors.blueAccent,
      borderRadius: const BorderRadius.all(Radius.circular(30.0)),
      elevation: 5.0,
      child: MaterialButton(
        onPressed: () async {
          email != "" && password != "" ? spinner() : null;

          try {
            final newUser = await _auth.createUserWithEmailAndPassword(
                email: email, password: password);
            if (newUser != null) {
              Navigator.pushNamed(context, ChatScreen.id);
            }
            resetFields();
            spinner();
          } catch (e) {
            print(e);
          }
        },
        minWidth: 200.0,
        height: 42.0,
        child: const Text(
          'Register',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}
