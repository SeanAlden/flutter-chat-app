// import 'package:flutter/material.dart';
// import 'package:flutter_chat_app_firebase/components/my_drawer.dart';
// import 'package:flutter_chat_app_firebase/components/user_tile.dart';
// import 'package:flutter_chat_app_firebase/pages/chat_page.dart';
// import 'package:flutter_chat_app_firebase/services/auth/auth_service.dart';
// import 'package:flutter_chat_app_firebase/services/chat/chat_service.dart';

// class HomePage extends StatelessWidget {
//   HomePage({super.key});

//   // chat & auth service
//   final ChatService _chatService = ChatService();
//   final AuthService _authService = AuthService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Home"),
//       ),
//       drawer: const MyDrawer(),
//       body: _buildUserList(),
//     );
//   }

//   Widget _buildUserList() {
//     return StreamBuilder(
//         stream: _chatService.getUserStream(),
//         builder: (context, snapshot) {
//           // error
//           if (snapshot.hasError) {
//             return const Text("Error");
//           }

//           // loading..
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Text("Loading..");
//           }

//           // return list view
//           return ListView(
//             children: snapshot.data!
//                 .map<Widget>(
//                     (userData) => _buildUserListItem(userData, context))
//                 .toList(),
//           );
//         });
//   }

//   // build individual list tile for user
//   Widget _buildUserListItem(
//       Map<String, dynamic> userData, BuildContext context) {
//     if (userData['email'] != _authService.getCurrentUser()!.email) {
//       return UserTile(
//         text: userData['email'],
//         onTap: () {
//           // tapped on a user -> go to chat page
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => ChatPage(
//                         receiverEmail: userData['email'],
//                         receiverID: userData['uid'],
//                       )));
//         },
//       );
//     } else {
//       return Container();
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_chat_app_firebase/components/my_drawer.dart';
import 'package:flutter_chat_app_firebase/pages/chat_page.dart';
import 'package:flutter_chat_app_firebase/services/auth/auth_service.dart';
import 'package:flutter_chat_app_firebase/services/chat/chat_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Users"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: _buildUserList(),
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUserStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Something went wrong"),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final users = snapshot.data!;
        if (users.isEmpty) {
          return const Center(
            child: Text("No users found"),
          );
        }

        return ListView.separated(
          itemCount: users.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return _buildUserListItem(users[index], context);
          },
        );
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData['email'] == _authService.getCurrentUser()!.email) {
      return const SizedBox.shrink(); // don't show current user
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              receiverEmail: userData['email'],
              receiverID: userData['uid'],
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(
              userData['email'][0].toUpperCase(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          title: Text(
            userData['email'],
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          trailing: const Icon(Icons.message_rounded, color: Colors.blue),
        ),
      ),
    );
  }
}
