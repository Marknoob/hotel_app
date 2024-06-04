import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ModelPage extends StatefulWidget {
  const ModelPage({super.key});

  @override
  State<ModelPage> createState() => _ModelPageState();
}

class _ModelPageState extends State<ModelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
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
    );
  }
}
