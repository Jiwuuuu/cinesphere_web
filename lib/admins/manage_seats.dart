import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ManageSeatsPage extends StatefulWidget {
  final String cinemaSettingsId;

  ManageSeatsPage({required this.cinemaSettingsId});

  @override
  _ManageSeatsPageState createState() => _ManageSeatsPageState();
}

class _ManageSeatsPageState extends State<ManageSeatsPage> {
  final supabase = Supabase.instance.client;
  List<dynamic> seats = [];

  @override
  void initState() {
    super.initState();
    fetchSeats();
  }

  Future<void> fetchSeats() async {
    final response = await supabase
        .from('seats')
        .select()
        .eq('cinema_settings_id', widget.cinemaSettingsId);
    setState(() {
      seats = response;
    });
  }

  void toggleSeatAvailability(String seatId, bool isBooked) async {
    await supabase
        .from('seats')
        .update({'is_booked': !isBooked})
        .eq('id', seatId);
    fetchSeats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Seats', style: GoogleFonts.lexend(color: Color(0xFFE2F1EB))),
        backgroundColor: Color(0xFF07130E),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, childAspectRatio: 2),
        itemCount: seats.length,
        itemBuilder: (context, index) {
          final seat = seats[index];
          final isBooked = seat['is_booked'] as bool;
          return GestureDetector(
            onTap: () => toggleSeatAvailability(seat['id'], isBooked),
            child: Container(
              margin: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: isBooked ? Colors.red : Color(0xFF8CDDBB),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  seat['seat_number'],
                  style: GoogleFonts.lexend(color: Color(0xFFE2F1EB)),
                ),
              ),
            ),
          );
        },
      ),
      backgroundColor: Color(0xFF07130E),
    );
  }
}
