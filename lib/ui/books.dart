import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:stella/ui/common.dart';
import 'package:stella/ui/neumorph.dart';

class Book {
  final String name;
  final String imagePath;
  final String filePath;
  Book({
    required this.name,
    required this.imagePath,
    required this.filePath,
  });
}

List<Book> getAllBooks() {
  String filePath = 'assets/books/rust.pdf';
  return [
    Book(
      name: 'The Rust Programming Language',
      imagePath: 'assets/books/rust.png',
      filePath: filePath,
    ),
    Book(
      name: 'More OCaml: Algorithms, Methods & Diversions',
      imagePath: 'assets/books/ocaml.jpg',
      filePath: filePath,
    ),
    Book(
      name: 'Python Programming: Wikibooks Contributors',
      imagePath: 'assets/books/python.jpg',
      filePath: filePath,
    ),
    Book(
      name: 'JS: ES6 & Beyond',
      imagePath: 'assets/books/js.jpg',
      filePath: filePath,
    ),
    Book(
      name: 'Real World Haskell',
      imagePath: 'assets/books/haskell.jpg',
      filePath: filePath,
    ),
  ];
}

class BookTile extends StatelessWidget {
  final Book book;

  BookTile({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return defaultTile(
      context,
      width: 110.0,
      height: 160.0,
      title: book.name,
      imagePath: book.imagePath,
      onPressed: () {
        routePush(context, (BuildContext context) => BookViewRoute(book: book));
      },
    );
  }
}

class BookViewRoute extends StatefulWidget {
  final Book book;

  BookViewRoute({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  _BookViewRouteState createState() => _BookViewRouteState(book);
}

class _BookViewRouteState extends State<BookViewRoute> {
  final Book book;

  _BookViewRouteState(this.book);

  late PdfController _pdfController;

  @override
  void initState() {
    super.initState();
    _pdfController = PdfController(
      document: PdfDocument.openAsset(book.filePath),
    );
  }

  @override
  Widget build(BuildContext context) {
    () async {
      // _document = await PDFDocument.fromAsset(book.filePath);
      setState(() {});
    }();
    return Scaffold(
      body: PdfView(
        controller: _pdfController,
        scrollDirection: Axis.vertical,
      ),
    );
  }
}
