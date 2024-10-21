import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FAQSection extends StatelessWidget {
  final GlobalKey key;

  const FAQSection({required this.key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 64, vertical: 10),
      color: Color(0xFF07130E),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Frequently Asked Questions (FAQs)',
            textAlign: TextAlign.center,
            style: GoogleFonts.lexend(
              color: Color(0xFFE2F1EB),
              fontSize: 48,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Got questions? We’ve got answers! Check out our FAQs to learn more about how CineSphere makes movie booking easier than ever.',
            textAlign: TextAlign.center,
            style: GoogleFonts.lexendDeca(
              color: Color(0xFFE2F1EB),
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 80),
          Center(
            child: FAQItem(question: 'How do I book a movie ticket?', answer: 'Booking a movie ticket is simple. Select the movie you want to watch, choose your preferred showtime, select your seats, and make a secure payment. No account needed—just follow the easy steps!'),
          ),
          SizedBox(height: 16),
          Center(
            child: FAQItem(question: 'Do I need to create an account to use CineSphere?', answer: 'No, you can book tickets without creating an account for a quicker and hassle-free experience.'),
          ),
          SizedBox(height: 16),
          Center(
            child: FAQItem(question: 'What payment methods are accepted?', answer: 'We accept various payment options including credit cards, mobile payments, and online wallets for secure transactions.'),
          ),
        ],
      ),
    );
  }
}

class FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});

  @override
  _FAQItemState createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 768,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xFFE2F1EB)),
        ),
      ),
      child: AnimatedSize(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Column(
          children: [
            ListTile(
              title: Text(
                widget.question,
                style: GoogleFonts.lexend(
                  color: Color(0xFFE2F1EB),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              trailing: Icon(
                _isExpanded ? Icons.expand_less : Icons.expand_more,
                color: Color(0xFFE2F1EB),
              ),
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                  if (_isExpanded) {
                    _controller.forward();
                  } else {
                    _controller.reverse();
                  }
                });
              },
            ),
            SizeTransition(
              sizeFactor: _animation,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Text(
                  widget.answer,
                  style: GoogleFonts.lexend(
                    color: Color(0xFFE2F1EB),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
