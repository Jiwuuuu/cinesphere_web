import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeroSection extends StatelessWidget {
  @override
  final GlobalKey key;

  const HeroSection({required this.key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Hero Content Section
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.6, // Adjusted height for the hero text section to be responsive
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 800),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Simplify Your Movie \nExperience with CineSphere',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lexend(
                      color: Color(0xFFE2F1EB),
                      fontSize: MediaQuery.of(context).size.width > 600 ? 48 : 32, // Adjusted font size for responsiveness
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'CineSphere is a mobile app designed to make movie ticket booking fast, easy, and hassle-free. \nWith real-time movie listings, showtimes, seat selection, and secure payments, it brings the cinema to your \nfingertips. No need for lines or complex processes—just browse, book, and enjoy your movie!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lexendDeca(
                      color: Color(0xFFE2F1EB),
                      fontSize: MediaQuery.of(context).size.width > 600 ? 18 : 14, // Adjusted font size for responsiveness
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF8CDDBB),
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: MediaQuery.of(context).size.width > 600 ? 20 : 14), // Adjusted padding for responsiveness
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          'Download Now',
                          style: GoogleFonts.lexendDeca(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xFF1F9060)),
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: MediaQuery.of(context).size.width > 600 ? 20 : 14), // Adjusted padding for responsiveness
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          'Learn more',
                          style: GoogleFonts.lexendDeca(
                            color: Color(0xFFE2F1EB),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 40), // Added spacing between sections
        // New Section for Background Image
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.6, // Adjusted height for the image section to ensure full display on desktop
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/hero_background.png'),
              fit: BoxFit.cover, // Changed to cover to ensure full image display without clipping
            ),
          ),
        ),
      ],
    );
  }
}
