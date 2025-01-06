import 'package:aagilocano1/features/pages/home/quiz_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuizMenu extends StatefulWidget {
  const QuizMenu({super.key});

  @override
  State<QuizMenu> createState() => _QuizMenuState();
}

class _QuizMenuState extends State<QuizMenu> {
  bool quizOn = false;
  User currentUser = FirebaseAuth.instance.currentUser!;
  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text("Quiz"),

          ),
          body: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: setupBody()
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
        Center(
          child: Column(
            children: [
              const Image(image: AssetImage('packages/aagilocano1/assets/photos/quizzes_logo.png')),
              ElevatedButton(
                  onPressed:()=>{
                    setState(() {
                      quizOn = true;
                    })
                  },
                  child: const Text("Start Quiz")),
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
