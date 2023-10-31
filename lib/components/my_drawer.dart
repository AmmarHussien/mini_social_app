import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const DrawerHeader(
                  child: Icon(
                    Icons.favorite,
                  ),
                ),
                // home tile

                const SizedBox(
                  height: 15,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.home,
                    ),
                    title: const Text('H O M E'),
                    onTap: () {
                      // this is already the home screen so just pop drawer
                      Navigator.pop(context);
                    },
                  ),
                ),
                //profile tile
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.person,
                    ),
                    title: const Text('P R O F I L E'),
                    onTap: () {
                      //pop drawer
                      Navigator.pop(context);

                      Navigator.pushNamed(context, '/profile_page');
                    },
                  ),
                ),
                //user tile
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.group,
                    ),
                    title: const Text('U S E R S'),
                    onTap: () {
                      //pop drawer
                      Navigator.pop(context);

                      Navigator.pushNamed(context, '/users_page');
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                leading: const Icon(
                  Icons.logout,
                ),
                title: const Text('L O G O U T'),
                onTap: () {
                  //pop drawer
                  logout();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
