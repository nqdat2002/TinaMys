import 'dart:async';
import 'dart:convert';
import 'package:tinamys/helpers/constants.dart';
import 'package:http/http.dart' as http;
import 'package:tinamys/helpers/token_manager.dart';

import '../../models/token.dart';

enum AuthenticationStatus {
  unknown, authenticated, unauthenticated
}

class AuthenticationRepository{
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final _controller = StreamController<AuthenticationStatus>();
  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }
  Future<void> login({required String username, required String password}) async {
    // print('attempting login');

    final uri = Uri.parse('${Constants.baseAPI}/auth/login');
    final response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        })
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      // print(data['success']);
      if (data['success'] == true) {
        final dynamic dataFrame = data[
          'data'
        ];
        TokenManager.instance.setToken(Token(accessToken:dataFrame['accessToken'],  refreshToken: dataFrame['refreshToken']));
        _controller.add(AuthenticationStatus.authenticated);
      }
      else {
        _controller.add(AuthenticationStatus.unauthenticated);
      }
    }
    else {
      _controller.add(AuthenticationStatus.unauthenticated);
    }
  }

  Future<void> signup({required String name, String username = '', required String email, required String password}) async {

  }

  void logOut(){
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}