import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

// import 'package:hotel_app/widgets/profilepage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: 'Search',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        backgroundColor: Color(0xFF96bdc3),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: kToolbarHeight, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCityItem('Mumbai', 'https://via.placeholder.com/150'),
                    _buildCityItem('Goa', 'https://via.placeholder.com/150'),
                    _buildCityItem(
                        'Chennai', 'https://via.placeholder.com/150'),
                    _buildCityItem('Jaipur', 'https://via.placeholder.com/150'),
                    // Add more cities as needed
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildSectionHeader('Best Hotels', () {
                // Handle 'See All' action
              }),
              const SizedBox(height: 10),
              _buildHotelCard(
                'Melin Greens',
                'https://via.placeholder.com/300',
                120,
                '5.0 (100 Reviews)',
              ),
              const SizedBox(height: 20),
              _buildSectionHeader('Nearby your location', () {
                // Handle 'See All' action
              }),
              const SizedBox(height: 10),
              _buildHotelCard(
                'Melin Greens',
                'https://via.placeholder.com/300',
                110,
                '4.2 (90 Reviews)',
              ),
              _buildHotelCard(
                'Sobro Prime',
                'https://via.placeholder.com/300',
                90,
                '4.5 (120 Reviews)',
              ),
              _buildHotelCard(
                'Paradise Hotel',
                'https://via.placeholder.com/300',
                120,
                '4.8 (150 Reviews)',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCityItem(String cityName, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: CachedNetworkImageProvider(imageUrl),
          ),
          const SizedBox(height: 5),
          Text(cityName),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onSeeAllPressed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: onSeeAllPressed,
          child: const Text('See All'),
        ),
      ],
    );
  }

  Widget _buildHotelCard(
      String hotelName, String imageUrl, int price, String reviews) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotelName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(reviews),
                  const SizedBox(height: 5),
                  Text('\$$price/night'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
