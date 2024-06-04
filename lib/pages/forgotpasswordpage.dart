import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();
  bool validate = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color(0xFFccc6a7),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 8,
              ),
              child: Column(
                children: [
                  const Text(
                    "Forgot Password",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3.5,
                          child: Image.asset(
                            "lib/assets/forgot_password_icon.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 60),
                        const Text(
                          "Enter your email and we will send you a password reset link",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: 'E-mail',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                            focusedBorder: const OutlineInputBorder(),
                            errorText: validate ? "Value Can't Be Empty" : null,
                          ),
                        ),
                        const SizedBox(height: 20),
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              validate = emailController.text.isEmpty;
                            });
                            if (!validate) {
                              resetPassword();
                            }
                          },
                          color: Colors.amber,
                          child: const Text("Reset Password"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void resetPassword() async {
    String email = emailController.text.trim();

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text("Password reset link sent! Check your email"),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      print("ININERORBRO: $e");
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

  // void resetPassword() async {
  //   String email = emailController.text;
  //   try {
  //     await auth.sendPasswordResetEmail(email);
  //   } catch (e) {
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           content: Text(e.toString()),
  //         );
  //       },
  //     );
  //   }
  // }
}
