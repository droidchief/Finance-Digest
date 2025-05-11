part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

final class GetSavedUser extends UserEvent {}
final class SaveUser extends UserEvent {
  final UserModel user;

  SaveUser({required this.user});
}
