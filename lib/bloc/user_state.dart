part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class GetSavedUserLoading extends UserState {}

final class GetSavedUserError extends UserState {
  final String message;
  GetSavedUserError({required this.message});
}

final class GetSavedUserSuccess extends UserState {
  final UserModel? user;

  GetSavedUserSuccess({this.user});
}

final class SaveUserLoading extends UserState {}

final class SaveUserError extends UserState {
  final String message;
  SaveUserError({required this.message});
}

final class SaveUserSuccess extends UserState {}