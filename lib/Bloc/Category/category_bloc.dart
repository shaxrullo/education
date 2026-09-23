import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:education/Services/apiClients.dart';
import 'package:education/Services/apikeys.dart';
import 'package:meta/meta.dart';

import '../../Model/CategoryModel.dart' show CategoryModel;

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<CategoryRequested>(_onCategoryRequested, transformer: droppable());
  }

  Future<void> _onCategoryRequested(
    CategoryRequested event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    try {
      final response = await apiClients.dio.get(
        "categories/",
        options: Options(
          headers: {"Authorization": "Bearer ${apiService.accessToken}"},
        ),
      );
      final List<dynamic> rawList = response.data['data'] ?? response.data;
      final List<CategoryModel> categories = rawList
          .map((item) => CategoryModel.fromJson(item))
          .toList();

      emit(CategoryLoaded(categories: categories));
    } on DioException catch (e) {
      emit(
        CategoryFailure(
          message: e.response?.data?.toString() ?? "Category kelamdi!",
        ),
      );
    }
  }
}
