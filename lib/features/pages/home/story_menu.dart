import 'package:aagilocano1/features/pages/home/stories_page.dart';
import 'package:flutter/material.dart';

class StoryMenu extends StatefulWidget {
  const StoryMenu({super.key});

  @override
  State<StoryMenu> createState() => _StoryMenuState();
}

class _StoryMenuState extends State<StoryMenu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text("Stories"),

          ),
          body: SizedBox(
            width: MediaQuery
                .sizeOf(context)
                .width,
            child: StoriesPage(),
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
            currentIndex: 1,
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