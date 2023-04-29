import 'package:flutter/material.dart';

import '../../models/data_models.dart';

ValueNotifier<List<songModelDb>> songlist = ValueNotifier([]);

void addSongs(songModelDb value) {
  songlist.value.add(value);
}


