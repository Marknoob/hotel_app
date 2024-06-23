import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hotel_app/model/hotel.dart';
import 'package:hotel_app/pages/hoteldetail.dart';

class DiscoveryPage extends StatelessWidget {
  const DiscoveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Hotels'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Hotel').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No hotels available'));
          }

          final hotels = snapshot.data!.docs.map((doc) {
            return Hotel.fromJson(doc.data() as Map<String, dynamic>);
          }).toList();

          return ListView.separated(
            itemBuilder: (context, index) {
              return HotelCard(hotel: hotels[index]);
            },
            separatorBuilder: (context, index) {
              return const Divider(color: Colors.white);
            },
            itemCount: hotels.length,
          );
        },
      ),
    );
  }
}

class HotelCard extends StatelessWidget {
  final Hotel hotel;

  const HotelCard({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HotelDetailPage(hotel: hotel),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 400,
        child: Card(
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: hotel.cover,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  hotel.name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  hotel.location,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Text(
                  '\$${hotel.price} per night',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: buildStarRating(hotel.rate),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildStarRating(double rate) {
    List<Widget> stars = [];
    for (int i = 1; i <= 5; i++) {
      if (i <= rate) {
        stars.add(const Icon(Icons.star, color: Colors.amber));
      } else if (i - rate <= 0.5) {
        stars.add(const Icon(Icons.star_half, color: Colors.amber));
      } else {
        stars.add(const Icon(Icons.star_border, color: Colors.amber));
      }
    }
    return stars;
  }
}
