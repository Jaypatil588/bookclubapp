class Book {
  final String id;
  final String title;
  final String author;
  final String description;
  final String imageUrl;
  final int pages;
  final double rating;
  final String publishedDate;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.imageUrl,
    required this.pages,
    this.rating = 0.0,
    required this.publishedDate,
  });
}
