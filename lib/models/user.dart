import 'package:equatable/equatable.dart';

class User extends Equatable{
  final String username;
  final String password;

  const User({required this.username, required this.password
  });

  static const empty = User( username: '-', password: '-');

  @override
  List<Object?> get props => [username, password];

}