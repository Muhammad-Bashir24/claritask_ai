import 'package:claritask_ai/shared/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';

class LandingTestimonialsSection extends StatelessWidget {
  const LandingTestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      padding: EdgeInsets.symmetric(
        horizontal: context.isMobile ? 20 : 32,
        vertical: 64,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF59E0B).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'PROVEN BY 2,500+ USERS',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD97706),
                letterSpacing: 1.0,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Loved by People Who Want to Get Things Done',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.isMobile ? 24 : 34,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: const Text(
              'Here is how ClariTask AI helped software engineers, students, and founders overcome paralysis and execute with confidence.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF64748B),
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 48),

          // 3 Testimonial Cards
          LayoutBuilder(
            builder: (context, constraints) {
              int columns = constraints.maxWidth > 950
                  ? 3
                  : (constraints.maxWidth > 620 ? 2 : 1);
              double spacing = 24;
              double itemWidth =
                  (constraints.maxWidth - (spacing * (columns - 1))) / columns;

              final testimonials = [
                _TestimonialData(
                  name: 'Alex Chen',
                  role: 'Lead Mobile Engineer',
                  avatarInitials: 'AC',
                  avatarColor: const Color(0xFF6366F1),
                  quote:
                      'I used to waste half my Monday morning staring at big Jira tickets wondering where to start. ClariTask deconstructs massive refactors into 30-minute bites. My velocity practically doubled.',
                  highlight: 'Velocity practically doubled',
                ),
                _TestimonialData(
                  name: 'Dr. Maya Patel',
                  role: 'Medical Resident & Researcher',
                  avatarInitials: 'MP',
                  avatarColor: const Color(0xFF10B981),
                  quote:
                      'Studying for board certifications while managing clinical rotations gave me severe task paralysis. ClariTask turns an 800-page syllabus into clear daily check-offs. It completely stopped the panic.',
                  highlight: 'Stopped the panic spiral',
                ),
                _TestimonialData(
                  name: 'Liam Vance',
                  role: 'Bootstrapped SaaS Founder',
                  avatarInitials: 'LV',
                  avatarColor: const Color(0xFFF59E0B),
                  quote:
                      'It is like having a calm, hyper-organized co-founder who takes your scattered, overwhelmed thoughts and says: "Relax. Here is step one. Just do this next." Truly indispensable.',
                  highlight: 'Calm, hyper-organized co-founder',
                ),
              ];

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: testimonials.map((t) {
                  return SizedBox(
                    width: itemWidth,
                    child: _TestimonialCard(data: t),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TestimonialData {
  final String name;
  final String role;
  final String avatarInitials;
  final Color avatarColor;
  final String quote;
  final String highlight;

  _TestimonialData({
    required this.name,
    required this.role,
    required this.avatarInitials,
    required this.avatarColor,
    required this.quote,
    required this.highlight,
  });
}

class _TestimonialCard extends StatelessWidget {
  final _TestimonialData data;

  const _TestimonialCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 5-Star Rating Row
          Row(
            children: List.generate(
              5,
              (index) => const Icon(
                Icons.star_rounded,
                color: Color(0xFFF59E0B),
                size: 20,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '"${data.quote}"',
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF334155),
              height: 1.6,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: data.avatarColor,
                child: Text(
                  data.avatarInitials,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    data.role,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
