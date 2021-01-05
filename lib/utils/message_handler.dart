import 'package:farmassist/data/user/repositories/user_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MessageHandler {
  MessageHandler(UserRepository userRepository) {
    _messaging = FirebaseMessaging.instance;
    _userRepository = userRepository;
  }

  FirebaseMessaging _messaging;
  UserRepository _userRepository;

  Future<void> generateToken() async {
    String token = await _messaging.getToken();
    await _userRepository.saveToken(token);
    _messaging.onTokenRefresh.listen(_userRepository.saveToken);
  }
}
