
import 'package:equatable/equatable.dart';
import 'package:tinamys/bloc/form/form_submission_status.dart';

class SignupState extends Equatable{
  final String name;
  final String username;
  final String email;
  final String password;
  final String confirmPassword;
  final FormSubmissionStatus formStatus;

  const SignupState({this.name = '', this.username = '', this.email = '', this.password = '', this.confirmPassword = '',  this.formStatus = const InitialFormStatus()});

  SignupState copyWith({String? name, String? username, String? email, String? password, String? confirmPassword, FormSubmissionStatus? formStatus}){
    return SignupState(
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      formStatus: formStatus ?? this.formStatus
    );
  }

  @override
  List<Object?> get props => [name, username, email, password, confirmPassword, formStatus];
}