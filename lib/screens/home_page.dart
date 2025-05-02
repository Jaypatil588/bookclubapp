import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_book_club/cubit/book_cubit.dart';
import 'package:flutter_book_club/screens/book_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookCubit()..init(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Book Club Home',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28),
          ),
          centerTitle: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.bookmark_border),
              onPressed: () {
                // Bookmark functionality would go here
              },
            ),
          ],
        ),
        body: BlocBuilder<BookCubit, BookState>(
          builder: (context, state) {
            if (state is BookInitial || state is BookLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BookListLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Filter options
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Row(
                      children: [
                        const Text(
                          'Sort by:',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: const Text('Title'),
                          selected: state.sortType == SortType.title,
                          onSelected: (selected) {
                            if (selected) {
                              context.read<BookCubit>().sortByTitle();
                            }
                          },
                          backgroundColor: Colors.transparent,
                          selectedColor: Colors.black12,
                          labelStyle: TextStyle(
                            color: state.sortType == SortType.title
                                ? Colors.black
                                : Colors.grey,
                            fontWeight: state.sortType == SortType.title
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: const Text('Author'),
                          selected: state.sortType == SortType.author,
                          onSelected: (selected) {
                            if (selected) {
                              context.read<BookCubit>().sortByAuthor();
                            }
                          },
                          backgroundColor: Colors.transparent,
                          selectedColor: Colors.black12,
                          labelStyle: TextStyle(
                            color: state.sortType == SortType.author
                                ? Colors.black
                                : Colors.grey,
                            fontWeight: state.sortType == SortType.author
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // "Books" title
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Text(
                      'Books',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Book grid
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.55,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: state.books.length,
                        itemBuilder: (context, index) {
                          final book = state.books[index];
                          return GestureDetector(
                            onTap: () {
                              context
                                  .read<BookCubit>()
                                  .viewBookDetails(book.id);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: context.read<BookCubit>(),
                                    child: const BookDetailPage(),
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Book cover
                                  AspectRatio(
                                    aspectRatio: 0.75,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            const BorderRadius.vertical(
                                          top: Radius.circular(8),
                                        ),
                                        image: DecorationImage(
                                          image: AssetImage(book.imageUrl),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Book details
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          book.title,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          book.author,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        // Text(
                                        //   book.description,
                                        //   style: const TextStyle(
                                        //     fontSize: 10,
                                        //     color: Colors.black54,
                                        //   ),
                                        //   maxLines: 2,
                                        //   overflow: TextOverflow.ellipsis,
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: Text('Something went wrong'));
            }
          },
        ),
      ),
    );
  }
}
