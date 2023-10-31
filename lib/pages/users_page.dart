import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_social_app/components/my_back_button.dart';
import 'package:mini_social_app/components/my_list_tile.dart';
import 'package:mini_social_app/helper/helper_function.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context, snapshot) {
          // error

          if (snapshot.hasError) {
            displayMessageToUser('SomeThing went wrong', context);
          }
          // show loading
          else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data == null) {
            return const Text('No Data');
          }
          //get all users

          final users = snapshot.data!.docs;

          return SafeArea(
            child: Column(
              children: [
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: MyBackButton(),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        // get indevidual user

                        final user = users[index];

                        String userName = user['username'];
                        String userEmail = user['email'];

                        return MyListTile(
                          message: userName,
                          userEmail: userEmail,
                        );
                      }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
