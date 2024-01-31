// ignore_for_file: use_build_context_synchronously

import 'package:demo_project/widgets/customButton.dart';
import 'package:demo_project/widgets/customTextFormFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'homePage.dart';
import 'userSigninPage.dart';

class UserSignupPage extends StatefulWidget {
  UserSignupPage({super.key});

  @override
  State<UserSignupPage> createState() => _UserSignupPageState();
}

class _UserSignupPageState extends State<UserSignupPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amberAccent,
          title: const Text('Signup Page'),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextFormFieldWidget(
                    controller: emailController, hintText: 'Email'),
                CustomTextFormFieldWidget(
                    controller: passwordController, hintText: 'Password'),
                CustomButton(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        try {
                          await auth.createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text);
                          print('sign up success');
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                              (route) => false);
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                    buttonText: 'Sign Up'),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        try {
                          await auth.signOut();
                          print('sign out success');
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                    buttonText: 'Sign Out'),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        try {
                          await auth.signInAnonymously();
                          print('sign up success anoimously');
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                              (route) => false);
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                    buttonText: 'Sign Up Anonimously'),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=>const SigninPage())
                      );
                    },
                    buttonText: 'Already have an account'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
