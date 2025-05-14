
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            title: Text("Leksion ken Praktis"),

          ),
          body: SizedBox(
            width: MediaQuery
                .sizeOf(context)
                .width,
            child: DecoratedBox(decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/photos/app_bg.png"), fit: BoxFit.cover),
            ),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 60, 10, 60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 20,
                    children: [
                      //Leksion
                      TextButton(
                        onPressed: () {
                            Navigator.pushNamed(context, '/lessons_page');
                          },
                        child: SizedBox(
                          width: double.infinity,
                          height: (MediaQuery
                              .sizeOf(context)
                              .height/4),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(image: AssetImage("assets/photos/leksion_button_bg.png"), fit: BoxFit.fill)
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(13, 0, 0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Leksion", style: GoogleFonts.chivo(fontSize: 40, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      //Praktis
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/practice_page');
                        },
                        child: SizedBox(
                          width: double.infinity,
                          height: (MediaQuery
                              .sizeOf(context)
                              .height)/4,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(image: AssetImage("assets/photos/praktis_button_bg.png"), fit: BoxFit.fill)
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(13, 0, 0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Praktis", style: GoogleFonts.chivo(fontSize: 40, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              )
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