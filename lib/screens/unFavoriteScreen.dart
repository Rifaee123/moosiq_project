import 'package:flutter/material.dart';

class unFavorteScreen extends StatelessWidget {
  const unFavorteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/allScreen3.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Center(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 10, bottom: 80),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_back,
                              size: 32,
                              color: Colors.white,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10, top: 0),
                        child: Text(
                          "Unfavourite",
                          style: TextStyle(color: Colors.white, fontSize: 32),
                        ),
                      ),
                      Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.white,
                      )
                    ],
                  ),
                )),
                Container(
                    child: Expanded(
                        child: ListView(
                  children: [
                    listitems(
                        "assets/srch_universalmusic_00602448475596-NGA3B2214021.webp",
                        "Calm Down",
                        "Rema, Selena Gomez "),
                    SizedBox(
                      height: 15,
                    ),
                    listitems(
                        "assets/srch_universalmusic_00602448475596-NGA3B2214021.webp",
                        "Calm Down",
                        "Rema, Selena Gomez "),
                    SizedBox(
                      height: 15,
                    ),
                    listitems(
                        "assets/srch_universalmusic_00602448475596-NGA3B2214021.webp",
                        "Calm Down",
                        "Rema, Selena Gomez "),
                    SizedBox(
                      height: 15,
                    ),
                    listitems(
                        "assets/srch_universalmusic_00602448475596-NGA3B2214021.webp",
                        "Calm Down",
                        "Rema, Selena Gomez "),
                    SizedBox(
                      height: 15,
                    ),
                    listitems(
                        "assets/srch_universalmusic_00602448475596-NGA3B2214021.webp",
                        "Calm Down",
                        "Rema, Selena Gomez "),
                    SizedBox(
                      height: 15,
                    ),
                    listitems(
                        "assets/srch_universalmusic_00602448475596-NGA3B2214021.webp",
                        "Calm Down",
                        "Rema, Selena Gomez "),
                    SizedBox(
                      height: 15,
                    ),
                    listitems(
                        "assets/srch_universalmusic_00602448475596-NGA3B2214021.webp",
                        "Calm Down",
                        "Rema, Selena Gomez "),
                    SizedBox(
                      height: 15,
                    ),
                    listitems(
                        "assets/srch_universalmusic_00602448475596-NGA3B2214021.webp",
                        "Calm Down",
                        "Rema, Selena Gomez "),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ))),
              ],
            ),
          ), /* add child content here */
        ),
      ),
    );
  }

  Widget listitems(assetImage, String name, String subname) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45),
          color: Color.fromARGB(197, 233, 233, 180),
        ),
        child: ListTile(
            leading: ClipRRect(
              child: Image.asset(
                "$assetImage",
              ),
              borderRadius: BorderRadius.circular(40),
            ),
            title: Text(
              name,
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Text(subname),
            trailing: IconButton(
                onPressed: () {}, icon: Icon(Icons.favorite_border))));
  }
}
