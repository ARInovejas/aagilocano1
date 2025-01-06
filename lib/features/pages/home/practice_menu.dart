import 'package:aagilocano1/features/pages/home/lessons_page.dart';
import 'package:flutter/material.dart';

class PracticeMenu extends StatefulWidget {
  const PracticeMenu({super.key});

  @override
  State<PracticeMenu> createState() => _PracticeMenuState();
}

class _PracticeMenuState extends State<PracticeMenu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text("Review Lessons & Previous Quizzes", style: TextStyle(fontSize: 20),),

          ),
          body: SizedBox(
            width: MediaQuery
                .sizeOf(context)
                .width,
            child: const LessonsPage()
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
            currentIndex: 2,
            onTap: onItemTapped,
            backgroundColor: const Color(0xff39f1d0),

          ),
        )
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
}