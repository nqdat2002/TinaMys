import 'package:bloc/bloc.dart';
import 'package:tinamys/bloc/form/form_submission_status.dart';
import 'package:tinamys/bloc/signup/signup_event.dart';
import 'package:tinamys/bloc/signup/signup_state.dart';
import 'package:tinamys/repository/auth/auth_repository.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState>{
  SignupBloc({required AuthenticationRepository authRepository}) : _authRep = authRepository, super(const SignupState()){
    on<SignupNameChanged>(_onNameChanged);
    on<SignupUserNameChanged>(_onUserNameChanged);
    on<SignupEmailChanged>(_onEmailChanged);
    on<SignupPasswordChanged>(_onPasswordChanged);
    on<SignupConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<SignupSubmitted>(_onSignupSubmitted);
  }

  final AuthenticationRepository _authRep;

  void _onNameChanged(SignupNameChanged event, Emitter<SignupState> emit) async{
    final name = event.name;
    emit(state.copyWith(name: name));
  }

  void _onUserNameChanged(SignupUserNameChanged event, Emitter<SignupState> emit) async{
    final username = event.username;
    emit(state.copyWith(username: username));
  }

  void _onEmailChanged(SignupEmailChanged event, Emitter<SignupState> emit) async{
    final email = event.email;
    emit(state.copyWith(email: email));
  }

  void _onPasswordChanged(SignupPasswordChanged event, Emitter<SignupState> emit) async{
    final password = event.password;
    emit(state.copyWith(password: password));
  }

  void _onConfirmPasswordChanged(SignupConfirmPasswordChanged event, Emitter<SignupState> emit) async{
    final confirmPassword =  event.confirmPassword;
    emit(state.copyWith(confirmPassword: confirmPassword));
  }

  void _onSignupSubmitted(SignupSubmitted event, Emitter<SignupState> emit) async{
    try{
      await _authRep.signup(name: event.name, username: event.username, email: event.email, password: event.password);
      emit(state.copyWith(formStatus: SubmissionSuccess()));
    }
    catch (ex){
      emit(state.copyWith(formStatus: SubmissionFailed(exception: ex.toString())));
    }
  }
}