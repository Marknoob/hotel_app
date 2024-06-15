import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/model/booking.dart';
import 'package:hotel_app/model/hotel.dart';
import 'package:hotel_app/pages/bookingdetailpage.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String currentFilter = "upcoming";
  List<Booking> listBooking = [];
  List<Hotel> listHotel = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bookings",
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF96bdc3),
      ),
      body: RefreshIndicator(
        onRefresh: getListBooking,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Column(
            children: [
              _buildHeader("upcoming"),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: listBooking.length,
                  itemBuilder: (context, index) {
                    return _buildCard(
                      listBooking[index],
                      listHotel[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 8);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String currentBooking) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildHeaderButton(
              "Upcoming", "upcoming", currentFilter == "upcoming"),
          _buildHeaderButton("Past", "past", currentFilter == "past"),
        ],
      ),
    );
  }

  Widget _buildHeaderButton(String text, String value, bool active) {
    return Expanded(
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        onTap: () {
          setState(() {
            currentFilter = value;
            getListBooking();
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: active ? const Color(0xff778795) : Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(color: active ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _generateStars(double rating) {
    List<Widget> listStars = [];
    for (int i = 1; i <= 5; i++) {
      if (i <= rating) {
        listStars.add(
          const Icon(
            Icons.star,
            color: Color(0xfffcc900),
          ),
        );
      } else {
        listStars.add(const Icon(Icons.star_border));
      }
    }
    return Wrap(children: listStars);
  }

  Widget _buildCard(Booking booking, Hotel hotel) {
    return Card(
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ID: ${booking.id}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              "Date: ${booking.date}",
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                CachedNetworkImage(
                  imageUrl: hotel.cover,
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
                  placeholder: (context, url) => const SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                const SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        _generateStars(hotel.rate),
                        const SizedBox(width: 4),
                        Text("${hotel.rate}"),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(hotel.name),
                    const SizedBox(height: 4),
                    Text(hotel.location),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xff5b6961),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BookingDetailPage(
                          booking: booking,
                          hotel: hotel,
                        ),
                      ),
                    );
                  },
                  child: const Text(" Detail"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> getListBooking() async {
    List<Booking> tempBooking = [];
    List<Hotel> tempHotel = [];
    final FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser == null) {
      return;
    }

    await FirebaseFirestore.instance
        .collection("Booking")
        .where('id_user', isEqualTo: auth.currentUser?.uid)
        .where('status', isEqualTo: 'success')
        .get()
        .then(
      (value) async {
        for (var item in value.docs) {
          Booking booking = Booking.fromJson(item.data());
          DateTime bookingDate = DateTime(
              int.parse(booking.date.substring(6)),
              int.parse(booking.date.substring(3, 5)),
              int.parse(booking.date.substring(0, 2)));
          if (currentFilter == "upcoming") {
            if (bookingDate.isAfter(DateTime.now()) ||
                bookingDate.isAtSameMomentAs(DateTime.now())) {
              tempBooking.add(booking);
            }
          } else if (currentFilter == "past") {
            if (bookingDate.isBefore(DateTime.now())) {
              tempBooking.add(booking);
            }
          }
        }
        await FirebaseFirestore.instance
            .collection("Hotel")
            .where('id', whereIn: tempBooking.map((e) => e.idHotel))
            .get()
            .then(
          (value) {
            for (var item in value.docs) {
              Hotel hotel = Hotel.fromJson(item.data());
              tempHotel.add(hotel);
            }
          },
        );
        setState(() {
          listHotel = tempHotel;
          listBooking = tempBooking;
        });
      },
    );
  }
}
