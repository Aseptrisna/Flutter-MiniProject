// import 'dart:js';

// import 'dart:js';

import 'package:dart_amqp/dart_amqp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/Common/color.dart';
import 'package:mini_project/Screen/Dashboard._Screen.dart';
import 'package:mini_project/Screen/SendReport_Screen.dart';

class RMQService {
  final String userQueue = "iotperikanan";
  final String passQueue = "KanS3g4R112";
  final String vHostQueue = "/iotperikanan";
  final String hostQueue = "rmq2.pptik.id";
  final String queues = "latihan";

  // get context => null;

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
      print("sip tenan");
      // Navigator.of(context).push(YOUR_ROUTE);
      // foo(BuildContext context);
      //  Navigator.pop(context);
      // Pindah(context);
      // BuildContext context

      // Navigator.replace(widget(child: new PageDashboard()));
      //  Navigator.push(
      //                 context, MaterialPageRoute(builder: (_) =>new PageDashboard()));
      // Succses();
      // showSnakbar("Berhasil Membuat Report", SuccesColor);
      client.close();
    });
  }

  void foo(BuildContext context) {
    Navigator.of(context).pushNamed('/bar');
  }
  // void Pindah(context) {
  //   Navigator.pop(context, new PageDashboard());
  // }

  // void showSnakbar(Message, color) {
  //   BuildContext context;
  //   final snackBar = SnackBar(content: Text(Message), backgroundColor: color);
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }
}

// BuildContext widget({PageDashboard child}) {}
// © 2021 GitHub, Inc.
