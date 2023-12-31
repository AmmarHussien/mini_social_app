import 'package:flutter/material.dart';
import 'package:mini_social_app/components/my_drawer.dart';
import 'package:mini_social_app/components/my_list_tile.dart';
import 'package:mini_social_app/components/my_post_button.dart';
import 'package:mini_social_app/components/my_textfield.dart';
import 'package:mini_social_app/data/firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final FiresstoreDatabase database = FiresstoreDatabase();

  final TextEditingController newPostController = TextEditingController();

  void postMessage() {
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
    }

    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text(
          'W A L L',
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          // textfield box for user to type
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
            child: Row(
              children: [
                Expanded(
                  child: MyTextField(
                    hintText: 'Say Something',
                    obscureText: false,
                    controller: newPostController,
                  ),
                ),
                PostButton(
                  onTap: postMessage,
                ),
              ],
            ),
          ),

          StreamBuilder(
            stream: database.getPostStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final posts = snapshot.data!.docs;

              if (snapshot.data == null) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(
                      25,
                    ),
                    child: Text(
                      'No Posts.. Post something!',
                    ),
                  ),
                );
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];

                    String message = post['PostMessage'];
                    String userEmail = post['UserEmail'];
                    //Timestamp timestamp = post['timestamp'];

                    return MyListTile(
                      message: message,
                      userEmail: userEmail,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
