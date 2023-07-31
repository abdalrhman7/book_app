import 'package:clean_arch_bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:clean_arch_bookly_app/constants.dart';
import 'package:clean_arch_bookly_app/core/utils/api_services.dart';

import '../../../../core/utils/functions/save_box.dart';
import '../../domain/entities/book_entity.dart';

abstract class HomeRemoteDataSource {
  Future<List<BookEntity>> fetchFeaturedBooks({int pageNumber= 0});
  Future<List<BookEntity>> fetchNewestBooks({int pageNumber= 0});
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiService apiService;

  HomeRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<BookEntity>> fetchFeaturedBooks({int pageNumber= 0}) async {
    var data = await apiService.get(
        endPoint: 'volumes?Filtering=free-ebooks&q=programming&startIndex=${pageNumber * 10}');

    List<BookEntity> books = getBooksList(data);

    saveBooksData(books, KFeaturedBox);

    return books;
  }

  @override
  Future<List<BookEntity>> fetchNewestBooks({int pageNumber= 0}) async {
    var data = await apiService.get(
        endPoint:
            'volumes?Filtering=free-ebooks&q=movie&startIndex=${pageNumber * 10}');

    List<BookEntity> books = getBooksList(data);

    saveBooksData(books, KNewestBox);

    return books;
  }

  List<BookEntity> getBooksList(Map<String, dynamic> data) {
    List<BookEntity> books = [];

    for (var bookMap in data['items']) {
      books.add(BookModel.fromJson(bookMap));
    }
    return books;
  }
}
