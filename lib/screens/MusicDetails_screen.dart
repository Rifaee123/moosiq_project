import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MusicDetails extends StatefulWidget {
  MusicDetails({super.key});

  @override
  State<MusicDetails> createState() => _MusicDetailsState();
}

class _MusicDetailsState extends State<MusicDetails> {
  AudioPlayer audioPlayer = AudioPlayer();
  PlayerState audioPlayarState = PlayerState.paused;

  String url = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-13.mp3";
  int timeprogress = 0;
  int audioDuration = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    audioPlayer.onPlayerStateChanged.listen((PlayerState s) {
      setState(() {
        audioPlayarState = s;
      });
    });
    audioPlayer.setSourceUrl(url);
    audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        audioDuration = duration.inMilliseconds;
      });
    });
    audioPlayer.onPositionChanged.listen((Duration p) {
      setState(() {
        timeprogress = p.inMilliseconds;
      });
    });
  }

  plamusic() async {
    await audioPlayer.setSourceUrl(
        "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-13.mp3"); // equivalent to setSource(UrlSource(url));
    await audioPlayer.setVolume(0.5);
    await audioPlayer.resume();
  }

  puseMusic() async {
    await audioPlayer.pause();
  }

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
            children: [
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(right: 270, top: 25),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 35,
                      color: Colors.white,
                    )),
              )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), //color of shadow
                          spreadRadius: 5, //spread radius
                          blurRadius: 7, // blur radius
                          offset: const Offset(0, 2), // changes position of shadow
                          //first paramerter of offset is left-right
                          //second parameter is top to down
                        ),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Container(
                          height: 170,
                          width: 170,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Image.asset(
                                "assets/srch_universalmusic_00602448475596-NGA3B2214021.webp"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 60, top: 20),
                          child: InkWell(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             NowplayingScreen()));
                            },
                            child: Row(
                              children: [
                                const Text(
                                  "Calm Down",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.favorite_border))
                              ],
                            ),
                          ),
                        ),
                        const Text(
                          "Rema, Selena Gomez - Calm Down",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 20,
                          ),
                          child: Text(
                            "03:59",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 40, top: 10),
                          child: IconButton(
                              onPressed: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             NowplayingScreen()));
                              },
                              icon: const Icon(
                                Icons.play_circle,
                                size: 70,
                              )),
                        )
                      ],
                    ),
                  ),
                  height: 510,
                  width: 300,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 40),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(197, 233, 233, 180),
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: []),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              "assets/srch_universalmusic_00602445655038-USUM72201759.webp",
                              height: 70,
                              width: 70,
                            ),
                          ),
                        ),
                        Column(children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 5),
                            child: Row(
                              children: [
                                Text(
                                  "Bones",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.skip_previous)),
                                IconButton(
                                    onPressed: () {
                                      audioPlayarState == PlayerState.playing
                                          ? puseMusic()
                                          : plamusic();
                                    },
                                    icon: Icon(
                                      audioPlayarState == PlayerState.playing
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      size: 50,
                                    )),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.skip_next))
                              ],
                            ),
                          ),
                        ])
                      ],
                    ),
                  ),
                  height: 90,
                  width: 361,
                ),
              )
            ],
          ) /* add child content here */,
        ),
      ),
    );
  }
}
