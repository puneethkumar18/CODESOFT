import 'package:socket_io_client/socket_io_client.dart' as io;

class ClientSocket {
  io.Socket? socket;
  static ClientSocket? _instance;

  ClientSocket._internal() {
    socket = io.io(
      "http://localhost:3000",
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );
    socket!.connect();
  }

  static ClientSocket get instance {
    _instance ??= ClientSocket._internal();

    return _instance!;
  }
}
