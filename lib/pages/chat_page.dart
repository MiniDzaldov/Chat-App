import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../components/my_appbar.dart';
import '../components/my_chat_bubble.dart';
import '../components/my_text_field.dart';
import '../services/auth/auth_service.dart';
import '../services/chat/chat_service.dart';


class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;

  const ChatPage({
    required this.receiverEmail,
    required this.receiverID,
  });

  State<ChatPage> createState() => _ChatPageState();

}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  FocusNode myFocousNode = FocusNode();
  final ScrollController _controller = ScrollController();

  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessage(widget.receiverID, senderID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading..");
        }
        return ListView(
          controller: _controller,
          children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;
    var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(
            message: data["message"],
            isCurrentUser: isCurrentUser,
          ),
        ],
      ),
    );
  }

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(widget.receiverID, _messageController.text);
      _messageController.clear();
      _scrollDown();
    }
  }

  void _scrollDown() {
    _controller.animateTo(
    _controller.position.maxScrollExtent,
    duration: Duration(seconds: 1),
    curve: Curves.fastOutSlowIn,
  );
  }

  Widget _buildUserInput() {
    return Padding(
      padding: EdgeInsets.only(bottom: 50),
      child: Row(
        children: [
          Expanded(
            child: MyTextFeild(
              controller: _messageController,
              hintText: "Type a message",
              obscureText: false,
              focusNode: myFocousNode,
            ),
          ),
          Container(
            decoration:  BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            margin: EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage,
              icon: Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: widget.receiverEmail,
        actions: [],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,

      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildUserInput()
        ],
      ),
    );
  }
}