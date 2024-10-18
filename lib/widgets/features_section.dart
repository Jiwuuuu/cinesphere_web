import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeaturesSection extends StatelessWidget {
  @override
  final GlobalKey key;

  const FeaturesSection({required this.key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 64, vertical: 112),
      color: Color(0xFF07130E),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Features',
            style: GoogleFonts.lexend(
              color: Color(0xFFE2F1EB),
              fontSize: 48,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 40),
          FeatureItem(title: 'Real-Time Seat Selection', description: 'Choose your preferred seats with our interactive seating chart that updates in real time based on availability.'),
          SizedBox(height: 16),
          FeatureItem(title: 'Secure Payment Methods', description: 'Pay for your tickets with a variety of secure payment options, ensuring your transactions are quick and safe.'),
          SizedBox(height: 16),
          FeatureItem(title: 'No Account Needed', description: 'Book tickets without creating an account for a quicker and hassle-free experience.'),
        ],
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final String title;
  final String description;

  const FeatureItem({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          style: GoogleFonts.lexendDeca(
            color: Color(0xFFE2F1EB),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}