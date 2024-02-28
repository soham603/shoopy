import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoopy/screens/user_chatting_screen.dart';
import 'package:shoopy/services/search_provider.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 65,
          title:  Padding(
            padding: EdgeInsets.only(left: 2, top: 10),
            child: Text(
              'Chats',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
          actions: [
            Consumer<UserProvider>(
              builder: (context, userProvider, _) => IconButton(
                onPressed: userProvider.toggleSearchBar,
                icon: const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.search, size: 30, color: Colors.red, shadows: [
                    Shadow(color: Colors.redAccent, blurRadius: 5)
                  ]),
                ),
              ),
            ),
            const GlowingAddButton(),
          ],
        ),
        body: Column(
          children: [
            Consumer<UserProvider>(
              builder: (context, userProvider, _) {
                if (userProvider.showSearchBar) {
                  return Column(
                    children: [
                      const SizedBox(height: 15),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 25,
                        child: TextField(
                          controller: userProvider.searchController,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            filled: true,
                            fillColor: Colors.black12,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            labelText: "Search ...",
                            alignLabelWithHint: false,
                            prefixIcon: const Icon(Icons.search),
                            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            Expanded(
              child: Consumer<UserProvider>(
                builder: (context, userProvider, _) => ListView.builder(
                  itemCount: userProvider.filteredUsers.length,
                  itemBuilder: (context, index) {
                    final userData = userProvider.filteredUsers[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserChattingScreen(user: userData),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 16.0),
                        child: Row(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                const Icon(Icons.account_circle, size: 50),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: OnlineIndicator(
                                    isOnline: userData.isOnline,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 16.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(userData.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
                                Text(userData.email, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.grey),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GlowingAddButton extends StatelessWidget {
  const GlowingAddButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => UploadVideo()));
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 22),
        child: Container(
          height: 30,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color.fromARGB(255, 254, 199, 246),
            boxShadow: [
              BoxShadow(
                color: CupertinoColors.systemPink.withOpacity(0.5),
                blurRadius: 8.0,
                spreadRadius: 2.0,
              ),
            ],
          ),
          child: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: CupertinoColors.systemPink,
                  size: 25,
                ),
                SizedBox(width: 3),
                Text(
                  'New',
                  style: TextStyle(
                    fontSize: 16,
                    color: CupertinoColors.systemPink,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OnlineIndicator extends StatelessWidget {
  final bool isOnline;

  const OnlineIndicator({Key? key, required this.isOnline}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isOnline ? Colors.green : Colors.red,
        border: Border.all(width: 2, color: Colors.white),
      ),
    );
  }
}
