import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CustomCard extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final Color? subtitleColor;
  final Widget? trailing;
  final VoidCallback? onTap;
  final int? animationIndex; // For staggered animation

  const CustomCard({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.subtitleColor,
    this.trailing,
    this.onTap,
    this.animationIndex,
  });

  @override
  Widget build(BuildContext context) {
    final cardContent = Card(
      color: Colors.white,
      elevation: 6,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              if (leading != null) leading!,
              if (leading != null) const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.oswald(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    if (subtitle != null) const SizedBox(height: 4),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: subtitleColor ?? Colors.black54,
                        ),
                      ),
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );

    // Wrap with staggered animation if index provided
    if (animationIndex != null) {
      return AnimationConfiguration.staggeredList(
        position: animationIndex!,
        duration: const Duration(milliseconds: 400),
        child: SlideAnimation(
          verticalOffset: 50,
          child: FadeInAnimation(
            child: cardContent,
          ),
        ),
      );
    } else {
      return cardContent;
    }
  }
}