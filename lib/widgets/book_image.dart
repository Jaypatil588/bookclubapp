import 'package:flutter/material.dart';

class BookImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  
  const BookImage({
    Key? key,
    required this.imageUrl,
    this.height = 150,
    this.width = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        imageUrl,
        height: height,
        width: width,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: height,
            width: width,
            color: Colors.grey[300],
            child: const Icon(Icons.book, size: 40, color: Colors.grey),
          );
        },
      ),
    );
  }
}
