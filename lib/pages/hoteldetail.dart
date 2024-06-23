import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hotel_app/model/hotel.dart';

class HotelDetailPage extends StatelessWidget {
  final Hotel hotel;

  const HotelDetailPage({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hotel.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: hotel.cover,
              height: 300,
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
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Text(
                hotel.location,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[700],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              child: Text(
                '\$${hotel.price} per night',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[700],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                hotel.description,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Row(
                children: buildStarRating(
                  hotel.rate,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Handle booking action here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Booking Successful'),
                    ),
                  );
                },
                child: Text(
                  'Book Now for \$${hotel.price}',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildStarRating(double rate) {
    List<Widget> stars = [];
    for (int i = 1; i <= 5; i++) {
      if (i <= rate) {
        stars.add(
          const Icon(
            Icons.star,
            color: Colors.amber,
          ),
        );
      } else if (i - rate <= 0.5) {
        stars.add(
          const Icon(
            Icons.star_half,
            color: Colors.amber,
          ),
        );
      } else {
        stars.add(
          const Icon(
            Icons.star_border,
            color: Colors.amber,
          ),
        );
      }
    }
    return stars;
  }
}
