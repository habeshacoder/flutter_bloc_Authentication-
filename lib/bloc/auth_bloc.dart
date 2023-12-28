import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(
      (event, emit) async {
      // TODO: implement event handler

      final email = event.email;
      final password = event.password;
      emit(AuthLoading());
      try {
        if (password.length < 6) {
          return emit(
              AuthFailure(errorMessage: "password length is less than 6"));
        }
        await Future.delayed(Duration(seconds: 1));
        return emit(AuthSuccess(uid: "$email$password"));
      } catch (eror) {
        return emit(AuthFailure(errorMessage: "${eror.toString()}"));
      }
    });
    on<AuthLogOutRequested>(
      (event, emit) {
        try {
          emit(AuthInitial());
        } catch (error) {
          emit(AuthFailure(errorMessage: error.toString()));
        }
      },
    );
  }
}
