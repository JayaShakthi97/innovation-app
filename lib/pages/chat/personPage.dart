import 'package:flutter/material.dart';
import 'package:innovation_flutter_app/bloc/chatBloc.dart';
import 'package:innovation_flutter_app/widgets/bodyContainer.dart';
import 'package:innovation_flutter_app/widgets/pageHeader.dart';
import 'package:provider/provider.dart';

class PersonPage extends StatelessWidget {
  final String name;

  const PersonPage({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    return Scaffold(
      body: BodyContainer(
        child: SafeArea(
          child: Consumer<ChatBloc>(
            builder: (_, chatBloc, __) => Column(
              children: <Widget>[
                PageHeader(
                  title: name,
                  iconData: Icons.arrow_back,
                ),
                Expanded(
                  child: ListView(
                    children: name.toLowerCase() == "amal"
                        ? chatBloc.amal
                            .map((message) => MessageTile(
                                  message: message,
                                ))
                            .toList()
                        : name.toLowerCase() == "kamal"
                            ? chatBloc.kamal
                                .map((message) => MessageTile(
                                      message: message,
                                    ))
                                .toList()
                            : chatBloc.nayani
                                .map((message) => MessageTile(
                                      message: message,
                                    ))
                                .toList(),
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: textEditingController,
                          decoration: InputDecoration(hintText: "Type message"),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          if (textEditingController.text != null ||
                              textEditingController.text != "")
                            chatBloc.addToAmal(textEditingController.text);
                          textEditingController.clear();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final Message message;

  const MessageTile({Key key, @required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: message.sent
          ? Row(
              children: <Widget>[
                Expanded(child: Container()),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Colors.black)),
                  child: Text(message.msg),
                ),
              ],
            )
          : Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Colors.black)),
                  child: Text(message.msg),
                ),
              ],
            ),
    );
  }
}

class Message {
  String msg;
  bool sent;

  Message(this.msg, this.sent);
}
