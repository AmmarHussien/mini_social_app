import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_social_app/components/my_button.dart';
import 'package:mini_social_app/components/my_textfield.dart';
import 'package:mini_social_app/helper/helper_function.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
    required this.onTap,
  });

  final void Function()? onTap;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  void registerUser() async {
    // show loading indicator
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // make sure password is match

    if (passwordController.text != confirmPasswordController.text) {
      // pop loading indicator
      Navigator.pop(context);

      //show error message
      displayMessageToUser(
        'password is not match!',
        context,
      );
    } else {
      try {
        // create the user

        UserCredential? userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        //pop loading indicator
        if (!context.mounted) return;
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        //pop loading indicator
        Navigator.pop(context);

        //display error message
        displayMessageToUser(
          e.code,
          context,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                Icon(
                  Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                const SizedBox(
                  height: 25,
                ),

                // app name
                const Text(
                  'M I N I M A L',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                //Username text field
                MyTextField(
                  hintText: 'User Name',
                  obscureText: false,
                  controller: usernameController,
                ),
                const SizedBox(
                  height: 15,
                ),
                //email text field
                MyTextField(
                  hintText: 'Email',
                  obscureText: false,
                  controller: emailController,
                ),
                const SizedBox(
                  height: 15,
                ),
                //password text field
                MyTextField(
                  hintText: 'Password',
                  obscureText: true,
                  controller: passwordController,
                ),
                const SizedBox(
                  height: 15,
                ),
                //password text field
                MyTextField(
                  hintText: 'Confirm Password',
                  obscureText: true,
                  controller: confirmPasswordController,
                ),
                const SizedBox(
                  height: 15,
                ),
                // // forgot password
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Text(
                //       'Forgot Password',
                //       style: TextStyle(
                //         color: Theme.of(context).colorScheme.inversePrimary,
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(
                //   height: 25,
                // ),
                // login button
                MyButton(
                  text: 'Register',
                  onTap: registerUser,
                ),
                const SizedBox(
                  height: 15,
                ),
                // do not have account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        " Login Here",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
