import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signin_signup/widgets/widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  static const String routeName = '/sign_in';
  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: SignInScreen.routeName),
        builder: (_) => SignInScreen());
  }

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future signIn() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim())
        .then(
      (value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Login Success'),
        backgroundColor: Colors.green,
      ));
        Navigator.pushNamed(context, '/home');
      },
    ).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('${error.toString()}')));
    });
    ;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                  'assets/images/signin.svg',
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
                'SIGN IN TO YOUR ACCOUNT!',
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
              InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/forget_password');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children:const [
                     Text('Forget password',
                          style: TextStyle(
                              color: Color(0xFF95afc0),
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
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
                  onPressed: () {
                    signIn();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text('Not a member?'),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/sign_up');
                  },
                  child: const Text('Register now',
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
