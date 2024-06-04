import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:hotel_app/widgets/profilepage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: kToolbarHeight,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sup homies, ",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "here is the best hotel ever!",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(
                    Icons.account_circle_sharp,
                    size: 55,
                  ),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();

                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => const ProfilePage(),
                    //   ),
                    // );
                  },
                ),
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Hotel').snapshots(),
            builder: (context, snapshot) {
              List<Column> hotelList = [];
              // print("AHAI: ${snapshot.data?.docs.reversed.toList()}");

              if (snapshot.hasData) {
                final hotels = snapshot.data?.docs.reversed.toList();
                for (var hotel in hotels!) {
                  final hotelwidget = Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(hotel['name']),
                      Image.network(
                        hotel['cover'],
                        fit: BoxFit.cover,
                      ),
                      const Text("Images:"),
                      Image.network(
                        hotel['images'][0],
                        fit: BoxFit.cover,
                      ),
                      Image.network(
                        hotel['images'][1],
                        fit: BoxFit.cover,
                      ),
                      Image.network(
                        hotel['images'][2],
                        fit: BoxFit.cover,
                      ),
                      Text(hotel['price'].toString()),
                      Text(hotel['location']),
                      Text(hotel['rate'].toString()),
                      Text(hotel['description']),
                      const Text("Activities:"),
                      Image.network(
                        hotel['activities'][0]["image"].toString(),
                        fit: BoxFit.cover,
                      ),
                      Image.network(
                        hotel['activities'][1]["image"].toString(),
                        fit: BoxFit.cover,
                      ),
                      Text(hotel['category']),
                    ],
                  );
                  hotelList.add(hotelwidget);
                }
              }

              return Expanded(
                child: ListView(
                  children: hotelList,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
