import 'package:flutter/material.dart';
import 'package:moosiq_project/db/db_function/PlaylistFunction.dart';

final _controller = TextEditingController();

Future openDialog(context) => showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
          title: Text("Create Playlist name"),
          content: TextField(
              controller: _controller,
              autofocus: true,
              decoration: InputDecoration(hintText: "enter name")),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("cancel"),
            ),
            TextButton(
              onPressed: () {
                createplaylist(_controller.text, context);
                Navigator.pop(context);
              },
              child: Text("Submit"),
            )
          ],
        ));
Future openDialogedit(context, index) => showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
          title: Text("Create Playlist name"),
          content: TextField(
              controller: _controller,
              autofocus: true,
              decoration: InputDecoration(hintText: "enter name")),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("cancel"),
            ),
            TextButton(
              onPressed: () {
                editPlaylist(_controller.text, index);
                Navigator.pop(context);
              },
              child: Text("Submit"),
            )
          ],
        ));
