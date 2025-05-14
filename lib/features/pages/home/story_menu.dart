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
            title: Text("Estoria"),

          ),
          body: SizedBox(
            width: MediaQuery
                .sizeOf(context)
                .width,
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/photos/app_bg.png"), fit: BoxFit.cover),
              ),
              child: StoriesPage()
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
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