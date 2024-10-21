import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeaturesSection extends StatelessWidget {
  final GlobalKey key;

  const FeaturesSection({required this.key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 64, vertical: 112),
      color: Color(0xFF07130E),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Features',
            textAlign: TextAlign.center,
            style: GoogleFonts.lexend(
              color: Color(0xFFE2F1EB),
              fontSize: 48,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 40),
          Center(
            child: FeatureItem(
              title: 'Real-Time Seat Selection',
              description: 'Choose your preferred seats with our interactive seating chart that updates in real time based on availability.',
              imagePath: 'assets/images/Logo.png',
            ),
          ),
          SizedBox(height: 16),
          Center(
            child: FeatureItem(
              title: 'Secure Payment Methods',
              description: 'Pay for your tickets with a variety of secure payment options, ensuring your transactions are quick and safe.',
              imagePath: 'assets/images/Logo.png',
            ),
          ),
          SizedBox(height: 16),
          Center(
            child: FeatureItem(
              title: 'No Account Needed',
              description: 'Book tickets without creating an account for a quicker and hassle-free experience.',
              imagePath: 'assets/images/Logo.png',
            ),
          ),
        ],
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  FeatureItem({required this.title, required this.description, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: GoogleFonts.lexend(
            color: Color(0xFFE2F1EB),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        Text(
          description,
          textAlign: TextAlign.center,
          style: GoogleFonts.lexendDeca(
            color: Color(0xFFE2F1EB),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 16),
        Image.asset(
          imagePath,
          height: 100,
          width: 100,
        ),
      ],
    );
  }
}
