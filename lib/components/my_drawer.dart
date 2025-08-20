// import 'package:flutter/material.dart';
// import 'package:flutter_chat_app_firebase/services/auth/auth_service.dart';
// import 'package:flutter_chat_app_firebase/pages/settings_page.dart';

// class MyDrawer extends StatelessWidget {
//   const MyDrawer({super.key});

//   void logout() {
//     // get auth service
//     final auth = AuthService();
//     auth.signOut();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             children: [
//               // logo
//               DrawerHeader(
//                   child: Center(
//                 child: Icon(
//                   Icons.message,
//                   color: Theme.of(context).colorScheme.primary,
//                   size: 40,
//                 ),
//               )),

//               // home list tile
//               Padding(
//                 padding: const EdgeInsets.only(left: 25.0),
//                 child: ListTile(
//                   title: const Text("H O M E"),
//                   leading: const Icon(Icons.home),
//                   onTap: () {
//                     // pop the drawer
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),

//               // settings list tile
//               Padding(
//                 padding: const EdgeInsets.only(left: 25.0),
//                 child: ListTile(
//                   title: const Text("S E T T I N G S"),
//                   leading: const Icon(Icons.settings),
//                   onTap: () => {
//                     // navigate to settings page
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const SettingsPage(),
//                         ))
//                   },
//                 ),
//               ),
//             ],
//           ),

//           // logout list tile
//           Padding(
//             padding: const EdgeInsets.only(left: 25.0),
//             child: ListTile(
//               title: const Text("L O G O U T"),
//               leading: const Icon(Icons.logout),
//               onTap: logout,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_chat_app_firebase/services/auth/auth_service.dart';
// import 'package:flutter_chat_app_firebase/pages/settings_page.dart';

// class MyDrawer extends StatelessWidget {
//   const MyDrawer({super.key});

//   void logout(BuildContext context) {
//     final auth = AuthService();
//     auth.signOut();

//     // Optional: show confirmation
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Logged out successfully")),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user = AuthService().getCurrentUser();

//     return Drawer(
//       backgroundColor: Colors.grey[100],
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // TOP SECTION
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               DrawerHeader(
//                 decoration: const BoxDecoration(
//                   color: Colors.deepPurple,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const CircleAvatar(
//                       backgroundColor: Colors.white,
//                       radius: 30,
//                       child: Icon(Icons.person, size: 30, color: Colors.deepPurple),
//                     ),
//                     const SizedBox(height: 12),
//                     Text(
//                       user?.email ?? "Guest",
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const Text(
//                       "Online",
//                       style: TextStyle(color: Colors.white70),
//                     ),
//                   ],
//                 ),
//               ),

//               // HOME
//               ListTile(
//                 leading: const Icon(Icons.home, color: Colors.deepPurple),
//                 title: const Text(
//                   "Home",
//                   style: TextStyle(fontWeight: FontWeight.w500),
//                 ),
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//               ),

//               // SETTINGS
//               ListTile(
//                 leading: const Icon(Icons.settings, color: Colors.deepPurple),
//                 title: const Text(
//                   "Settings",
//                   style: TextStyle(fontWeight: FontWeight.w500),
//                 ),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const SettingsPage()),
//                   );
//                 },
//               ),
//             ],
//           ),

//           // BOTTOM SECTION: LOGOUT
//           Padding(
//             padding: const EdgeInsets.only(bottom: 16.0),
//             child: ListTile(
//               leading: const Icon(Icons.logout, color: Colors.red),
//               title: const Text(
//                 "Logout",
//                 style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   color: Colors.red,
//                 ),
//               ),
//               onTap: () => logout(context),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_chat_app_firebase/services/auth/auth_service.dart';
import 'package:flutter_chat_app_firebase/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout(BuildContext context) {
    final auth = AuthService();
    auth.signOut();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Logged out successfully")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthService().getCurrentUser();
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Drawer(
      backgroundColor: theme.colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // TOP SECTION
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[900] : Colors.deepPurple,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: isDarkMode ? Colors.white10 : Colors.white,
                      radius: 30,
                      child: Icon(
                        Icons.person,
                        size: 30,
                        color: isDarkMode ? Colors.white : Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      user?.email ?? "Guest",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Online",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),

              // HOME
              ListTile(
                leading: Icon(Icons.home, color: theme.colorScheme.primary),
                title: Text(
                  "Home",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: theme.textTheme.bodyLarge!.color,
                  ),
                ),
                onTap: () => Navigator.pop(context),
              ),

              // SETTINGS
              ListTile(
                leading: Icon(Icons.settings, color: theme.colorScheme.primary),
                title: Text(
                  "Settings",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: theme.textTheme.bodyLarge!.color,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsPage()),
                  );
                },
              ),
            ],
          ),

          // BOTTOM SECTION: LOGOUT
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                "Logout",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.red,
                ),
              ),
              onTap: () => logout(context),
            ),
          ),
        ],
      ),
    );
  }
}
