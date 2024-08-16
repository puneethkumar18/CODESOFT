import 'package:chat_app/resources/auth/client_socket.dart';
import 'package:socket_io_client/socket_io_client.dart';

class AuthMethods {
  final _clientSocket = ClientSocket.instance.socket;

  Socket get clientSocket => _clientSocket!;

  void sentMessage(String message) {
    _clientSocket!.onConnect((_) {
      print('object');
      _clientSocket.emit(
        'event',
        {'nickname': "puneeth"},
      );
    });
  }
}

void main(List<String> args) {
  AuthMethods authMethods = AuthMethods();
  authMethods.sentMessage(
    "I am Puneeth",
  );
}
