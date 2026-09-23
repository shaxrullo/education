part of 'category_bloc.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<CategoryModel> categories;
  CategoryLoaded({required this.categories});
}

class CategoryFailure extends CategoryState {
  final String message;
  CategoryFailure({required this.message});
}
