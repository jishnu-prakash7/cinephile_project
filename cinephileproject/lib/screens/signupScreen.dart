// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cinephileproject/models/user.dart';
import 'package:cinephileproject/screens/userLoginScreen.dart';
import 'package:cinephileproject/widgets/loginAndSignup.dart';
import 'package:cinephileproject/widgets/mainRefactoring.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  final namecontroller = TextEditingController();

  final emailcontroller = TextEditingController();

  final passwordcontroller = TextEditingController();

  late Box userBox;

  @override
  void initState() {
    super.initState();
    userBox = Hive.box('user');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          title: maintitle(),
          centerTitle: true,
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(children: [
              Container(
                height: MediaQuery.sizeOf(context).height * 0.1,
              ),
              Container(
                  margin: EdgeInsets.only(left: 50, right: 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Signup',
                              style: GoogleFonts.ubuntu(
                                  textStyle: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.w800)),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textabovetextfield('Name'),
                            LoginTextformField('Enter Name', 'Name is needed !',
                                namecontroller, TextInputType.name, false),
                            textabovetextfield('Email'),
                            LoginTextformField(
                                'Enter Email',
                                'Email is needed !',
                                emailcontroller,
                                TextInputType.emailAddress,
                                false),
                            textabovetextfield('Password'),
                            LoginTextformField(
                                'Enter Password',
                                'Password is needed !',
                                passwordcontroller,
                                TextInputType.number,
                                true),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 21, 21, 21),
                                  fixedSize: Size(200, 40),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              onPressed: () {
                                final isvalid =
                                    _formKey.currentState?.validate();
                                if (isvalid!) {
                                  userBox.add(User(
                                      userName: namecontroller.text,
                                      email: emailcontroller.text,
                                      password:
                                          int.parse(passwordcontroller.text)));
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (context) {
                                    return UserLogin();
                                  }));
                                }
                              },
                              child: Text(
                                'signup',
                                style: GoogleFonts.ubuntu(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: Colors.white)),
                              )),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 10),
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: 'Already have an Account? ',
                                style: GoogleFonts.ubuntu(
                                    textStyle: TextStyle(fontSize: 16),
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: 'Login',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(builder: (context) {
                                      return UserLogin();
                                    }));
                                  },
                                style: GoogleFonts.ubuntu(
                                    textStyle: TextStyle(fontSize: 16),
                                    color: Color.fromARGB(255, 36, 171, 33)),
                              ),
                            ]))),
                      ]),
                    ),
                  ))
            ]),
          ),
        ));
  }
}
