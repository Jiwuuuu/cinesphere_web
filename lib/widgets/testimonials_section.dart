import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TestimonialsSection extends StatefulWidget {
  final GlobalKey key;

  const TestimonialsSection({required this.key}) : super(key: key);

  @override
  _TestimonialsSectionState createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      color: Color(0xFF07130E),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Customer Testimonials',
            textAlign: TextAlign.center,
            style: GoogleFonts.lexend(
              color: Color(0xFFE2F1EB),
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'What our users are saying about CineSphere! Hear from movie lovers who have experienced the ease and convenience of booking with us.',
            textAlign: TextAlign.center,
            style: GoogleFonts.lexendDeca(
              color: Color(0xFFE2F1EB),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 16),
          CarouselSlider(
            options: CarouselOptions(
              height: 400,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: [
              // Feedback 1
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                ),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFE2F1EB)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: List.generate(5, (index) => Icon(Icons.star, color: Color(0xFFFFA500))),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '"Booking my movie tickets has never been easier. The real-time seat selection is a game-changer!"',
                      style: GoogleFonts.lexendDeca(
                        color: Color(0xFFE2F1EB),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0xFFE2F1EB),
                          radius: 24,
                          child: Icon(Icons.person, color: Color(0xFF07130E)),
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Marie D.',
                              style: GoogleFonts.lexend(
                                color: Color(0xFFE2F1EB),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Entertainment Blogger',
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
                ),
              ),
              // Feedback 2
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                ),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFE2F1EB)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: List.generate(5, (index) => Icon(Icons.star, color: Color(0xFFFFA500))),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '"CineSphere has made family movie nights so much simpler. No more long queues or last-minute bookings!"',
                      style: GoogleFonts.lexendDeca(
                        color: Color(0xFFE2F1EB),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0xFFE2F1EB),
                          radius: 24,
                          child: Icon(Icons.person, color: Color(0xFF07130E)),
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jason R.',
                              style: GoogleFonts.lexend(
                                color: Color(0xFFE2F1EB),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Father of Two',
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
                ),
              ),
              // Feedback 3
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                ),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFE2F1EB)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: List.generate(5, (index) => Icon(Icons.star, color: Color(0xFFFFA500))),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '"I love the seat selection feature! It’s so convenient to see available seats and book instantly!"',
                      style: GoogleFonts.lexendDeca(
                        color: Color(0xFFE2F1EB),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0xFFE2F1EB),
                          radius: 24,
                          child: Icon(Icons.person, color: Color(0xFF07130E)),
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Samantha G.',
                              style: GoogleFonts.lexend(
                                color: Color(0xFFE2F1EB),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Film Enthusiast',
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
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (index) => Container(
                width: 8,
                height: 8,
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index ? Color(0xFFE2F1EB) : Color(0xFFB1C4B9),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
