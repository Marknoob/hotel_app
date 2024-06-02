// import 'package:firebase_auth/firebase_auth.dart';

// class FirebaseAuthService {
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  // Future<User?> signUpWitEmailAndPassword(String email, String password) async {
  //   try {
  //     UserCredential credential = await _auth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     return credential.user;
  //   } catch (e) {
  //     print("Some Error Occured When SignUp");
  //   }
  //   return null;
  // }

  // Future<User?> signInWitEmailAndPassword(String email, String password) async {
  //   try {
  //     UserCredential credential = await _auth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     return credential.user;
  //   } catch (e) {
  //     print("Some Error Occured When SignIn");
  //   }
  //   return null;
  // }

  // Future<FirebaseAuthException?> sendPasswordResetEmail(String email) async {
  //   try {
  //     print("emailku $email");
  //     await _auth.sendPasswordResetEmail(
  //       email: email.trim(),
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     print("Some Error Occured When Reset Password");
  //     return (e);
  //   }
  //   return null;
  // }
// }
