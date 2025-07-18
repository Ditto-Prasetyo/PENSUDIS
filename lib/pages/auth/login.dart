import 'package:bintar_sepuh/pages/auth/register.dart';
import 'package:bintar_sepuh/pages/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:bintar_sepuh/pages/auth/components/curved-left-shadow.dart';
import 'package:bintar_sepuh/pages/auth/components/curved-left.dart';
import 'package:bintar_sepuh/pages/auth/components/curved-right-shadow.dart';
import 'package:bintar_sepuh/pages/auth/components/curved-right.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(top: 0, left: 0, child: CurvedLeftShadow()),
            Positioned(top: 0, left: 0, child: CurvedLeft()),
            Positioned(bottom: 0, left: 0, child: CurvedRightShadow()),
            Positioned(bottom: 0, left: 0, child: CurvedRight()),
            Container(
              height: size.height,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 37.0,
                        fontWeight: FontWeight.w700, letterSpacing: 2,
                      ),
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 150.0,
                        padding: EdgeInsets.only(left: 10.0),
                        margin: EdgeInsets.only(right: 40.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 20.0),
                          ],
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(90.0),
                            bottomRight: Radius.circular(90.0),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextFormField(
                              style: TextStyle(fontSize: 16.0),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0,
                                  horizontal: 4.0,
                                ),
                                icon: Icon(Icons.person_outline, size: 24.0),
                                hintText: "Username",
                                border: InputBorder.none,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                              ),
                            ),
                            TextFormField(
                              style: TextStyle(fontSize: 16.0),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0,
                                  horizontal: 4.0,
                                ),
                                icon: Icon(Icons.lock_outline, size: 24.0),
                                hintText: "Password",
                                border: InputBorder.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 40,
                        right: 10,
                        child: Container(
                          padding: EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color.fromRGBO(94, 201, 202, 1.0),
                                Color.fromRGBO(119, 235, 159, 1.0),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10.0,
                              ),
                            ],
                          ),
                          child: MouseRegion(cursor: SystemMouseCursors.click, child: GestureDetector(onTap: () {
                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                          },
                          child: Icon(
                            Icons.arrow_forward,
                            size: 40.0,
                            color: Colors.white,
                          ),
                          ),),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(
                      vertical: 25.0,
                      horizontal: 30.0,
                    ),
                    child: MouseRegion(cursor: SystemMouseCursors.click, child: GestureDetector(onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Register()));
                    },
                    child: Text(
                      "Forgot?",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    )), ),
                    
                  ),
                 Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 25.0, top: 30.0),
  child: MouseRegion(
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Register()),
        );
      },
      child: Text(
        "Register",
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.deepOrangeAccent,
          fontWeight: FontWeight.w700,
          letterSpacing: 2,
        ),
      ),
    ),
  ),
)

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
