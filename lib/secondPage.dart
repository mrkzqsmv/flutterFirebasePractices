import 'package:demo_project/cloudFirestorePractises.dart';
import 'package:demo_project/widgets/customButton.dart';
import 'package:demo_project/widgets/customTextFormFieldWidget.dart';
import 'package:demo_project/widgets/customTitle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneNumberController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Second Page'),
          centerTitle: true,
          backgroundColor: Colors.amberAccent,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                    buttonText: 'Sign in with facebook',
                    onTap: () {
                      // signInWithFacebook();
                    }),
                const CustomTitle(title: 'Verify your phone number'),
                const SizedBox(
                  height: 6,
                ),
                CustomTextFormFieldWidget(
                    controller: phoneNumberController,
                    hintText: 'Enter your phone number'),
                CustomButton(
                    buttonText: 'Verify phone number',
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        try {
                          verifyYourPhoneNumber(phoneNumberController);
                          print('sent verify code success');
                          print('---------');
                        } catch (e) {
                          print(e);
                        }
                      }
                    }),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                    buttonText: 'Cloud firestore example',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const CloudFirestorePractices()));
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  void verifyYourPhoneNumber(TextEditingController controller) async {
    await auth.verifyPhoneNumber(
      phoneNumber: controller.text,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}

// Future<UserCredential> signInWithFacebook() async {
//   final LoginResult loginResult = await FacebookAuth.instance.login();

//   final OAuthCredential facebookAuthCredential =
//       FacebookAuthProvider.credential(loginResult.accessToken!.token);

//   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
// }
