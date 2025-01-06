
import 'package:aagilocano1/features/app/splash_screen/loading_screen.dart';
import 'package:aagilocano1/features/pages/home/achievements_list.dart';
import 'package:aagilocano1/features/pages/home/vocab_list.dart';
import 'package:aagilocano1/features/services/database.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../Models/user.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin {

  late TabController tcontroller;


  @override
  void initState(){
    super.initState();
    tcontroller = TabController(length: 1, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    User currentUser = FirebaseAuth.instance.currentUser!;
    String uid = FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          UserData userData = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text("Profile"),
              actions: [
                IconButton(onPressed: () async { //logout button
                  signOut();

                  Navigator.pushNamed(context, '/login');
                }, icon: const Icon(Icons.logout_outlined),
                  tooltip: "Logout",
                ),
                IconButton(onPressed: () async { //delete account button
                  showDialog( //pop-up for confirmation
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Delete your Account?'),
                          content: const Text(
                              '''If you select Delete we will delete your account on our server.
          
          Your app data including your study progress will also be deleted and you won't be able to retrieve it.
          
          Since this is a security-sensitive operation, you eventually are asked to login before your account can be deleted.'''),
                          actions: [
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty
                                    .resolveWith<Color?>((
                                    Set<WidgetState> states) {
                                  return Colors.red;
                                }),
                                foregroundColor: WidgetStateProperty
                                    .resolveWith<Color?>((
                                    Set<WidgetState> states) {
                                  return Colors.white;
                                }),),
                              onPressed: () {
                                deleteUserAccount();
                                // Call the delete account function
                              },
                              child: const Text(
                                  'Delete'),
                            ),
                          ],
                        );
                      }
                  );
                }, icon: const Icon(Icons.delete_forever_rounded),
                  tooltip: "Delete account",
                  color: Colors.red,
                )
              ],
            ),
            body: SizedBox(
              width: MediaQuery
                  .sizeOf(context)
                  .width,
              child: Column( //Profile info
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsetsDirectional.all(10),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(currentUser.photoURL.toString()),
                              radius: 48,
                              backgroundColor: Colors.lightGreen,
                            ),
                          ),
                          Expanded(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: AutoSizeText(
                                      currentUser.displayName.toString(),
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 48),
                                      maxLines: 1,
                                    ),
                                  ),
                                  const Divider(
                                    height: 1, // The height of the divider
                                    color: Colors.black, // The color of the divider
                                    thickness: 1, // The thickness of the divider line
                                    indent: 10, // The left padding (indent) of the divider
                                    endIndent: 10, // The right padding (endIndent) of the divider
                                  ),
                                  AutoSizeText("Level ${userData.level}",
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                    maxLines: 1,)
                                ],
                              )
                          )
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        child: TabBar(
                          controller: tcontroller,
                          tabs: const [
                            Tab(
                              icon: Icon(Icons.sunny),
                              text: "Achievements",
                            ),
                            // Tab(
                            //   icon: Icon(Icons.menu_book_rounded),
                            //   text: "Vocabulary",
                            // ),
                          ]
                        ),
                      ),
                      SizedBox(
                        height: 500,
                        child: TabBarView(
                            controller: tcontroller,
                            children: [
                              AchievementsList(currentUser: currentUser, uid: uid),
                              // VocabList(currentUser: currentUser, uid: uid)
                            ]
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.quiz_rounded),
                    label: "Quiz"
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.book_rounded),
                    label: "Story"
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.history),
                    label: "Practice"
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_rounded),
                    label: "Profile"
                )
              ],
              currentIndex: 3,
              onTap: onItemTapped,
              backgroundColor: const Color(0xff39f1d0),

            ),
          );
        }else{
          return const DefaultLoadingScreen();
        }
      }
    );
  }

  onItemTapped(int index){
    switch(index){
      case 0:
        Navigator.pushNamed(context, '/quiz_menu');
      case 1:
        Navigator.pushNamed(context, '/story_menu');
      case 2:
        Navigator.pushNamed(context, '/practice_menu');
      case 3:
        Navigator.pushNamed(context, '/profile');
    }
  }

  Future<void> deleteUserAccount() async {
    try {
      String id = FirebaseAuth.instance.currentUser!.uid;
      await DatabaseService(uid: id).deleteUserData();
      await FirebaseAuth.instance.currentUser!.delete();
      Navigator.pushNamed(context, '/login');

    } on FirebaseAuthException catch (e) {
      print(e);

      if (e.code == "requires-recent-login") {
        await reauthenticateAndDelete();
      } else {
        // Handle other Firebase exceptions
      }
    } catch (e) {
      print(e);

      // Handle general exception
    }
  }

  Future<void> reauthenticateAndDelete() async {
    try {
      final auth = FirebaseAuth.instance;
      final providerData = auth.currentUser?.providerData.first;

      if (FacebookAuthProvider().providerId == providerData!.providerId) {
        await auth.currentUser!
            .reauthenticateWithProvider(AppleAuthProvider());
      } else if (GoogleAuthProvider().providerId == providerData.providerId) {
        await auth.currentUser!
            .reauthenticateWithProvider(GoogleAuthProvider());
      }

      String id = FirebaseAuth.instance.currentUser!.uid;
      await DatabaseService(uid: id).deleteUserData();
      await auth.currentUser?.delete();
      Navigator.pushNamed(context, '/login');
    } catch (e) {
      // Handle exceptions
    }
  }

  signOut() async{
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      final providerData = auth.currentUser!.providerData;
      if (providerData.isNotEmpty) {
        if (providerData[0]
            .providerId
            .toLowerCase()
            .contains('google')) {
          await GoogleSignIn().signOut(); // google signOut
        } else if (providerData[0]
            .providerId
            .toLowerCase()
            .contains('facebook')) {
          await FacebookAuth.instance.logOut(); // facebook signOut
        }
      }
      await auth.signOut(); // firebase signOut
    } catch (e) {
      print(e);
    }

  }


}
