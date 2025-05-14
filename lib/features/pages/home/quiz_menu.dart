import 'package:aagilocano1/features/pages/home/quiz_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizMenu extends StatefulWidget {
  const QuizMenu({super.key});

  @override
  State<QuizMenu> createState() => _QuizMenuState();
}

class _QuizMenuState extends State<QuizMenu> {
  bool quizOn = false;
  String bgDesign = "assets/photos/quiz_bg2.png";
  User currentUser = FirebaseAuth.instance.currentUser!;
  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("Ejersisio"),

          ),
          body: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: DecoratedBox(decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(bgDesign), fit: BoxFit.cover),
              ),
              child: setupBody(),
              )
            )
          ,
          bottomNavigationBar: showBottomNavbar()
        )
    );
  }

  setupBody(){
    if(quizOn){
      return QuizList(currentUser: currentUser, uid: uid);
    }else{
      return
        Padding(
          padding: const EdgeInsets.fromLTRB(0,60,0,60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //logo
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0,20,0,20),
                child: SizedBox(
                  width: double.infinity,
                  height: (MediaQuery
                      .sizeOf(context)
                      .height/3),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/photos/start_quiz_button_bg.png"), fit: BoxFit.fill),
                    ),
                  ),
                ),
              ),
              //start button
              TextButton(
                onPressed: () {
                  setState(() {
                    quizOn = true;
                    bgDesign = "assets/photos/app_bg.png";
                  });
                },
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(13, 0, 0, 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                            color: Color(0xff61fb80),
                            borderRadius: BorderRadius.circular(22)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 5,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(13, 0, 0, 0),
                              child: Icon(Icons.play_arrow, size: 20, color: Colors.black,),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 13, 13, 13),
                              child: Text("Rugian ti Ejersisio", style: GoogleFonts.tinos(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black), textAlign: TextAlign.center,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
    }
  }

  showBottomNavbar(){
    if(quizOn){
      return ;
    }else{
      return
        BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.quiz_rounded),
                label: "Ejersisio"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.book_rounded),
                label: "Estoria"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.menu_book_rounded),
                label: "Leksion"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded),
                label: "Profile"
            )
          ],
          currentIndex: 0,
          onTap: onItemTapped,
          backgroundColor: const Color(0xff39f1d0),

        );
    }
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
}
