import 'package:flutter/material.dart';
import 'package:moosiq_project/screens/home_Screen.dart';
import 'package:moosiq_project/screens/scroll_Screen.dart';
import 'package:moosiq_project/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginUi extends StatefulWidget {
  const loginUi({super.key});

  @override
  State<loginUi> createState() => _loginUiState();
}

class _loginUiState extends State<loginUi> {
  bool isloggedin = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/firstScreen.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 500, left: 40, right: 30),
            child: Column(
              children: [
                Text(
                  "Let`s Connect With Music And Enjoy",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text("Make the music play your emotions",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.white)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, right: 10),
                  child: Container(
                    height: 50,
                    width: 148,
                    child: ElevatedButton(
                        onPressed: () {
                          isloggedin = true;
                          checklogin(context);
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromRGBO(243, 238, 238, 0.984)),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)))),
                        child: Row(
                          children: [
                            Text(
                              "Let`s Start ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                            )
                          ],
                        )),
                  ),
                )
              ],
            ),
          ) /* add child content here */,
        ),
      ),
    );
  }

  void checklogin(BuildContext ctx) async {
    if (isloggedin == true) {
      final _sharedprefs = await SharedPreferences.getInstance();
      _sharedprefs.setBool(SAVE_KEY_NAME, true);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ScrollScreen(),
          ));
    } else {
      print("you are not tapped");
    }
  }
}
