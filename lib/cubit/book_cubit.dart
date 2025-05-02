import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_book_club/models/book.dart';
import 'package:flutter_book_club/data/books_data.dart';

// States
abstract class BookState extends Equatable {
  const BookState();
  
  @override
  List<Object> get props => [];
}

class BookInitial extends BookState {}

class BookLoading extends BookState {}

class BookListLoaded extends BookState {
  final List<Book> books;
  final SortType sortType;
  
  const BookListLoaded(this.books, this.sortType);
  
  @override
  List<Object> get props => [books, sortType];
}

class BookDetailLoaded extends BookState {
  final Book book;
  
  const BookDetailLoaded(this.book);
  
  @override
  List<Object> get props => [book];
}

enum SortType { author, title }

// Cubit
class BookCubit extends Cubit<BookState> {
  List<Book> _books = [];
  
  BookCubit() : super(BookInitial());
  
  void init() async {
    emit(BookLoading());
    
    // In a real app, you might fetch this data from an API
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    
    _books = sampleBooks;
    
    // Default sort by title
    _sortBooksByTitle();
    
    emit(BookListLoaded(_books, SortType.title));
  }
  
  void sortByAuthor() {
    emit(BookLoading());
    _sortBooksByAuthor();
    emit(BookListLoaded(_books, SortType.author));
  }
  
  void sortByTitle() {
    emit(BookLoading());
    _sortBooksByTitle();
    emit(BookListLoaded(_books, SortType.title));
  }
  
  void _sortBooksByAuthor() {
    _books.sort((a, b) => a.author.compareTo(b.author));
  }
  
  void _sortBooksByTitle() {
    _books.sort((a, b) => a.title.compareTo(b.title));
  }
  
  void viewBookDetails(String bookId) {
    final book = _books.firstWhere((book) => book.id == bookId);
    emit(BookDetailLoaded(book));
  }
  
  void backToList() {
    // Get the current state to determine the sort type
    if (state is BookDetailLoaded) {
      final currentSortType = state is BookListLoaded 
          ? (state as BookListLoaded).sortType 
          : SortType.title;
      
      emit(BookLoading());
      
      if (currentSortType == SortType.author) {
        _sortBooksByAuthor();
      } else {
        _sortBooksByTitle();
      }
      
      emit(BookListLoaded(_books, currentSortType));
    }
  }
}
