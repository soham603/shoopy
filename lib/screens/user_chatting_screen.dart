import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoopy/model/usersc_model.dart';

class UserChattingScreen extends StatefulWidget {
  final Userr user;
  const UserChattingScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<UserChattingScreen> createState() => _UserChattingScreenState();
}

class _UserChattingScreenState extends State<UserChattingScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<String> _messages = []; // List to store chat messages

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 60,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255,124,123,155),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.user.name, style: TextStyle(color: Colors.white),),
                const SizedBox(height: 2),
                if (widget.user.isOnline)
                  Text(
                      'Online',
                      style: GoogleFonts.poppins(color: Colors.white, fontSize: 15)
                  ),
                if (!widget.user.isOnline)
                  Text(
                    'last seen few time ago',
                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 15),
                  ),
              ],
            ),
            Row(
              children: [
                IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.phone, color: Colors.white,)),
                IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.video, color: Colors.white,)),
                IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.circleInfo, color: Colors.white,)),

              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: BubbleNormal(
                    text: _messages[index],
                    isSender: false,
                    color: const Color(0xFF1B97F3),
                    tail: true,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ),


          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255,238,238,238),
            ),
            child: Row(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.add_a_photo, color: Colors.blue,size: 25,)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.attachment, color: Colors.blue,size: 25,)),
                Expanded(
                  child: TextField(
                    cursorColor: Colors.blue,
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _sendMessage();
                  },
                  icon: const Icon(Icons.send_rounded, color: Colors.blue, size: 30,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  void _sendMessage() {
    setState(() {
      _messages.add(_textController.text);
      _textController.clear();
    });
  }
}
