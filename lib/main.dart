import 'package:flutter/material.dart';
import 'package:quis_app_datause/view/home_screen/home_screen.dart';


class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen()
    );
  }
}
void main(){
  runApp(Myapp());
}