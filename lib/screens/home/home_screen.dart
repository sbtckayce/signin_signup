import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = '/';
  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: HomeScreen.routeName),
        builder: (_) => HomeScreen());
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Sign in as : ${user!.email}'),
          const SizedBox(height: 20,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                backgroundColor: Colors.black),
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.pushNamed(context, '/sign_in');
              });
            },
            child: Text(
              'Sign Out',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      )),
    );
  }
}
