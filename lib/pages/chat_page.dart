// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_chat_app_firebase/components/my_textfield.dart';
// import 'package:flutter_chat_app_firebase/services/auth/auth_service.dart';
// import 'package:flutter_chat_app_firebase/services/chat/chat_service.dart';

// class ChatPage extends StatelessWidget {
//   final String receiverEmail;
//   final String receiverID;

//   ChatPage({super.key, required this.receiverEmail, required this.receiverID});

//   // text controller
//   final TextEditingController _messageController = TextEditingController();

//   // chat & auth services
//   final ChatService _chatService = ChatService();
//   final AuthService _authService = AuthService();

//   // send message
//   void sendMessage() async {
//     // if there is something inside the textfield
//     if (_messageController.text.isNotEmpty) {
//       // send the message
//       await _chatService.sendMessage(receiverID, _messageController.text);

//       // clear text controller
//       _messageController.clear();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(receiverEmail),
//       ),
//       body: Column(
//         children: [
//           // display all messages
//           Expanded(
//             child: _buildMessageList(),
//           ),

//           // user input
//           _buildUserInput(),
//         ],
//       ),
//     );
//   }

//   // build message list
//   Widget _buildMessageList() {
//     String senderID = _authService.getCurrentUser()!.uid;
//     return StreamBuilder(
//         stream: _chatService.getMessages(receiverID, senderID),
//         builder: (context, snapshot) {
//           // errors
//           if (snapshot.hasError) {
//             return const Text("Error");
//           }

//           // loading
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Text("Loading..");
//           }

//           // return list view
//           return ListView(
//             children: snapshot.data!.docs
//                 .map((doc) => _buildMessageItem(doc))
//                 .toList(),
//           );
//         });
//   }

//   // build message item
//   Widget _buildMessageItem(DocumentSnapshot doc) {
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

//     // is current user
//     bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

//     // align message to the right if sender is the current user, otherwise left
//     var alignment =
//         isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

//     return Container(
//       alignment: alignment,
//       child: Text(data['message']));
//   }

//   // build message input
//   Widget _buildUserInput() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 50.0),
//       child: Row(
//         children: [
//           // textfield should take up most of the space
//           Expanded(
//               child: MyTextfield(
//                   hintText: "Type a message",
//                   obscureText: false,
//                   controller: _messageController)),

//           // send button
//           IconButton(onPressed: sendMessage, icon: const Icon(Icons.arrow_upward))
//         ],
//       ),
//     );
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_chat_app_firebase/components/my_textfield.dart';
// import 'package:flutter_chat_app_firebase/services/auth/auth_service.dart';
// import 'package:flutter_chat_app_firebase/services/chat/chat_service.dart';

// class ChatPage extends StatelessWidget {
//   final String receiverEmail;
//   final String receiverID;

//   ChatPage({super.key, required this.receiverEmail, required this.receiverID});

//   // text controller
//   final TextEditingController _messageController = TextEditingController();

//   // chat & auth services
//   final ChatService _chatService = ChatService();
//   final AuthService _authService = AuthService();

//   // send message
//   void sendMessage() async {
//     if (_messageController.text.isNotEmpty) {
//       await _chatService.sendMessage(receiverID, _messageController.text);
//       _messageController.clear();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(receiverEmail),
//         backgroundColor: Colors.blue,
//         foregroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           Expanded(child: _buildMessageList()),
//           const Divider(height: 1),
//           _buildUserInput(),
//         ],
//       ),
//       backgroundColor: Colors.grey[200],
//     );
//   }

//   Widget _buildMessageList() {
//     String senderID = _authService.getCurrentUser()!.uid;
//     return StreamBuilder(
//       stream: _chatService.getMessages(receiverID, senderID),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return const Center(child: Text("Something went wrong"));
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         return ListView(
//           padding: const EdgeInsets.all(12),
//           children: snapshot.data!.docs
//               .map((doc) => _buildMessageItem(doc))
//               .toList(),
//         );
//       },
//     );
//   }

//   Widget _buildMessageItem(DocumentSnapshot doc) {
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

//     bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

//     return Align(
//       alignment:
//           isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 6),
//         padding: const EdgeInsets.all(12),
//         constraints: const BoxConstraints(maxWidth: 300),
//         decoration: BoxDecoration(
//           color: isCurrentUser ? Colors.blue : Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: const Radius.circular(12),
//             topRight: const Radius.circular(12),
//             bottomLeft: isCurrentUser
//                 ? const Radius.circular(12)
//                 : const Radius.circular(0),
//             bottomRight: isCurrentUser
//                 ? const Radius.circular(0)
//                 : const Radius.circular(12),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 4,
//               offset: Offset(2, 2),
//             ),
//           ],
//         ),
//         child: Text(
//           data['message'],
//           style: TextStyle(
//             color: isCurrentUser ? Colors.white : Colors.black87,
//             fontSize: 16,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildUserInput() {
//     return SafeArea(
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         color: Colors.white,
//         child: Row(
//           children: [
//             Expanded(
//               child: MyTextfield(
//                 hintText: "Type a message...",
//                 obscureText: false,
//                 controller: _messageController,
//               ),
//             ),
//             const SizedBox(width: 8),
//             Container(
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.blue,
//               ),
//               child: IconButton(
//                 onPressed: sendMessage,
//                 icon: const Icon(Icons.send, color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app_firebase/components/my_textfield.dart';
import 'package:flutter_chat_app_firebase/services/auth/auth_service.dart';
import 'package:flutter_chat_app_firebase/services/chat/chat_service.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;

  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(receiverID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList(context)),
          const Divider(height: 1),
          _buildUserInput(context),
        ],
      ),
      backgroundColor: theme.colorScheme.background,
    );
  }

  Widget _buildMessageList(BuildContext context) {
    String senderID = _authService.getCurrentUser()!.uid;

    return StreamBuilder(
      stream: _chatService.getMessages(receiverID, senderID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong"));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          padding: const EdgeInsets.all(12),
          children: snapshot.data!.docs
              .map((doc) => _buildMessageItem(doc, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc, BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          color: isCurrentUser
              ? theme.colorScheme.primary
              : (isDark ? Colors.grey[800] : Colors.grey[300]),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: isCurrentUser ? const Radius.circular(12) : Radius.zero,
            bottomRight:
                isCurrentUser ? Radius.zero : const Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Text(
          data['message'],
          style: TextStyle(
            color: isCurrentUser
                ? theme.colorScheme.onPrimary
                : (isDark ? Colors.white : Colors.black87),
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildUserInput(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        color: isDark ? Colors.grey[900] : Colors.white,
        child: Row(
          children: [
            Expanded(
              child: MyTextfield(
                hintText: "Type a message...",
                obscureText: false,
                controller: _messageController,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.primary,
              ),
              child: IconButton(
                onPressed: sendMessage,
                icon: Icon(
                  Icons.send,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
