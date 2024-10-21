import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BrowseMoviesSection extends StatelessWidget {
  final GlobalKey key;

  const BrowseMoviesSection({required this.key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 64, vertical: 40),
      color: Color(0xFF07130E),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Browse Movies',
            textAlign: TextAlign.center,
            style: GoogleFonts.lexend(
              color: Color(0xFFE2F1EB),
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Find your favorite movies with ease. View trailers, ratings, and reviews to choose the perfect movie for your next adventure.',
            textAlign: TextAlign.center,
            style: GoogleFonts.lexendDeca(
              color: Color(0xFFE2F1EB),
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 40),
          Image.asset(
            'assets/images/browse_movies.png',
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
