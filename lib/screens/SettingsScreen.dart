import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moosiq_project/screens/about_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/allScreen.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 32,
                          color: Colors.white,
                        )),
                    const Text(
                      "Settings",
                      style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                    const Icon(
                      Icons.settings,
                      size: 32,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 40, top: 90),
                child: Text(
                  "About App",
                  style: TextStyle(fontSize: 20, color: Colors.black45),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AboutScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        color: Color.fromARGB(197, 233, 233, 180),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 6, left: 33),
                        child: ListTile(
                          title: Text(
                            "About",
                            style: TextStyle(fontSize: 18),
                          ),
                          trailing: Padding(
                            padding: EdgeInsets.only(bottom: 0),
                            child: Icon(Icons.keyboard_arrow_right_outlined),
                          ),
                        ),
                      ),
                      width: 340,
                      height: 75,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: InkWell(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => NowplayingScreen(songModel: ,)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        color: const Color.fromARGB(197, 233, 233, 180),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 6, left: 10),
                        child: ListTile(
                            title: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    singOut();
                                  },
                                  icon: Icon(Icons.exit_to_app)),
                              Text("Exit")
                            ],
                          ),
                        )),
                      ),
                      width: 340,
                      height: 75,
                    ),
                  ),
                ),
              ),
            ],
          )),
    ));
  }

  singOut() async {
    final _sheredpref = await SharedPreferences.getInstance();
    await _sheredpref.clear();
    SystemNavigator.pop();
  }
}
