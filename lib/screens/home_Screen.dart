import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moosiq_project/screens/PlayList_Screen.dart';
import 'package:moosiq_project/screens/SettingsScreen.dart';
import 'package:moosiq_project/screens/favorate_scrollScreen.dart';
import 'package:moosiq_project/screens/mostlyPlayed_Screen.dart';
import 'package:moosiq_project/screens/nowPLayingslider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../db/db_function/addFavouraties.dart';
import '../models/favourites_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage("assets/homePagr3.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 210),
                child: Center(
                  child: Container(
                    height: 274,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 39, right: 25),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const PlayListScreen()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(45),
                                color: const Color.fromRGBO(97, 71, 217, 1.000),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 170),
                                child: Column(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.only(left: 70),
                                      child: Icon(
                                        Icons.flash_on_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "Playlist",
                                      style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              width: 190,
                              height: 274,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40, right: 25),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MostlyPlay()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(45),
                                  color: const Color.fromRGBO(71, 190, 83, 1.000)),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 130),
                                child: Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 110),
                                      child: Icon(
                                        Icons.headset_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Text(
                                      "Most Played",
                                      style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              width: 185,
                              height: 211,
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(right: 25),
                        //   child: InkWell(
                        //     onTap: () {
                        //       Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) => RecentlyScreen()));
                        //     },
                        //     child: Container(
                        //       decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(45),
                        //           color: Color.fromRGBO(21, 174, 245, 1)),
                        //       child: Padding(
                        //         padding: const EdgeInsets.only(top: 170),
                        //         child: Column(
                        //           children: [
                        //             Padding(
                        //               padding: const EdgeInsets.only(left: 120),
                        //               child: Icon(
                        //                 Icons.restore_rounded,
                        //                 color: Colors.white,
                        //               ),
                        //             ),
                        //             Text(
                        //               "Recent Play",
                        //               style: TextStyle(
                        //                   fontSize: 28,
                        //                   fontWeight: FontWeight.w700,
                        //                   color: Colors.white),
                        //             )
                        //           ],
                        //         ),
                        //       ),
                        //       width: 180,
                        //       height: 211,
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(right: 25, top: 80),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SettingScreen()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(45),
                                  color: const Color.fromRGBO(147, 149, 150, 1)),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 90),
                                child: Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 80),
                                      child: Icon(
                                        Icons.settings,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Text(
                                      "Settings",
                                      style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              width: 180,
                              height: 211,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 0, top: 35),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => favorateScrollScreen()));
                      },
                      child: const Text(
                        "Favourite",
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 35),
                    child: Icon(Icons.favorite),
                  )
                ],
              ),
              ValueListenableBuilder<Box<favourites>>(
                  valueListenable: Favocuritesbox.getInstance().listenable(),
                  builder: (context, Box<favourites> favouriteDB, child) {
                    log("added");
                    List<favourites> favouritesongs =
                        favouriteDB.values.toList().reversed.toList();
                    return favouritesongs.isNotEmpty
                        ? Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: favouritesongs.length,
                                  itemBuilder: ((context, index) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(45),
                                            color: const Color.fromARGB(
                                                197, 233, 233, 180),
                                          ),
                                          child: ListTile(
                                            leading: QueryArtworkWidget(
                                                id: favouritesongs[index].id!,
                                                type: ArtworkType.AUDIO,
                                                nullArtworkWidget: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                  child: Image.asset(
                                                    'assets/Picsart_23-03-02_14-13-15-061.jpg',
                                                  ),
                                                )),
                                            title: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Text(
                                                favouritesongs[index].songname!,
                                                style: const TextStyle(fontSize: 18),
                                              ),
                                            ),
                                            subtitle: Text(
                                              favouritesongs[index].artist ??
                                                  "No Artist",
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            trailing: IconButton(
                                                onPressed: () {
                                                  deletefavouritehome(
                                                      index, context);
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Color.fromARGB(
                                                      255, 31, 30, 30),
                                                )),
                                          ),
                                        ),
                                      ))),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 60),
                            child: Column(
                              children: [
                                const Text(
                                  "You haven't Liked any songs!",
                                ),
                                Text(
                                  "${favouritesongs.length}",
                                ),
                              ],
                            ),
                          );
                  })
            ],
          ) /* add child content here */,
        ),
        bottomSheet: NowPlayingSlider(),
      ),
    );
  }
}
