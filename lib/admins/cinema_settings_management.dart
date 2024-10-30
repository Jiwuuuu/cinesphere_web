import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CinemaSettingsManagementPage extends StatefulWidget {
  @override
  _CinemaSettingsManagementPageState createState() => _CinemaSettingsManagementPageState();
}

class _CinemaSettingsManagementPageState extends State<CinemaSettingsManagementPage> {
  final supabase = Supabase.instance.client;
  final TextEditingController dateController = TextEditingController();
  final TextEditingController screenTypeController = TextEditingController();
  final TextEditingController scheduleController = TextEditingController();

  Future<void> addCinemaSetting() async {
    await supabase.from('cinema_settings').insert({
      'available_date': dateController.text,
      'screen_type': screenTypeController.text,
      'schedule_time': scheduleController.text,
    });
    dateController.clear();
    screenTypeController.clear();
    scheduleController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Cinema Settings', style: GoogleFonts.lexend(color: Color(0xFFE2F1EB))),
        backgroundColor: Color(0xFF07130E),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: dateController,
              decoration: InputDecoration(labelText: 'Available Date (YYYY-MM-DD)'),
            ),
            TextField(
              controller: screenTypeController,
              decoration: InputDecoration(labelText: 'Screen Type'),
            ),
            TextField(
              controller: scheduleController,
              decoration: InputDecoration(labelText: 'Schedule Time (HH:MM:SS)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addCinemaSetting,
              child: Text('Add Cinema Setting'),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFF07130E),
    );
  }
}
