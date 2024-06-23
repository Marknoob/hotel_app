import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(130.0), // Adjust the height as needed
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 10.0),
                child: const Text(
                  'Hotelovers',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Search',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Handle button press action
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        backgroundColor: Colors.blue, // Button color
                      ),
                      child: const Icon(
                        Icons.filter_list_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: const Color(0xFF96bdc3),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
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
              StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('Hotel').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    final hotels = snapshot.data!.docs;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 140,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: hotels.map((hotel) {
                              return _buildCityItem(
                                  hotel['location'], hotel['cover']);
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildSectionHeader('Best Hotels', () {
                          // Handle 'See All' action
                        }),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 315,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: hotels.map((hotel) {
                              return _buildHotelItem(
                                hotel['name'],
                                hotel['cover'],
                                hotel['location'],
                                hotel['rate'] != null
                                    ? hotel['rate'].toDouble()
                                    : 0.0,
                                hotel['price'] != null
                                    ? hotel['price'].toDouble()
                                    : 0.0,
                              );
                            }).toList(),
                          ),
                        ),
                        _buildSectionHeader('Nearby your location', () {
                          // Handle 'See All' action
                        }),
                        const SizedBox(height: 10),
                        Column(
                          children: hotels.map((hotel) {
                            return _buildHotelItemShort(
                              hotel['name'],
                              hotel['cover'],
                              hotel['location'],
                              hotel['rate'] != null
                                  ? hotel['rate'].toDouble()
                                  : 0.0,
                              hotel['price'] != null
                                  ? hotel['price'].toDouble()
                                  : 0.0,
                            );
                          }).toList(),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCityItem(String cityName, String imageUrl) {
    return SizedBox(
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              height: 90, // Fixed height for the city item image
              width: 90,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            cityName,
            style: const TextStyle(fontSize: 16),
            overflow: TextOverflow.ellipsis, // Hide text if it overflows
          ),
        ],
      ),
    );
  }

  Widget _buildHotelItemShort(String hotelName, String imageUrl,
      String location, double rating, double price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            height: 100,
            width: 80,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        title: Text(
          hotelName,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              location,
              style: const TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                ...buildStarRating(rating),
              ],
            ),
            Text(
              '\$$price/night',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHotelItem(String hotelName, String imageUrl, String location,
      double rating, double price) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SizedBox(
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                height: 170,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              hotelName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              location,
              style: const TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                ...buildStarRating(rating),
              ],
            ),
            Text(
              '\$$price/night',
              style: const TextStyle(fontWeight: FontWeight.bold),
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
        stars.add(const Icon(Icons.star, color: Colors.amber));
      } else if (i - rate <= 0.5) {
        stars.add(const Icon(Icons.star_half, color: Colors.amber));
      } else {
        stars.add(const Icon(Icons.star_border, color: Colors.amber));
      }
    }
    return stars;
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
}

void main() {
  runApp(const MaterialApp(
    home: HomePage(),
  ));
}
