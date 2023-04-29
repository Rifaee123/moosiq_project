// ignore: must_be_immutable
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:moosiq_project/models/data_models.dart';
import 'package:moosiq_project/screens/NowPlaying_screen.dart';
import 'package:moosiq_project/screens/splash_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NowPlayingSlider extends StatefulWidget {
  NowPlayingSlider({super.key});

  static int? index = 0;
  static ValueNotifier<int> enteredvalue = ValueNotifier<int>(index!);
  List<songModelDb> dbsongs = box.values.toList();

  @override
  State<NowPlayingSlider> createState() => _NowPlayingSliderState();
}

class _NowPlayingSliderState extends State<NowPlayingSlider> {
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  // bool istaped = false;

  List<songModelDb> dbsongs = box.values.toList();
  List<Audio> convertAudios = [];

  @override
  Widget build(BuildContext context) {
    double vwidth = MediaQuery.of(context).size.width;
    double vheight = MediaQuery.of(context).size.height;

    return audioPlayer.builderCurrent(
      builder: (context, playing) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NowplayingScreen(
                      index: NowplayingScreen.nowplayingindex.value),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(40, 104, 228, 3),
                  borderRadius: BorderRadius.circular(20)),
              width: vwidth,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: QueryArtworkWidget(
                      quality: 100,
                      artworkWidth: 50,
                      artworkHeight: 60,
                      keepOldArtwork: true,
                      artworkBorder: BorderRadius.circular(10),
                      id: int.parse(playing.audio.audio.metas.id!),
                      type: ArtworkType.AUDIO,
                      nullArtworkWidget: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/Picsart_23-03-02_14-13-15-061.jpg',
                          height: 60,
                          width: 50,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 120,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            // allDbdongs[value].songname!,
                            audioPlayer.getCurrentAudioTitle,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            // allDbdongs[value].artist ?? "No Artist",
                            audioPlayer.getCurrentAudioArtist,
                          ),
                        ),
                      ),
                    ],
                  ),
                  PlayerBuilder.isPlaying(
                    player: audioPlayer,
                    builder: ((context, isPlaying) {
                      return Padding(
                        padding: EdgeInsets.only(right: vwidth * 0.01),
                        child: Wrap(
                          spacing: 10,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.black),
                              child: IconButton(
                                onPressed: () async {
                                  await audioPlayer.previous();
                                },
                                icon: const Icon(
                                  Icons.skip_previous,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.black),
                                child: IconButton(
                                  icon: Icon(
                                    (isPlaying)
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  onPressed: () async {
                                    await audioPlayer.playOrPause();

                                    // playsong(value);
                                    setState(() {
                                      isPlaying = !isPlaying;
                                    });
                                  },
                                )),
                            Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.black),
                              child: IconButton(
                                onPressed: () async {
                                  await audioPlayer.next();
                                  // rsongs = RecentlyPlayed(
                                  //     id: songs.id,
                                  //     artist: songs.artist,
                                  //     duration: songs.duration,
                                  //     songname: songs.songname,
                                  //     songurl: songs.songurl);

                                  // updateRecentlyPlayed(rsongs);
                                },
                                icon: const Icon(
                                  Icons.skip_next,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
