import 'package:demo_project/userSignupPage.dart';
import 'package:demo_project/widgets/customButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'detailPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          centerTitle: true,
          backgroundColor: Colors.amberAccent,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('HOME PAGE'),
              CustomButton(
                buttonText: 'Sign Out',
                onTap: () async {
                  try {
                    await auth.signOut();
                    // ignore: use_build_context_synchronously
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserSignupPage()),
                        (route) => false);
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              Text(auth.currentUser!.uid.toString()),
              Text(auth.currentUser!.emailVerified.toString()),
              Text(auth.currentUser!.isAnonymous.toString()),
              CustomButton(
                  buttonText: 'Delete my account',
                  onTap: () async {
                    try {
                      await auth.currentUser!.delete();
                      print('deleted account success');
                    } catch (e) {
                      print(e);
                    }
                  }),
              Text(auth.currentUser!.displayName.toString()),
              Text(auth.currentUser!.email.toString()),
              CustomButton(
                  buttonText: 'Change the display name',
                  onTap: () async {
                    await auth.currentUser!.updateDisplayName('Markaz Gasimov');
                  }),
              Text(auth.currentUser!.displayName.toString()),
              CustomButton(
                  buttonText: 'Change the email',
                  onTap: () async {
                    await auth.currentUser?.updateEmail('mrkzqsmv@gmail.com');
                  }),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                  buttonText: 'Verify the account',
                  onTap: () async {
                    await auth.currentUser?.sendEmailVerification();
                    print(auth.currentUser!.emailVerified);
                  }),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                  buttonText: 'Detail Page',
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const DetailPage()));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
