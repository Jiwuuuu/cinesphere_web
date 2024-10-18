import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TestimonialsSection extends StatelessWidget {

  final GlobalKey key;

  const TestimonialsSection({required this.key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 64, vertical: 112),
      color: Color(0xFF07130E),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Customer Testimonials',
            textAlign: TextAlign.center,
            style: GoogleFonts.lexend(
              color: Color(0xFFE2F1EB),
              fontSize: 48,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 24),
          Text(
            'What our users are saying about CineSphere! Hear from movie lovers who have experienced the ease and convenience of booking with us.',
            textAlign: TextAlign.center,
            style: GoogleFonts.lexendDeca(
              color: Color(0xFFE2F1EB),
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 40),
          TestimonialItem(name: 'Marie D.', role: 'Entertainment Blogger', quote: 'Booking my movie tickets has never been easier. The real-time seat selection is a game-changer!'),
          SizedBox(height: 40),
          TestimonialItem(name: 'Jason R.', role: 'Father of Two', quote: 'CineSphere has made family movie nights so much simpler. No more long queues or last-minute bookings!'),
          SizedBox(height: 40),
          TestimonialItem(name: 'Samantha G.', role: 'Film Enthusiast', quote: 'I love the seat selection feature! It’s so convenient to see available seats and book instantly!'),
        ],
      ),
    );
  }
}

class TestimonialItem extends StatelessWidget {
  final String name;
  final String role;
  final String quote;

  TestimonialItem({required this.name, required this.role, required this.quote});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '"$quote"',
          style: GoogleFonts.lexend(
            color: Color(0xFFE2F1EB),
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Color(0xFFE2F1EB),
              radius: 28,
              child: Text(
                name[0],
                style: GoogleFonts.lexend(
                  color: Color(0xFF07130E),
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.lexend(
                    color: Color(0xFFE2F1EB),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  role,
                  style: GoogleFonts.lexend(
                    color: Color(0xFFE2F1EB),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
