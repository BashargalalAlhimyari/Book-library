import 'package:clean_architecture/core/common/type_def/typesdef.dart';
import 'package:clean_architecture/core/constants/app_constants.dart';
import 'package:clean_architecture/core/errors/exception.dart'; // تأكد من استيراد الـ Exception الخاص بك
import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/core/network/dio_error_handler.dart';
import 'package:clean_architecture/features/home/data/data_sources/home_local_data_source.dart';
import 'package:clean_architecture/features/home/data/data_sources/remote_data_source.dart';
import 'package:clean_architecture/features/home/domain/repos/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeLocalDataSource homeLocalDataSource;

  HomeRepoImpl({
    required this.homeRemoteDataSource,
    required this.homeLocalDataSource,
  });
 @override
  ResultFuture<BooksList> fetchQuickReadBooks({int pageNumber = AppConstants.itemsPerPage}) {
    return _fetchData(
      fetchRemote: () => homeRemoteDataSource.fetchQuickReadBooks(pageNumber: pageNumber),
      fetchLocal: () => homeLocalDataSource.fetchQuickReadBooks(pageNumber: pageNumber),
      cacheData: (books) => homeLocalDataSource.cacheQuickReadBooks(books), // استخدام دالة الكلاس
      pageNumber: pageNumber,
    );
  }
  

  @override
  ResultFuture<BooksList> fetchBooks({int pageNumber = 0}) async {
    return _fetchData(
      fetchRemote: () => homeRemoteDataSource.fetchBooks(pageNumber: pageNumber),
      fetchLocal: () => homeLocalDataSource.fetchBooks(pageNumber: pageNumber),
      cacheData: (books) => homeLocalDataSource.cacheBooks(books), // استخدام دالة الكلاس
      pageNumber: pageNumber,
    );
  }

  @override
  ResultFuture<BooksList> fetchNewsBooks({int pageNumber = 0}) async {
    return _fetchData(
      fetchRemote: () => homeRemoteDataSource.fetchNewsBooks(pageNumber: pageNumber),
      fetchLocal: () => homeLocalDataSource.fetchNewsBooks(pageNumber: pageNumber),
      cacheData: (books) => homeLocalDataSource.cacheNewsBooks(books), // استخدام دالة الكلاس
      pageNumber: pageNumber,
    );
  }

  @override
  ResultFuture<BooksList> fetchTrendingBooks({int pageNumber = 0}) {
  return _fetchData(
      fetchRemote: () => homeRemoteDataSource.fetchTrendingdBooks(pageNumber: pageNumber),
      fetchLocal: () => homeLocalDataSource.fetchTrendingBooks(pageNumber: pageNumber),
      cacheData: (books) => homeLocalDataSource.cacheTrendingBooks(books), // استخدام دالة الكلاس
      pageNumber: pageNumber,
    );
  }
    @override
  ResultFuture<BooksList> fetchTopRatedBooks({int pageNumber = 0}) {
 return _fetchData(
      fetchRemote: () => homeRemoteDataSource.fetchTopRatedBooks(pageNumber: pageNumber),
      fetchLocal: () => homeLocalDataSource.fetchTopRatedBooks(pageNumber: pageNumber),
      cacheData: (books) => homeLocalDataSource.cacheTopRatedBooks(books), // استخدام دالة الكلاس
      pageNumber: pageNumber,
    );
  }
  // ===========================================================================
  // 💡 دالة خاصة (Private Method) لتوحيد منطق جلب البيانات ومعالجة الأخطاء
  // هذا يطبق مبدأ DRY (Don't Repeat Yourself) ويجعل الكود أنظف بكثير
  // ===========================================================================
ResultFuture<BooksList> _fetchData({
    required Future<BooksList> Function() fetchRemote,
    required BooksList Function() fetchLocal,
    required Future<void> Function(BooksList) cacheData,
    required int pageNumber,
  }) async {
    try {
      // 1. المحاولة من السيرفر
      final remoteBooks = await fetchRemote();

      // 2. تحديث الكاش (فقط للصفحة الأولى)
      if (pageNumber == 0) {
        await cacheData(remoteBooks);
      }

      return right(remoteBooks);
    } catch (e) {
  
      try {
        final localBooks = fetchLocal();
        if (localBooks.isNotEmpty) {
          return right(localBooks);
        }
      } catch (_) {
      }

     
      if (e is ServerException) {
        return left(ServerFailure(e.message)); // رسالة الخطأ من الباك اند
      }

      if (e is DioException) {
        return left(DioErrorHandler.handle(e)); // رسالة خطأ الاتصال/السيرفر
      }
      
      return left(ServerFailure(e.toString()));
    }
  
  }
  
 

  

}