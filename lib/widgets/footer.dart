import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'adminLogin.dart';

class Footer extends StatelessWidget {
  @override
  final GlobalKey key;

  const Footer({required this.key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(32),
      color: Color(0xFF07130E),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '© 2024 CineSphere. All rights reserved.',
            style: GoogleFonts.lexend(
              color: Color(0xFFE2F1EB),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 16),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            runSpacing: 8,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'Privacy Policy',
                  style: GoogleFonts.lexend(
                    color: Color(0xFFE2F1EB),
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Terms of Service',
                  style: GoogleFonts.lexend(
                    color: Color(0xFFE2F1EB),
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Cookies Settings',
                  style: GoogleFonts.lexend(
                    color: Color(0xFFE2F1EB),
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text(
                  'Login as Admin?',
                  style: GoogleFonts.lexend(
                    color: Color(0xFFE2F1EB),
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
