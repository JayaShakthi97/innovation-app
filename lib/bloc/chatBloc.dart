import 'package:flutter/material.dart';
import 'package:innovation_flutter_app/pages/chat/personPage.dart';

class ChatBloc extends ChangeNotifier {
  List<Message> amal = [
    Message("hi", true),
    Message("how are you?", true),
    Message("I'm fine", false)
  ];
  List<Message> kamal = [Message("hi", true), Message("I bought sugar", true)];
  List<Message> nayani = [
    Message("Have you met Mr. Dumal?", false),
    Message("Not yet.", true),
    Message("Can you?", true)
  ];

  void addToAmal(String msg) {
    amal.add(Message(msg, true));
    notifyListeners();
  }

  void addToKamal(String msg) {
    kamal.add(Message(msg, true));
    notifyListeners();
  }

  void addToNayani(String msg) {
    nayani.add(Message(msg, true));
    notifyListeners();
  }
}
