import 'package:dart_amqp/dart_amqp.dart';

class RMQService {
  final String userQueue = "iotperikanan";
  final String passQueue = "KanS3g4R112";
  final String vHostQueue = "/iotperikanan";
  final String hostQueue = "";
  final String queues = "latihan";

  Client connect() {
    ConnectionSettings settings = new ConnectionSettings(
      host: hostQueue,
      authProvider: new PlainAuthenticator(userQueue, passQueue),
      virtualHost: vHostQueue,
    );
    Client client = new Client(settings: settings);
    return client;
  }

  void publish(String message) {
    ConnectionSettings settings = new ConnectionSettings(
      host: hostQueue,
      authProvider: new PlainAuthenticator(userQueue, passQueue),
      virtualHost: vHostQueue,
    );
    Client client = new Client(settings: settings);
    client.channel().then((Channel channel) {
      return channel.queue(queues, durable: true);
    }).then((Queue queue) {
      queue.publish(message);
      client.close();
    });
  }
}
// © 2021 GitHub, Inc.