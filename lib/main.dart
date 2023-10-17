import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_38/cubits/main/main_cubit.dart';
import 'package:flutter_application_38/cubits/posts/posts_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MainCubit()),
        BlocProvider(create: (context) => PostsCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PostsCubit.get(context).getData();
    return SafeArea(
      child: Scaffold(
          body: BlocConsumer<PostsCubit, PostsState>(
        builder: (context, state) {
          return state is GetPostsErrorState
              ? const Center(
                  child: Text("Error, data not found"),
                )
              : PostsCubit.get(context).data.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                              PostsCubit.get(context).data[index]["title"]),
                          subtitle:
                              Text(PostsCubit.get(context).data[index]["body"]),
                        );
                      },
                      itemCount: PostsCubit.get(context).data.length,
                    );
        },
        listener: (context, state) {},
      )),
    );
  }
}
