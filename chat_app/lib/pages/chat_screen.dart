import 'package:chat_app/constrant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

late User loggInUser;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static String id = 'Chat_Screen';
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final textEdtingController = TextEditingController();
  late String messageText;
  @override
  void initState() {
    getCurrent();

    super.initState();
  }

  void getCurrent() async {
    try {
      final user =  _auth.currentUser!;
      // ignore: unnecessary_null_comparison
      if (user != null) {
        loggInUser = user;
        print(loggInUser.email);
      } else {
        print('no user');
      }
    } catch (e) {
      print(e);
    }
  }

  void getMessages() async {
    final messages = await fireStore.collection('messages').get();
    for (var message in messages.docs) {
      print(message.data());
    }
  }

  void getStremMessage() async {
    await for (var snapshot in fireStore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data()['text']);
      }
    }
  }

  String id = 'Chat_Screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('ChatApp'), actions: [
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              })
        ]),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MessageStream(
                fireobj: fireStore,
              ),
              Container(
                  decoration: kMessageContainerDectoration,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: TextField(
                          controller: textEdtingController,
                          onChanged: (value) {
                            messageText = value;
                          },
                          decoration: kMessageTextFieldDectoration,
                        )),
                        ElevatedButton(
                            onPressed: () {
                              textEdtingController.clear();
                              fireStore.collection('messages').add({
                                'text': messageText,
                                'sender': loggInUser.email
                              });
                            },
                            child: const Text('Send', style: kSendButtonStyle))
                      ]))
            ]));
  }

}

class MessageStream extends StatelessWidget {
  const MessageStream({Key? key, required this.fireobj}) : super(key: key);
  final FirebaseFirestore fireobj;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: fireobj.collection('messages').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final messages = snapshot.data!.docs.reversed;
            List<Widget> messagesWidget = [];
            for (var message in messages) {
              final messageText = message.data() as Map;
              final messageSender = message.data() as Map;
              final currentUser = loggInUser.email;

              final messageWeight = MessageBubble(
                messageSender: "${messageSender['sender']}",
                messageText: "${messageText['text']}",
                isMe: currentUser == messageSender['sender'].toString()
                    ? true
                    : false,
              );
              messagesWidget.add(messageWeight);
            }
            return Expanded(
                child: ListView(
                    reverse: true,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 10),
                    children: messagesWidget));
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}

class MessageBubble extends StatelessWidget {
  final String messageText;
  final String messageSender;
  final bool isMe;
  const MessageBubble(
      {super.key,
      required this.messageText,
      required this.messageSender,
      required this.isMe});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(messageSender, style: const TextStyle(fontSize: 12)),
          Material(
            elevation: 5,
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
            color: isMe ? Colors.white : Colors.lightBlueAccent,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              child: Text(messageText,
                  style: TextStyle(
                    color: isMe ? Colors.blue : Colors.white,
                    fontSize: 20,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
