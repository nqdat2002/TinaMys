import 'package:bloc/bloc.dart';
import 'package:tinamys/bloc/form/form_submission_status.dart';
import 'package:tinamys/bloc/login/login_event.dart';
import 'package:tinamys/bloc/login/login_state.dart';
import 'package:tinamys/repository/auth/auth_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{
  LoginBloc({required AuthenticationRepository authRepository}): _authRep = authRepository, super(const LoginState()){
    on<LoginUserNameChanged>(_onUserNameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  final AuthenticationRepository _authRep;

  // @override
  // Stream<LoginState> mapEventToState(LoginState event) async*{
  //   if (event is LoginUserNameChanged){
  //     yield state.copyWith(username: event.username);
  //   }
  //   else if (event is LoginPasswordChanged){
  //     yield state.copyWith(password: event.password);
  //   }
  //   else if (event is LoginSubmitted){
  //     yield state.copyWith(formStatus: FormSubmitting());
  //   }
  // }

  void _onUserNameChanged(LoginUserNameChanged event, Emitter<LoginState> emit) async {
    final username = event.username;

    emit(state.copyWith(username: username));
  }

  void _onPasswordChanged(LoginPasswordChanged event, Emitter<LoginState> emit) async {
    final password = event.password;

    emit(state.copyWith(password: password));
  }

  void _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));

    try{
      await _authRep.login(username: event.username, password: event.password);
      emit(state.copyWith(formStatus: SubmissionSuccess()));
    }
    catch (ex){
      emit(state.copyWith(formStatus: SubmissionFailed(exception: ex.toString())));
    }
  }
}