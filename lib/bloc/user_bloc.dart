import 'package:fin_hub/features/news/data/models/user_model.dart';
import 'package:fin_hub/features/news/data/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

part 'user_event.dart';
part 'user_state.dart';



class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  UserBloc(this.userRepository) : super(UserInitial()) {
    on<GetSavedUser>(_getSavedUser);
    on<SaveUser>(_saveUser);
  }

  void _getSavedUser(GetSavedUser event, Emitter<UserState> emit) async {
    emit(GetSavedUserLoading());
    try {
      final user = await userRepository.getSavedUser();
      emit(GetSavedUserSuccess(user: user));

    }catch (e) {
      emit(GetSavedUserError(message: e.toString()));
    }
  }

  void _saveUser(SaveUser event, Emitter<UserState> emit) async {
    emit(SaveUserLoading());
    try {
      await userRepository.saveUser(event.user);
      emit(SaveUserSuccess());

    }catch (e) {
      emit(SaveUserError(message: e.toString()));
    }
  }
}

