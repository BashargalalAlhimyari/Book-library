import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/features/auth/data/models/auth_model.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/search/domain/entity/search_books_entity.dart';
import 'package:dartz/dartz.dart';


// الاستخدام في Model
typedef JsonMap = Map<String, dynamic>;


// الاستخدام في قوائم الكتب
typedef BooksList = List<BookEntity>;

typedef SearchBooksList = List<SearchBooksEntity>;

// الاستخدام في Model المصادقة
typedef AuthModelFuture = Future<AuthModel>;


// الاستخدام في النتائج التي ترجع من المستودع
typedef ResultFuture<T> = Future<Either<Failure, T>>;