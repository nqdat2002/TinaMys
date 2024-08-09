
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:tinamys/bloc/auth/auth_event.dart';
import 'package:tinamys/bloc/auth/auth_state.dart';
import 'package:tinamys/repository/auth/auth_repository.dart';
import 'package:tinamys/repository/user/user_repository.dart';

import '../../models/user.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequest>(_onAuthenticationLogoutRequested);
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
          (status) => add(AuthenticationStatusChanged(status: status)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus>
  _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  Future<void> _onAuthenticationStatusChanged(
      AuthenticationStatusChanged event,
      Emitter<AuthenticationState> emit,
      ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        const user = User(username: 'admin', password: 'admin_deptrai');
        return emit(
          const AuthenticationState.authenticated(user)
          // user != null
          //     ? AuthenticationState.authenticated(user)
          //     : const AuthenticationState.unauthenticated(),
        );
      case AuthenticationStatus.unknown:
        return emit(const AuthenticationState.unknown());
    }
  }

  void _onAuthenticationLogoutRequested(
      AuthenticationLogoutRequest event,
      Emitter<AuthenticationState> emit,
      ) {
    _authenticationRepository.logOut();
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }
}