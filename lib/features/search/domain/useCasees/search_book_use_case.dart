// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:clean_architecture/core/common/type_def/typesdef.dart';
import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/core/userCases/use_case.dart';
import 'package:clean_architecture/features/search/domain/repo/search_book_repo.dart';

class FetchSearchBooksUseCase extends UseCase<SearchBooksList, FetchSearchBooksParams> {
  FetchSearchBooksUseCase(this.searchRepo);
  final SearchBooksRepo searchRepo;
  
  @override
  Future<Either<Failure, SearchBooksList>> call([FetchSearchBooksParams? params])async {
      return await searchRepo.fetchSearchBooks(pageNumber: params!.pageNumber, query: params.query);

  }

}



class FetchSearchBooksParams {
  int pageNumber;
  String query;
  FetchSearchBooksParams({
    required this.pageNumber,
    required this.query,
  });
}
