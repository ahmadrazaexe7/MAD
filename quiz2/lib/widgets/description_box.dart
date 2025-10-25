import 'package:flutter/material.dart';

class DescriptionBox extends StatelessWidget {
  final String text;
  const DescriptionBox({super.key, this.text = ''});

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = text.trim().isEmpty;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade50, Colors.blue.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.blue.shade200, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Decorative icon on the left 🌟
          Icon(
            isEmpty ? Icons.info_outline : Icons.description_outlined,
            color: isEmpty ? Colors.grey.shade500 : Colors.blue.shade600,
            size: 26,
          ),
          const SizedBox(width: 12),

          // Description text
          Expanded(
            child: Text(
              isEmpty ? 'Short description not provided.' : text,
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: isEmpty ? Colors.grey.shade600 : Colors.blueGrey.shade800,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
