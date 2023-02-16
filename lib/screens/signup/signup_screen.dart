import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signin_signup/widgets/widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const String routeName = '/sign_up';
  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: SignUpScreen.routeName),
        builder: (_) => SignUpScreen());
  }

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  Future signUp() async {
    bool passwordConfirmed() {
      if (passwordController.text.trim() == rePasswordController.text.trim()) {
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.pinkAccent,
            content: Text('Password & RePassword do not match')));
        return false;
      }
    }

    if (passwordConfirmed()) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then((value) {
            ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
        content: Text('Register Success'),
        backgroundColor: Colors.green,
      ));
        Navigator.pushNamed(context, '/sign_in');
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text('${error.toString()}')));
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.width * 0.5,
                child: SvgPicture.asset(
                  'assets/images/signup.svg',
                ),
              ),
              Text(
                'HELLO YOU!',
                style: GoogleFonts.bebasNeue(fontSize: 36),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'REGISTER BELOW WITH YOUR DETAILS!',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              BuildTextFormField(
                hintText: 'Email',
                controller: emailController,
              ),
              const SizedBox(
                height: 10,
              ),
              BuildTextFormField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(
                height: 10,
              ),
              BuildTextFormField(
                controller: rePasswordController,
                hintText: 'RePassword',
                obscureText: true,
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      backgroundColor: Colors.black),
                  onPressed: () async {
                    signUp();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text('I am a member?'),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/sign_in');
                  },
                  child: const Text('Login now',
                      style: TextStyle(
                          color: Color(0xFF95afc0),
                          fontWeight: FontWeight.bold)),
                )
              ])
            ],
          ),
        ),
      )),
    );
  }
}
