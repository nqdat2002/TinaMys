import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable{
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupNameChanged extends SignupEvent{
  final String name;

  const SignupNameChanged({required this.name});

  @override
  List<Object> get props => [name];
}

class SignupUserNameChanged extends SignupEvent{
  final String username;

  const SignupUserNameChanged({required this.username});

  @override
  List<Object> get props => [username];
}

class SignupEmailChanged extends SignupEvent{
  final String email;

  const SignupEmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}

class SignupPasswordChanged extends SignupEvent{
  final String password;

  const SignupPasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}

class SignupConfirmPasswordChanged extends SignupEvent{
  final String confirmPassword;

  const SignupConfirmPasswordChanged({required this.confirmPassword});

  @override
  List<Object> get props => [confirmPassword];
}

class SignupSubmitted extends SignupEvent{
  final String name, username, email, password;

  const SignupSubmitted({required this.name, required this.username, required this.email, required this.password });

  @override
  List<Object> get props => [name, username, email, password];
}