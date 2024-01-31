import 'package:demo_project/secondPage.dart';
import 'package:demo_project/widgets/customButton.dart';
import 'package:demo_project/widgets/customTextFormFieldWidget.dart';
import 'package:demo_project/widgets/customTitle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController emailVerifyController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    emailVerifyController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detail Page'),
          centerTitle: true,
          backgroundColor: Colors.amberAccent,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const CustomTitle(title: 'Change Email'),
                  CustomTextFormFieldWidget(
                      controller: emailController, hintText: 'Enter Email'),
                  CustomButton(
                      buttonText: 'updateDisplayName',
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          updateEmail(emailController);
                        }
                      }),
                  Text(auth.currentUser!.email.toString()),
                  const SizedBox(
                    height: 10,
                  ),
                  const CustomTitle(title: 'Verify the Email'),
                  CustomTextFormFieldWidget(
                      controller: emailVerifyController,
                      hintText: 'Enter Email'),
                  CustomButton(
                      buttonText: 'verifyYourEmail',
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          updateEmail(emailVerifyController);
                          sendEmailVerification(emailVerifyController);
                          print('your email is verified');
                          if (auth.currentUser != null) {
                            print(auth.currentUser!.email);
                          }
                        }
                      }),
                  Text(auth.currentUser!.emailVerified.toString()),
                  Text(auth.currentUser!.displayName.toString()),
                  Text(auth.currentUser!.isAnonymous.toString()),
                  const CustomTitle(title: 'Change Password'),
                  CustomTextFormFieldWidget(
                      controller: passwordController,
                      hintText: 'Enter your new password'),
                  CustomButton(
                      buttonText: 'Change Password',
                      onTap: () {
                        updatePassword(passwordController);
                        print('password changed success');
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                      buttonText: 'Signup with the google',
                      onTap: () {
                        signInWithGoogle();
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                      buttonText: 'Second Page',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SecondPage()));
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

void updatePassword(TextEditingController controller) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await user.updatePassword(controller.text);
      print("Password updated successfully for ${user.email}");
    } else {
      print("User not signed in.");
    }
  } catch (e) {
    print(e);
  }
}

void updateEmail(TextEditingController controller) async {
  try {
    // Geçerli kullanıcıyı al
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // E-posta adresini güncelle
      await user.updateEmail(controller.text);

      // Eğer güncelleme başarılıysa kullanıcıyı tekrar getir ve yeni e-posta adresini yazdır
      User? updatedUser = FirebaseAuth.instance.currentUser;
      print("Updated email: ${updatedUser?.email}");
    } else {
      print("User not signed in.");
    }
  } catch (e) {
    print("Error updating email: $e");
  }
}

void sendEmailVerification(TextEditingController controller) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && !user.emailVerified) {
      // E-posta doğrulama e-postasını gönder
      await user.sendEmailVerification();

      print("Verification email sent to ${user.email}");
    } else {
      print("User not signed in or email already verified.");
    }
  } catch (e) {
    print("Error sending verification email: $e");
  }
}
