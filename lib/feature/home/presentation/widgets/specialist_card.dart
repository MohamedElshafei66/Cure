import 'package:flutter/material.dart';

class SpecialistCard extends StatelessWidget {
  final String? image;
  final String? emoji;
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const SpecialistCard({
    super.key,
    this.image,
    this.emoji,
    required this.text,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color borderColor = selected ? Colors.blue : Colors.grey.shade300;
    final Color backgroundColor = selected ? Colors.blue : Colors.white;
    final Color textColor = selected ? Colors.white : Colors.black87;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        constraints: const BoxConstraints(
          minHeight: 44,
          minWidth: 96,
          maxWidth: 170,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildIcon(textColor),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(Color color) {
    if (image != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(image!, height: 26, width: 26, fit: BoxFit.cover),
      );
    }

    if (emoji != null && emoji!.isNotEmpty) {
      return Text(emoji!, style: TextStyle(fontSize: 24, color: color));
    }

    return Icon(Icons.history, size: 20, color: color);
  }
}
