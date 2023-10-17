part of 'main_cubit.dart';

@immutable
sealed class MainState {}

final class MainInitial extends MainState {}

class IncrementState extends MainState {}

class DecrementState extends MainState {}
