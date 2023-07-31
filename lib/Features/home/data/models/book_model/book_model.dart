import '../../../domain/entities/book_entity.dart';
import 'volume_info.dart';

class BookModel extends BookEntity {
  final String? kind;
  final String? id;
  final String? etag;
  final String? selfLink;
  final VolumeInfo? volumeInfo;

   BookModel({
    this.kind,
    this.id,
    this.etag,
    this.selfLink,
    required this.volumeInfo,
  }) : super(
            bookId: id!,
            image: volumeInfo?.imageLinks?.thumbnail ?? '',
            title: volumeInfo!.title!,
            authorName: volumeInfo.authors?.first ?? 'No Name',
            price: 0.0,
            rating: volumeInfo.averageRating);

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        kind: json['kind'] as String?,
        id: json['id'] as String?,
        etag: json['etag'] as String?,
        selfLink: json['selfLink'] as String?,
        volumeInfo:
            VolumeInfo.fromJson(json['volumeInfo'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'kind': kind,
        'id': id,
        'etag': etag,
        'selfLink': selfLink,
        'volumeInfo': volumeInfo!.toJson(),
      };


}
