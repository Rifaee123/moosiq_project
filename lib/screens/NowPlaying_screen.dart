import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moosiq_project/db/db_function/addFavouraties.dart';
import 'package:moosiq_project/models/data_models.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:moosiq_project/screens/search_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'function/playlistfungtion.dart';

class NowplayingScreen extends StatefulWidget {
  NowplayingScreen({
    super.key,
    required this.index,
  });
  final int index;
  List<songModelDb>? songs;
  static int? indexvalue = 0;
  static ValueNotifier<int> nowplayingindex = ValueNotifier<int>(indexvalue!);

  @override
  State<NowplayingScreen> createState() => _NowplayingScreenState();
}

class _NowplayingScreenState extends State<NowplayingScreen> {
  bool istaped = true;
  final _audioPlayer = AssetsAudioPlayer.withId('0');
  final box = SongBox.getInstance();
  bool isRepeat = false;
  bool isShuffleOn = false;

  String url = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-13.mp3";
  int timeprogress = 0;
  int audioDuration = 0;
  String path = "_audioQuery.querySongs()";

  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  int currentIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 32,
                          )),
                      const Padding(
                        padding: EdgeInsets.only(left: 30, right: 30),
                        child: Text(
                          "Now Playing",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (checkFavoriteStatus(widget.index, context)) {
                            addToFavourites(widget.index);
                            const snackbar = SnackBar(
                              content: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Added to Favourites',
                                ),
                              ),
                              dismissDirection: DismissDirection.down,
                              elevation: 10,
                              padding: EdgeInsets.only(top: 10, bottom: 15),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          } else if (!checkFavoriteStatus(
                              widget.index, context)) {
                            removefavourite(widget.index);
                          }
                          setState(
                            () {
                              istaped = !istaped;
                            },
                          );
                          print(allDbsongs[widget.index].songname!);
                        },
                        icon: Icon(Icons.favorite,
                            size: 32,
                            color: (checkFavoriteStatus(widget.index, context))
                                ? const Color.fromARGB(255, 136, 130, 130)
                                : const Color.fromARGB(255, 241, 6, 6)),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 90),
                  child: ValueListenableBuilder(
                    valueListenable: NowplayingScreen.nowplayingindex,
                    builder: (context, int playing, child) {
                      return ValueListenableBuilder<Box<songModelDb>>(
                        valueListenable: box.listenable(),
                        builder:
                            ((context, Box<songModelDb> allsongbox, child) {
                          List<songModelDb> allsongs =
                              allsongbox.values.toList();
                          if (allsongs.isEmpty) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (allsongs == null) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return _audioPlayer.builderCurrent(
                              builder: ((context, playing) {
                            return Column(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: QueryArtworkWidget(
                                        id: int.parse(
                                            playing.audio.audio.metas.id!),
                                        type: ArtworkType.AUDIO,
                                        artworkWidth: 230,
                                        artworkHeight: 230,
                                        nullArtworkWidget: Image.asset(
                                          "assets/Picsart_23-03-02_14-13-15-061.jpg",
                                          width: 230,
                                        ))
                                    // Image.asset(
                                    //   "assets/srch_universalmusic_00602445655038-USUM72201759.webp",
                                    //   width: 250,
                                    //   height: 250,
                                    // ),
                                    ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 30, bottom: 20, left: 20, right: 20),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      _audioPlayer.getCurrentAudioTitle,
                                      style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w600),
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      _audioPlayer.getCurrentAudioArtist ==
                                              "<Unknown>"
                                          ? "Unknow Artist"
                                          : _audioPlayer.getCurrentAudioArtist,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, top: 30, right: 20),
                                  child: Column(
                                    children: [
                                      PlayerBuilder.realtimePlayingInfos(
                                        player: _audioPlayer,
                                        builder:
                                            (context, RealtimePlayingInfos) {
                                          _duration = RealtimePlayingInfos
                                              .current!.audio.duration;
                                          _position = RealtimePlayingInfos
                                              .currentPosition;

                                          return ProgressBar(
                                            baseBarColor: const Color.fromARGB(
                                                    255, 152, 151, 224)
                                                .withOpacity(0.5),
                                            progressBarColor: const Color.fromARGB(
                                                255, 10, 28, 199),
                                            thumbColor: const Color.fromARGB(
                                                255, 24, 14, 14),
                                            thumbRadius: 5,
                                            timeLabelPadding: 5,
                                            progress: _position,
                                            timeLabelTextStyle: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 59, 12, 226),
                                            ),
                                            total: _duration,
                                            onSeek: (duration) async {
                                              await _audioPlayer.seek(duration);
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                PlayerBuilder.isPlaying(
                                  player: _audioPlayer,
                                  builder: (context, isPlaying) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, left: 20),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    if (isRepeat) {
                                                      _audioPlayer.setLoopMode(
                                                          LoopMode.none);
                                                      isRepeat = false;
                                                    } else {
                                                      _audioPlayer.setLoopMode(
                                                          LoopMode.single);
                                                      isRepeat = true;
                                                    }
                                                  });
                                                },
                                                icon: (isRepeat)
                                                    ? const Icon(
                                                        Icons
                                                            .repeat_one_on_outlined,
                                                        size: 40,
                                                      )
                                                    : const Icon(
                                                        Icons.repeat,
                                                        size: 40,
                                                      )),
                                          ),
                                          IconButton(
                                              onPressed: () async {
                                                await _audioPlayer.previous();
                                              },
                                              icon: const Icon(
                                                Icons.skip_previous,
                                                size: 50,
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 40, bottom: 30),
                                            child: IconButton(
                                                onPressed: () async {
                                                  if (isPlaying) {
                                                    await _audioPlayer.pause();
                                                  } else {
                                                    await _audioPlayer.play();
                                                  }
                                                  setState(() {
                                                    isPlaying = !isPlaying;
                                                  });
                                                  // audioPlayarState == PlayerState.playing
                                                  //     ? puseMusic()
                                                  //     : plamusic();
                                                },
                                                icon: Icon(
                                                  //
                                                  isPlaying
                                                      ? Icons.pause
                                                      : Icons.play_arrow,
                                                  size: 80,
                                                )),
                                          ),
                                          IconButton(
                                              onPressed: () async {
                                                await _audioPlayer.next();
                                                setState(() {});
                                              },
                                              icon: const Icon(
                                                Icons.skip_next,
                                                size: 50,
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 15, left: 10),
                                            child: IconButton(
                                                onPressed: () {
                                                  showPlaylistOptions(
                                                      context,
                                                      NowplayingScreen
                                                          .nowplayingindex
                                                          .value);
                                                },
                                                icon: const Icon(
                                                  Icons.playlist_add,
                                                  size: 40,
                                                )),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                )
                              ],
                            );
                          }));
                        }),
                      );
                    },
                  ),
                ),
              ],
            ),
          ) /* add child content here */,
        ),
      ),
    );
  }
}
