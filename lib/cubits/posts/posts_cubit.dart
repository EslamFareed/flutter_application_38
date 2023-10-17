import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsInitial());
  static PostsCubit get(context) => BlocProvider.of(context);

  List<Map> data = [];

  void getData() {
    Dio().get("https://jsonplaceholder.typicode.com/posts").then((value) {
      if (value.statusCode == 200) {
        for (var element in value.data) {
          data.add(element as Map<String, dynamic>);
        }
        emit(GetPostsState());
      }
    }).catchError((error) {
      print(error.toString());
      emit(GetPostsErrorState());
    });
  }
}
