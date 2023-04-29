import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:moosiq_project/models/data_models.dart';
import 'package:moosiq_project/screens/loginScreen.dart';
import 'package:moosiq_project/screens/scroll_Screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/mostly_played1.dart';

const SAVE_KEY_NAME = "userloggedin";

class splash_screen extends StatefulWidget {
  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

final _audioQuery = OnAudioQuery();

final box = SongBox.getInstance();
List<SongModel> fetchSongs = [];
List<SongModel> allSongs = [];
final mostbox = MostplayedBox.getInstance();

class _splash_screenState extends State<splash_screen> {
  @override
  void initState() {
    requestPermition();

    super.initState();

    // TODO: implement initState
  }

  void requestPermition() async {
    Permission.storage.request();

//     var status = await Permission.storage.status;
//     if (status.isDenied) {
//       // We didn't ask for permission yet or the permission has been denied before but not permanently.
//     }

// // You can can also directly ask the permission about its status.
//     if (await Permission.location.isRestricted) {
//       // The OS restricts access, for example because of parental controls.
//     }

    bool permissionStatas = await _audioQuery.permissionsStatus();
    if (!permissionStatas) {
      await _audioQuery.permissionsRequest();
      fetchSongs = await _audioQuery.querySongs();
      for (var element in fetchSongs) {
        if (element.fileExtension == "mp3") {
          allSongs.add(element);
        }
      }
      for (var element in allSongs) {
        mostbox.add(
          MostPlayed(
              songname: element.title,
              songurl: element.uri!,
              duration: element.duration!,
              artist: element.artist!,
              count: 0,
              id: element.id),
        );
      }
      for (var element in allSongs) {
        await box.add(songModelDb(
            songname: element.title,
            artist: element.artist,
            duration: element.duration,
            id: element.id,
            songurl: element.uri));
      }
    }
    //   if (!mounted) return;
    //   setState(() {});

    Future.delayed(const Duration(seconds: 2), () {
      checkLOgedin();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (contex) => const loginUi()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/iPhone 14 - 11sp4.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          /* add child content here */
        ),
      ),
    );
  }

  Future SplasNav() async {
    Future.delayed(Duration(seconds: 3));
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => loginUi()));
  }

  Future<void> checkLOgedin() async {
    final _shirdPrefs = await SharedPreferences.getInstance();
    final _userLoggedin = _shirdPrefs.getBool(SAVE_KEY_NAME);
    if (_userLoggedin == null || _userLoggedin == false) {
      //  gotologin
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => loginUi(),
          ));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ScrollScreen(),
          ));
      // gotohome
    }
  }
}



//  Container(
//           color: Colors.white,
//           child: Padding(
//             padding: const EdgeInsets.only(top: 40),
//             child: Image.asset(
//               'assets/spalshscreen3.jpg',
//               height: 880,
//               width: 500,
//               scale: 0.1,
//             ),
//           ),
//         ),