import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/model/booking.dart';
import 'package:hotel_app/model/hotel.dart';

class BookingDetailPage extends StatelessWidget {
  final Booking booking;
  final Hotel hotel;
  const BookingDetailPage({
    required this.booking,
    required this.hotel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    DateTime bookingDate = DateTime(
        int.parse(booking.date.substring(6)),
        int.parse(booking.date.substring(3, 5)),
        int.parse(booking.date.substring(0, 2)));
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Booking Detail',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF96bdc3),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Booking ID: ${booking.id}',
                style: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl: hotel.cover,
                          imageBuilder: (context, imageProvider) => Container(
                            width: 150,
                            height: 150,
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
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        const SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hotel.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  _generateStars(hotel.rate),
                                  const SizedBox(width: 4),
                                  Text('${hotel.rate}'),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text('Location: ${hotel.location}'),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(hotel.description),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Booking Details',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Check In:',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                'Date: ${bookingDate.toString().substring(0, 10)}',
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Icon(
                                Icons.bedtime,
                                color: Colors.grey,
                                size: 12,
                              ),
                              Text(
                                '${booking.night}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Check Out:',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                'Date: ${bookingDate.add(Duration(days: booking.night)).toString().substring(0, 10)}',
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(),
                      Text('Check In Time: ${booking.checkInTime}'),
                      const SizedBox(height: 4),
                      Text('No. of Guests: ${booking.guest}'),
                      const SizedBox(height: 4),
                      Text(
                          'Breakfast? ${booking.breakfast == 'yes' ? 'Yes' : 'No'}'),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Payment Details',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text('Rate: USD${hotel.price}'),
                      const SizedBox(height: 4),
                      Text('Days of Stay: ${booking.night}'),
                      const SizedBox(height: 4),
                      Text('Service Charge: USD${booking.serviceFee} / day'),
                      const SizedBox(height: 4),
                      const Divider(),
                      const SizedBox(height: 4),
                      Text(
                        'Total Price: USD${booking.totalPayment}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
}
