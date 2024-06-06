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
          
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final hotel = snapshot.data!.docs[index];
                final images = hotel['images'] as List<dynamic>;
                final activities = hotel['activities'] as List<dynamic>;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(hotel['name']),
                    Image.network(
                      hotel['cover'],
                      fit: BoxFit.cover,
                    ),
                    const Text("Images:"),
                    for (var imageUrl in images)
                      Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    Text(hotel['price'].toString()),
                    Text(hotel['location']),
                    Text(hotel['rate'].toString()),
                    Text(hotel['description']),
                    const Text("Activities:"),
                    for (var activity in activities)
                      Image.network(
                        activity["image"].toString(),
                        fit: BoxFit.cover,
                      ),
                    Text(hotel['category']),
                    ElevatedButton(
                      onPressed: () {
                        debugPrint(index.toString());
                      },
                      child: const Text("See Detail"),
                    )
                  ],
                );
                // hotelList.add(hotelwidget);
              },
            );
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
