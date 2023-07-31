import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/functions/build_error_snack_bar.dart';
import '../../../domain/entities/book_entity.dart';
import '../../manger/newest_books_cubit/newest_books_cubit.dart';
import 'newset_books_list_view_item.dart';

class NewsetBooksBlocConsumer extends StatefulWidget {
   const NewsetBooksBlocConsumer({super.key});

  @override
  State<NewsetBooksBlocConsumer> createState() => _NewsetBooksBlocConsumerState();
}

class _NewsetBooksBlocConsumerState extends State<NewsetBooksBlocConsumer> {
  List<BookEntity> books = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewestBooksCubit, NewestBooksState>(
      listener: (context, state) {
        if (state is NewestBooksSuccess) {
          books.addAll(state.books);
        }
        if (state is NewestBooksPaginationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            buildErrorWidget(state.errMessage),
          );
        }
      },
      builder: (context, state) {
        if (state is NewestBooksSuccess ||
            state is NewestBooksPaginationLoading ||
            state is NewestBooksPaginationFailure) {
          return NewsetBooksListView(books: books);
        } else if (state is NewestBooksFailure) {
          return Text(state.errMessage);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class NewsetBooksListView extends StatefulWidget {
  const NewsetBooksListView({
    super.key,
    required this.books,
  });

  final List<BookEntity> books;

  @override
  State<NewsetBooksListView> createState() => _NewsetBooksListViewState();
}

class _NewsetBooksListViewState extends State<NewsetBooksListView> {

  late final ScrollController _scrollController;

  bool isLoading = false;
  var nextPage = 1;

  void _scrollListener() async {
    var currentPositions = _scrollController.position.pixels;
    var maxScrollLength = _scrollController.position.maxScrollExtent;
    if (currentPositions >= 0.7 * maxScrollLength) {

      await BlocProvider.of<NewestBooksCubit>(context)
          .fetchNewestBooks(pageNumber: nextPage++);
      print('done');

    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      //physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: widget.books.length,
      itemBuilder: (context, index) {
        return  Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child:  BookListViewItem(book: widget.books[index]) ,
        );
      },
    );
  }
}


