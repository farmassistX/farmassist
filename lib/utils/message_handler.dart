import 'package:farmassist/data/user/repositories/user_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MessageHandler {
  MessageHandler(UserRepository userRepository) {
    _messaging = FirebaseMessaging.instance;
    _userRepository = userRepository;
  }

  FirebaseMessaging _messaging;
  UserRepository _userRepository;
  String _token;

  Future<void> generateToken() async {
    _token = await _messaging.getToken();
    await _userRepository.saveToken(_token);
    _messaging.onTokenRefresh.listen(_userRepository.saveToken);
  }

  Future<void> deleteToken() {
    return _userRepository.deleteToken(_token);
  }
}
