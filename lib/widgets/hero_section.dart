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
        Container(
          padding: EdgeInsets.symmetric(horizontal: 64, vertical: 112),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Simplify Your Movie Experience with CineSphere',
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(
                  color: Color(0xFFE2F1EB),
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 24),
              Text(
                'CineSphere provides a seamless digital movie ticket booking experience.\nExplore your favorite movies, choose seats, and book tickets securely all in one platform.',
                textAlign: TextAlign.center,
                style: GoogleFonts.lexendDeca(
                  color: Color(0xFFE2F1EB),
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF8CDDBB)),
                    child: Text(
                      'Get started',
                      style: GoogleFonts.lexendDeca(color: Colors.black,),
                    ),
                  ),
                  SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Color(0xFF1F9060)),
                    ),
                    child: Text(
                      'Learn more',
                      style: GoogleFonts.lexendDeca(color: Color(0xFFE2F1EB)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 80),
        Container(
          width: double.infinity,
          height: 500,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Color(0xFF07130E),
              ],
            ),
            image: DecorationImage(
              image: AssetImage('assets/images/hero_background.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
