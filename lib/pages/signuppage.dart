import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool validateEmail = false;
  bool validatePassword = false;
  bool validateUsername = false;

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage("lib/assets/signin_image.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Image.asset(
                    "lib/assets/applogo.png",
                    // fit: BoxFit.cover,
                  ),
                ),
                const Text(
                  "Hotelovers",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Column(
                    children: [
                      TextField(
                        controller: emailController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'E-mail',
                          hintStyle: const TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          errorText:
                              validateEmail ? "Value Can't Be Empty" : null,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: usernameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Username',
                          hintStyle: const TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          errorText:
                              validateUsername ? "Value Can't Be Empty" : null,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Password',
                          hintStyle: const TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          errorText:
                              validatePassword ? "Value Can't Be Empty" : null,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                          onPressed: () {
                            // Navigator.pop(context);
                            setState(() {
                              validateEmail = emailController.text.isEmpty;
                              validateUsername =
                                  usernameController.text.isEmpty;
                              validatePassword =
                                  passwordController.text.isEmpty;
                            });
                            if (!(validateEmail ||
                                validatePassword ||
                                validateUsername)) {
                              signUp();
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account ?",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            TextButton(
                              child: const Text(
                                "Sign In Now",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // void signUp() async {
  // String username = usernameController.text;
  // String email = emailController.text;
  // String password = passwordController.text;

  // User? user = await auth.signUpWitEmailAndPassword(email, password);

  // if (user != null) {
  //   print("User is successfully created!");
  //   Navigator.pop(context);
  // } else {
  //   print("Fail to signup! error");
  // }
  // }

  Future addUser(String username) async {
    await FirebaseFirestore.instance.collection('User').add({
      'username': username,
    });
  }

  void signUp() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    String email = emailController.text;
    String password = passwordController.text;

    try {
      // Create user
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Add user details
      await FirebaseFirestore.instance.collection('User').add({
        'username': usernameController.text.trim(),
      });

      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text("Account Successfully Registed"),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      );
    }
  }
}
