import 'package:aagilocano1/Models/achievement.dart';
import 'package:aagilocano1/features/app/splash_screen/loading_screen.dart';
import 'package:aagilocano1/features/services/database.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: ListView.builder(
                  itemCount: userAchievements.length,
                  itemBuilder: (context, index) {
                    if(userAchievements[index].achieved) {
                      return Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                        child: Tooltip(
                          message: userAchievements[index].description,
                          triggerMode: TooltipTriggerMode.tap,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.green
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                    child: Icon(
                                      Icons.emoji_events,
                                      size: 30,
                                      color: Color(0xffffd700),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 12,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                                    child: AutoSizeText(
                                      userAchievements[index].title,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.tinos(
                                          fontWeight: FontWeight.bold, fontSize: 20),
                                      maxLines: 1,),
                                  ),
                                )
                              ]
                            ),
                          ),
                        ),
                      );
                    }else{
                      return Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                        child: Tooltip(
                          message: userAchievements[index].description,
                          triggerMode: TooltipTriggerMode.tap,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey
                            ),
                            child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                      child: Icon(
                                        Icons.emoji_events,
                                        size: 30,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 12,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                                      child: AutoSizeText(
                                        userAchievements[index].title,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.tinos(
                                            fontWeight: FontWeight.bold, fontSize: 20),
                                        maxLines: 1,),
                                    ),
                                  )
                                ]
                            ),
                          ),
                        ),
                      );
                    }
                  }
              ),
            );
          }else{
            return const CircularProgressIndicator();
          }
        }
    );
  }
}
