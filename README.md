# flutter_book_club

Homework 3 - 
Book Club App

The Book Club App so far has a main page listing the books by Author by default (and by Title when the filter is selected). When a book is clicked a detail page is shown. The detail page has a back button letting the user go to the book list view

Todo

Create a Book class with requisite fields
Create a Cubit or a Bloc with your HomePage.
Create a List of Books initially empty
In the init() function of the Bloc/Cubit, fill in the books
Create two widgets:
Displaying the book's image
Displaying the book's image, title, author, description
Build the functionality for the transitions
Filtering (you have to sort the booklist by author or by title) (This will be the same view but you will manipulate list before rebuilding)
Remember! The Bloc/Cubit States are by default used with equatable. Therefore, if you emit the same state, it may not trigger a build. You may remove the Equatable or you may throw in a shimmer (waiting) while calculations are happening and then emit the same state, i.e. Book List View...
Showing the detail page
Add a leading Widget to the AppBar of the book detail page. Connect that leading Widget to a function in the cubit such that it emits a state where the list of books are visible
