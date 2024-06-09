import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String currentFilter = "upcoming";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Bookings",
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Column(
            children: [
              _buildHeader("upcoming"),
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

  Widget _buildCard() {
    return Card();
  }
}
