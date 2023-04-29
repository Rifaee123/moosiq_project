import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:moosiq_project/screens/Terms_and_Conditions.dart';
import 'package:moosiq_project/screens/privacyPolicy.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/allScreen.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 30),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 40),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              size: 32,
                              color: Colors.white,
                            )),
                      ),
                      Text(
                        "About",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 118,
                height: 113,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  image: DecorationImage(
                    image:
                        AssetImage("assets/Picsart_23-03-02_14-13-15-061.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Moosiq Player", style: TextStyle(fontSize: 18)),
              ),
              Text("1.0.0", style: TextStyle(fontSize: 18)),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PrivacyPolicy()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      color: const Color.fromARGB(197, 233, 233, 180),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 6, left: 10),
                      child: ListTile(
                        title: Text(
                          "Privacy Policy",
                          style: TextStyle(fontSize: 18),
                        ),
                        trailing: Padding(
                          padding: EdgeInsets.only(bottom: 7),
                          child: Icon(Icons.keyboard_arrow_right_outlined),
                        ),
                      ),
                    ),
                    width: 340,
                    height: 75,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TermandCondetion()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      color: const Color.fromARGB(197, 233, 233, 180),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 6, left: 10),
                      child: ListTile(
                        title: Text(
                          "Terms and Conditions",
                          style: TextStyle(fontSize: 18),
                        ),
                        trailing: Padding(
                          padding: EdgeInsets.only(bottom: 7),
                          child: Icon(Icons.keyboard_arrow_right_outlined),
                        ),
                      ),
                    ),
                    width: 340,
                    height: 75,
                  ),
                ),
              ),
            ],
          )),
    ));
  }
}
