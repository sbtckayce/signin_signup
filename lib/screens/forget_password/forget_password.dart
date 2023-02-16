import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:signin_signup/widgets/widgets.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});
  static const String routeName = '/forget_password';
  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: ForgetPasswordScreen.routeName),
        builder: (_) => ForgetPasswordScreen());
  }

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  Future resetPassword() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailController.text.trim())
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Password reset link sent! Check your email'),
        backgroundColor: Colors.green,
      ));
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${error.toString()}'),
        backgroundColor: Colors.redAccent,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF95afc0),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            'Enter Your Email and we will send you a password reset link',
            style: TextStyle(
              fontSize: 25,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          BuildTextFormField(hintText: 'Email', controller: emailController),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              onPressed: () {
                resetPassword();
              },
              child: const Text(
                'Reset Password',
                style: TextStyle(color: Colors.white),
              ))
        ]),
      ),
    );
  }
}
