import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/pages/edit_profile_page.dart';
import 'package:hotel_app/pages/forgotpasswordpage.dart';
import 'package:hotel_app/pages/privacy_policy_page.dart';
import 'package:hotel_app/pages/signinpage.dart';
import 'package:hotel_app/pages/terms_conditions_page.dart';
import 'package:hotel_app/widgets/historypage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<Map<String, dynamic>> _fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      debugPrint('User ID: ${user.uid}');
      try {
        final DocumentSnapshot<Map<String, dynamic>> userData =
            await FirebaseFirestore.instance
                .collection('User')
                .doc(user.uid)
                .get();
        if (userData.exists) {
          final data = userData.data();
          if (data != null) {
            debugPrint('User Data: ${data.toString()}');
            return data;
          } else {
            debugPrint('Document is empty');
          }
        } else {
          debugPrint('Document does not exist');
        }
      } catch (e) {
        debugPrint('Error fetching user data: $e');
      }
    } else {
      debugPrint('User is not logged in');
    }
    return {};
  }

  // Future<Map<String, dynamic>> _fetchUserData() async {
  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     try {
  //       final snapshot = await FirebaseFirestore.instance
  //           .collection('User')
  //           .doc(user.uid)
  //           .get();

  //       if (snapshot.exists) {
  //         Map<String, dynamic>? data = snapshot.data();
  //         String? username = data?['username'];
  //         String? useremail = data?['email'];

  //         // Mengembalikan username dan email dalam bentuk map
  //         debugPrint("FETCH1: $username, $useremail");
  //         return {
  //           'username': username,
  //           'email': useremail,
  //         };
  //       } else {
  //         debugPrint("FETCH1: User not found");
  //         return {};
  //       }
  //     } catch (error) {
  //       debugPrint("FETCH1: Error - $error");
  //       return {};
  //     }
  //   } else {
  //     debugPrint("FETCH1: No user logged in");
  //     return {};
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        backgroundColor: const Color(0xFF96bdc3),
      ),
<<<<<<< Updated upstream
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              color: const Color(0xFF778795),
              child: const Column(
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    // backgroundImage: AssetImage(
                    //   'assets/profile.jpg',
                    // ), // replace with your image path
                  ),
                  SizedBox(height: 15.0, width: 600.0),
                  Text(
                    'User',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    'user@example.com',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Profile'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EditProfilePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Change Password'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ForgotPasswordPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('My Bookings'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HistoryPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip),
              title: const Text('Privacy Policy'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PrivacyPolicyPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.article),
              title: const Text('Terms & Conditions'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TermsConditionsPage()),
                );
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                // primary: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(
                    horizontal: 50.0, vertical: 15.0),
                textStyle: const TextStyle(fontSize: 16.0),
              ),
              child: const Text('Logout'),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),

      // body: FutureBuilder<Map<String, dynamic>>(
      //   future: _fetchUserData(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(child: CircularProgressIndicator());
      //     }
      //     if (snapshot.hasError || !snapshot.hasData) {
      //       return const Center(child: Text('Error fetching user data'));
      //     }
      //     final userData = snapshot.data!;
      //     return SingleChildScrollView(
      //       child: Column(
      //         children: [
      //           Container(
      //             padding: const EdgeInsets.all(20.0),
      //             color: const Color(0xFF778795),
      //             child: Column(
      //               children: [
      //                 CircleAvatar(
      //                   radius: 50.0,
      //                   backgroundImage: userData['profilePicture'] != null
      //                       ? CachedNetworkImageProvider(userData['profilePicture'])
      //                       : const AssetImage('assets/profile.jpg'),
      //                 ),
      //                 const SizedBox(height: 15.0),
      //                 Text(
      //                   userData['name'] ?? 'No Name',
      //                   style: const TextStyle(
      //                     color: Colors.white,
      //                     fontSize: 20.0,
      //                   ),
      //                 ),
      //                 const SizedBox(height: 5.0),
      //                 Text(
      //                   userData['email'] ?? 'No Email',
      //                   style: const TextStyle(
      //                     color: Colors.white70,
      //                     fontSize: 14.0,
      //                   ),
      //                 ),
      //                 const SizedBox(height: 10.0),
      //               ],
=======
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       Container(
      //         padding: const EdgeInsets.all(20.0),
      //         color: const Color(0xFF778795),
      //         child: const Column(
      //           children: [
      //             CircleAvatar(
      //               radius: 50.0,
      //               backgroundImage: AssetImage(
      //                   'assets/profile.jpg'), // replace with your image path
>>>>>>> Stashed changes
      //             ),
      //             SizedBox(height: 15.0, width: 600.0),
      //             Text(
      //               'Curtis Weaver',
      //               style: TextStyle(
      //                 color: Colors.white,
      //                 fontSize: 20.0,
      //               ),
      //             ),
      //             SizedBox(height: 5.0),
      //             Text(
      //               'curtis.weaver@example.com',
      //               style: TextStyle(
      //                 color: Colors.white70,
      //                 fontSize: 14.0,
      //               ),
      //             ),
      //             SizedBox(height: 10.0),
      //           ],
      //         ),
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.edit),
      //         title: const Text('Edit Profile'),
      //         trailing: const Icon(Icons.arrow_forward_ios),
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) => const EditProfilePage()),
      //           );
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.lock),
      //         title: const Text('Change Password'),
      //         trailing: const Icon(Icons.arrow_forward_ios),
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) => const ForgotPasswordPage()),
      //           );
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.book),
      //         title: const Text('My Bookings'),
      //         trailing: const Icon(Icons.arrow_forward_ios),
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) => const HistoryPage()),
      //           );
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.privacy_tip),
      //         title: const Text('Privacy Policy'),
      //         trailing: const Icon(Icons.arrow_forward_ios),
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) => const PrivacyPolicyPage()),
      //           );
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.article),
      //         title: const Text('Terms & Conditions'),
      //         trailing: const Icon(Icons.arrow_forward_ios),
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) => const TermsConditionsPage()),
      //           );
      //         },
      //       ),
      //       const SizedBox(height: 20.0),
      //       ElevatedButton(
      //         onPressed: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => const SignInPage()),
      //           );
      //         },
      //         child: const Text('Logout'),
      //         style: ElevatedButton.styleFrom(
      //           // primary: Colors.blueAccent,
      //           padding: const EdgeInsets.symmetric(
      //               horizontal: 50.0, vertical: 15.0),
      //           textStyle: const TextStyle(fontSize: 16.0),
      //         ),
      //       ),
      //       const SizedBox(height: 20.0),
      //     ],
      //   ),
      // ),

      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData) {
            debugPrint('debug: ${snapshot.toString()}');
            return const Center(child: Text('Error fetching user data'));
          }
          final userData = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20.0),
                  color: const Color(0xFF778795),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: userData['profilePicture'] != null
                            ? CachedNetworkImageProvider(
                                userData['profilePicture'])
                            : const AssetImage('assets/profile.jpg'),
                      ),
                      const SizedBox(height: 15.0, width: 1500.0),
                      Text(
                        userData['username'] ?? 'No Name',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        userData['email'] ?? 'No Email',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14.0,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('Edit Profile'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditProfilePage()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.lock),
                  title: const Text('Change Password'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgotPasswordPage()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.book),
                  title: const Text('My Bookings'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HistoryPage()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.privacy_tip),
                  title: const Text('Privacy Policy'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PrivacyPolicyPage()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.article),
                  title: const Text('Terms & Conditions'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TermsConditionsPage()),
                    );
                  },
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInPage()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50.0, vertical: 15.0),
                    textStyle: const TextStyle(fontSize: 16.0),
                  ),
                  child: const Text('Logout'),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          );
        },
      ),
    );
  }
}
