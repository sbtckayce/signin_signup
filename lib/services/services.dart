import 'package:firebase_auth/firebase_auth.dart';

class Services{

  Future<void> signIn (email,password)async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

  }
}