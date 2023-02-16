import 'package:flutter/material.dart';
import 'package:signin_signup/screens/screens.dart';


class AppRouter {
  static Route onGenerateRoute(RouteSettings settings){
    switch(settings.name){
      case '/forget_password':
        return ForgetPasswordScreen.route();
      case '/home':
        return HomeScreen.route();
      case '/sign_in':
        return SignInScreen.route();
      case '/sign_up':
        return SignUpScreen.route();
      default:
        return _errorRoute();
    }
  }
  static Route _errorRoute(){
    return MaterialPageRoute(builder: (_)=> Scaffold(appBar: AppBar(title: Text('Error'),),));
  }
}