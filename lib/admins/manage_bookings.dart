import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ManageBookingsPage extends StatefulWidget {
  @override
  _ManageBookingsPageState createState() => _ManageBookingsPageState();
}

class _ManageBookingsPageState extends State<ManageBookingsPage> {
  final supabase = Supabase.instance.client;
  List<dynamic> bookings = [];

  @override
  void initState() {
    super.initState();
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    final response = await supabase.from('bookings').select();
    setState(() {
      bookings = response;
    });
  }

  void updateBookingStatus(String bookingId, String newStatus) async {
    await supabase
        .from('bookings')
        .update({'booking_status': newStatus})
        .eq('id', bookingId);
    fetchBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Bookings', style: GoogleFonts.lexend(color: Color(0xFFE2F1EB))),
        backgroundColor: Color(0xFF07130E),
      ),
      body: ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return ListTile(
            title: Text('Movie ID: ${booking['movie_id']}', style: GoogleFonts.lexend(color: Color(0xFFE2F1EB))),
            subtitle: Text('Status: ${booking['booking_status']}', style: GoogleFonts.lexend(color: Color(0xFF8CDDBB))),
            trailing: DropdownButton<String>(
              value: booking['booking_status'],
              items: <String>['Paid', 'Pending', 'Cancelled'].map((String status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  updateBookingStatus(booking['id'], value);
                }
              },
            ),
          );
        },
      ),
      backgroundColor: Color(0xFF07130E),
    );
  }
}
