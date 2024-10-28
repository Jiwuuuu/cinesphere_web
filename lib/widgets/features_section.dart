import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeaturesSection extends StatelessWidget {
  @override
  final GlobalKey key;

  const FeaturesSection({required this.key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      color: Color(0xFF07130E),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Features Section Heading
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
          // Browse Movies Feature
          FeatureWithImage(
            title: 'Browse Movies',
            description:
                'Easily discover the latest movie releases, complete with detailed information like trailers, genre, and summary, all in one place.',
            imagePath: 'assets/images/browse_movies.png',
            benefits: [
              'See trailers to provide an initial quick look.',
              'Keep updated with the latest releases.',
              'Helps users make informed decisions about what’s worth watching.',
            ],
            isImageRight: false,
          ),
          SizedBox(height: 80),
          // Real-Time Seat Selection Feature
          FeatureWithImage(
            title: 'Real-Time Seat Selection',
            description:
                'Choose your preferred seats with our interactive seating chart that updates in real time based on availability.',
            imagePath: 'assets/images/realtime_seatselection.png',
            benefits: [
              'Ensure you get the best seats for the preferred experience.',
              'Enables hassle-free picking and booking in real time.',
              'Simplifies the booking process with a clear idea of available spots.',
            ],
            isImageRight: true,
          ),
          SizedBox(height: 80),
          // Secure Payment Methods Feature
          FeatureWithImage(
            title: 'Secure Payment Methods',
            description:
                'Pay for your tickets with a variety of secure payment options, ensuring your transactions are quick and safe.',
            imagePath: 'assets/images/secure_payment_methods.png',
            benefits: [
              'Provides ease of multiple payment options.',
              'Ensures secure transactions.',
              'Simplifies the journey from browsing to booking for a seamless experience.',
            ],
            isImageRight: false,
          ),
        ],
      ),
    );
  }
}

class FeatureWithImage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final List<String> benefits;
  final bool isImageRight;

  const FeatureWithImage({super.key, 
    required this.title,
    required this.description,
    required this.imagePath,
    required this.benefits,
    required this.isImageRight,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          // Mobile view - image on top, text below
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16),
              _buildTextContent(),
            ],
          );
        } else {
          // Desktop view - image and text side by side
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!isImageRight) _buildImage(),
              if (!isImageRight) SizedBox(width: 40),
              Expanded(child: _buildTextContent()),
              if (isImageRight) SizedBox(width: 40),
              if (isImageRight) _buildImage(),
            ],
          );
        }
      },
    );
  }

  Widget _buildImage() {
    return Expanded(
      flex: 1,
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildTextContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: GoogleFonts.lexend(
            color: Color(0xFFE2F1EB),
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 16),
        Text(
          description,
          style: GoogleFonts.lexendDeca(
            color: Color(0xFFE2F1EB),
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: benefits
              .map(
                (benefit) => Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.check, color: Color(0xFF8CDDBB), size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          benefit,
                          style: GoogleFonts.lexendDeca(
                            color: Color(0xFFE2F1EB),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
