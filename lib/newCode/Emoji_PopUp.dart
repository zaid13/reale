import 'package:flutter/material.dart';
import 'package:emoji_picker/emoji_picker.dart';




class MainPage extends StatefulWidget {

  @override
  MainPageState createState() => new MainPageState();

}

class MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {


    return EmojiPicker(
      rows: 3,
      columns: 7,
      buttonMode: ButtonMode.MATERIAL,
      recommendKeywords: ["racing", "horse"],
      numRecommended: 10,
      onEmojiSelected: (emoji, category) {
        print(emoji);
      },
    );

  }

}