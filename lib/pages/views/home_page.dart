import 'package:bintar_sepuh/pages/auth/login.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container( child: MouseRegion(cursor: SystemMouseCursors.click, child: GestureDetector(onTap: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Padding(padding: EdgeInsets.only(top: 30.0, left: 20.0), child: Text("This is home", style: TextStyle(letterSpacing: 2, fontSize: 20, fontWeight: FontWeight.bold)),),
      ),)
        
      ),
    );
  }
}