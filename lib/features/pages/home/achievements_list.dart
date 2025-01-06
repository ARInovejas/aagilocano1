import 'package:aagilocano1/Models/achievement.dart';
import 'package:aagilocano1/features/app/splash_screen/loading_screen.dart';
import 'package:aagilocano1/features/services/database.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AchievementsList extends StatefulWidget {
  final User currentUser;
  final String uid;
  const AchievementsList({super.key, required this.currentUser, required this.uid});

  @override
  State<AchievementsList> createState() => _AchievementsListState();
}

class _AchievementsListState extends State<AchievementsList> {

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<List<Achievement>>(
        stream: DatabaseService(uid: widget.uid).achievement,
        builder: (context, snapshot){
          if(snapshot.hasData){
            List<Achievement> userAchievements = snapshot.data!;
            return ListView.builder(
                itemCount: userAchievements.length,
                itemBuilder: (context, index) {
                  if(userAchievements[index].achieved) {
                    return Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: AutoSizeText(userAchievements[index].description,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20, color: Colors.greenAccent),
                              maxLines: 1,),
                          ),
                        )
                      ]
                    );
                  }else{
                    return Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: AutoSizeText(userAchievements[index].description,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey),
                                maxLines: 1,),
                            ),
                          )
                        ]
                    );
                  }
                }
            );
          }else{
            return const DefaultLoadingScreen();
          }
        }
    );
  }
}
