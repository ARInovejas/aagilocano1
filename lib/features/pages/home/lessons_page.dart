
import 'package:auto_size_text/auto_size_text.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:scroll_to_hide/scroll_to_hide.dart';
import 'package:searchable_listview/searchable_listview.dart';

class LessonsPage extends StatefulWidget {
  const LessonsPage({super.key});

  @override
  State<LessonsPage> createState() => _LessonsPageState();
}

class _LessonsPageState extends State<LessonsPage> with TickerProviderStateMixin {

  List<Map<String, dynamic>> lesson1Files = [
    {//0
      "isList" : false,
      "title" : "Evolusion Dagiti Uni ken Letra ti Kur-itan",
      "btnName" : "Evolusion Dagiti Uni ken Letra ti Kur-itan",
      "imgPath" : "assets/photos/Alphabet Evolution 1.jpg",
      "csvPath" : ""
    },
    {//1
      "isList" : false,
      "title" : "Evolusion Dagiti Uni ken Letra ti Kur-itan",
      "btnName" : "Evolusion Dagiti Uni ken Letra ti Kur-itan (2)",
      "imgPath" : "assets/photos/Alphabet Evolution 2.jpg",
      "csvPath" : ""
    },
    {//2
      "isList" : true,
      "title" : "Sistema Ti Uni",
      "btnName" : "Sistema Ti Uni",
      "imgPath" : "",
      "csvPath" : "assets/lessons/Lessons - Sistema ti Uni.csv"
    },
    {//3
      "isList" : true,
      "title" : "Diptonggo",
      "btnName" : "Diptonggo",
      "imgPath" : "",
      "csvPath" : "assets/lessons/Lessons - Diptonggo.csv"
    },
    {//4
      "isList" : true,
      "title" : "Diptonggo",
      "btnName" : "Diptonggo (2)",
      "imgPath" : "",
      "csvPath" : "assets/lessons/Lessons - Diptonggo2.csv"
    },
    {//5
      "isList" : false,
      "title" : "Diptonggo",
      "btnName" : "Diptonggo (3)",
      "imgPath" : "assets/photos/Diptonggo3.png",
      "csvPath" : "assets/lessons/Lessons - Diptonggo3.csv"
    },
    {//6
      "isList" : false,
      "title" : "Ridis Kadagiti Silaba",
      "btnName" : "Ridis Kadagiti Silaba",
      "imgPath" : "assets/photos/Ridis.png",
      "csvPath" : "assets/lessons/Lessons - Ridis Kadagiti Silaba.csv"
    },
    {//7
      "isList" : false,
      "title" : "Singkopasion",
      "btnName" : "Singkopasion",
      "imgPath" : "assets/photos/Singkopasion.png",
      "csvPath" : "assets/lessons/Lessons - Singkopasion.csv"
    },
    {//8
      "isList" : false,
      "title" : "Uyas",
      "btnName" : "Uyas",
      "imgPath" : "",
      "csvPath" : "assets/lessons/Lessons - Uyas.csv"
    },
    {//9
      "isList" : false,
      "title" : "Metatesis",
      "btnName" : "Metatesis",
      "imgPath" : "assets/photos/Metatesis.png",
      "csvPath" : "assets/lessons/Lessons - Metatesis.csv"
    },
    {//10
      "isList" : false,
      "title" : "Solusion iti Nadardaras a Panagiyebkas",
      "btnName" : "Solusion iti Nadardaras a Panagiyebkas",
      "imgPath" : "assets/photos/Solusion iti Nadardaras a Panagiyebkas.png",
      "csvPath" : "assets/lessons/Lessons - Solusion iti Nadardaras a Panagiyebkas.csv"
    },
    {//11
      "isList" : false,
      "title" : "Elision - Iti ken Ti",
      "btnName" : "Elision",
      "imgPath" : "assets/photos/Elision - Iti ken Ti.png",
      "csvPath" : "assets/lessons/Lessons - Elision - Iti ken Ti.csv"
    },
    {//12
      "isList" : false,
      "title" : "Elision - an ken en",
      "btnName" : "Elision (2)",
      "imgPath" : "assets/photos/Elision - an ken en.png",
      "csvPath" : "assets/lessons/Lessons - Elision - an ken en.csv"
    },
    {//13
      "isList" : false,
      "title" : "Variedad ken Variasion",
      "btnName" : "Variedad ken Variasion",
      "imgPath" : "",
      "csvPath" : "assets/lessons/Lessons - Variedad ken Variasion.csv"
    },
    {//14
      "isList" : false,
      "title" : "Sistema ti Formation Dagiti Balikas Nga Ilokano",
      "btnName" : "Sistema ti Formation Dagiti Balikas Nga Ilokano",
      "imgPath" : "assets/photos/Sistema ti Formation Dagiti Balikas nga Ilokano.png",
      "csvPath" : "assets/lessons/Lessons - Sistema ti Formation Dagiti Balikas nga Ilokano.csv"
    },
    {//15
      "isList" : false,
      "title" : "Panangiyam-Ammo iti Bagi",
      "btnName" : "Panangiyam-Ammo iti Bagi",
      "imgPath" : "assets/photos/Panangiyam-Ammo iti Bagi.png",
      "csvPath" : ""
    },
    {//16
      "isList" : false,
      "title" : "Panangiyam-Ammo iti Bagi",
      "btnName" : "Panangiyam-Ammo iti Bagi (2)",
      "imgPath" : "assets/photos/Panangiyam-Ammo iti Bagi 2.png",
      "csvPath" : ""
    },
    {//17
      "isList" : false,
      "title" : "Panangiyam-Ammo iti Bagi",
      "btnName" : "Panangiyam-Ammo iti Bagi (3)",
      "imgPath" : "assets/photos/Panangiyam-Ammo iti Bagi 3.png",
      "csvPath" : ""
    },
    {//18
      "isList" : false,
      "title" : "Katatao",
      "btnName" : "Katatao",
      "imgPath" : "assets/photos/Katatao.png",
      "csvPath" : ""
    },
    {//19
      "isList" : false,
      "title" : "Siak ken Sika / Sabali",
      "btnName" : "Siak ken Sika / Sabali",
      "imgPath" : "assets/photos/Siak ken Sika Sabali.png",
      "csvPath" : ""
    },
    {//20
      "isList" : false,
      "title" : "Panagdaydayaw",
      "btnName" : "Panagdaydayaw",
      "imgPath" : "",
      "csvPath" : "assets/lessons/Lessons - Panagdaydayaw.csv"
    },

  ];

  List<Map<String, dynamic>> lesson2Files = [];
  List<Map<String, dynamic>> lesson3Files = [];
  List<Map<String, dynamic>> lesson4Files = [];
  List<Map<String, dynamic>> lesson5Files = [];
  List<Map<String, dynamic>> lesson6Files = [];

  List<List<String>> appendixFiles = [
    ["assets/csv/Appendise - Uppat a Tipo ti Panekket.csv", "Uppat a Tipo ti Panekket"], //0
    ["assets/csv/Appendise - Listaan ti Panekket.csv", "Listaan ti Panekket"], //1

  ];

  //show/hide close button while reading
  ScrollController scrollControl = ScrollController();
  //rotating color list for titles
  List<Color> titleColorList = [Color(0xffd6e6ff), Color(0xffd7f9f8), Color(0xffffffea), Color(0xfffff0d4), Color(0xfffbe0e0), Color(0xffe5d4ef)];
  //rotating color list for lessons
  List<Color> lessonColorList = [Color(0xffecacb8), Color(0xffadacec), Color(0xffecc6ac), Color(0xffe0acec)];

  int numberOfLessons = 2;
  late TabController tcontroller = TabController(length: numberOfLessons, vsync: this);


  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
    scrollControl.dispose();
    tcontroller.dispose();
  }

  Future<List<List<List<dynamic>>>> loadLessonFiles(List<List<String>> filesToLoad) async{ //loads lesson files to display
    List<List<List<dynamic>>> loadedData = [];
    List<List<dynamic>> csvData;


    for(var i=0; i<filesToLoad.length; i++){
      csvData = await processCsv(filesToLoad[i][0]);
      loadedData.add(csvData);
    }

    return loadedData;
  }

  Future<List<List<dynamic>>> loadFile(String filename) async {
    List<List<dynamic>> csvData;
    csvData = await processCsv(filename);
    return csvData;
  }

  @override
  Widget build(BuildContext context) {
    var lessonList = [
      lesson1Files,
      lesson2Files,
      lesson3Files,
      lesson4Files,
      lesson5Files,
      lesson6Files
    ];
    var lessonTitles = [
      "Leksion 1:\nBUKOD A BAGI, SABALI, FAMILIA, KABAGIAN",
      "Leksion 2:\n",
      "Leksion 3:\n",
      "Leksion 4:\n",
      "Leksion 5:\n",
      "Leksion 6:\n",
    ];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text("Leksion"),

        ),
        body: Stack(
               children: [
                 SizedBox(
                   width: MediaQuery
                       .sizeOf(context)
                       .width,
                   child: Container(
                     decoration: BoxDecoration(
                       image: DecorationImage(
                           image: AssetImage("assets/photos/app_bg.png"), fit: BoxFit.cover),
                     ),
                   ),
                 ),
                 Padding(
                   padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                   child: Column(
                     children: [
                       SizedBox(
                         height: 50,
                         child: TabBar(
                             controller: tcontroller,
                             labelStyle: GoogleFonts.tinos(fontWeight: FontWeight.bold),
                             tabs: createTabs(),
                         ),
                       ),
                       Expanded(
                         child: TabBarView(
                             controller: tcontroller,
                             children: [
                               //create lessons tabbar view
                               for(int i=0; i<numberOfLessons-1; i++) createLessonTabView(lessonTitles[i], lessonList[i], i),

                               //appendix
                               SingleChildScrollView(
                                 padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                 child: ExpansionTile(
                                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                                   collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                                   trailing: Icon(Icons.list),
                                   collapsedBackgroundColor: titleColorList[(numberOfLessons-1)%6],
                                   backgroundColor: titleColorList[(numberOfLessons-1)%6],
                                   title: Row(
                                     children: [
                                       Expanded(
                                         flex: 1,
                                         child: Icon(
                                           Icons.library_books_outlined,
                                           size: 20,
                                         ),
                                       ),
                                       Expanded(
                                           flex: 12,
                                           child: Padding(
                                             padding: const EdgeInsets.all(8.0),
                                             child: Text("Appendise", style: GoogleFonts.chivo(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                                           )),
                                     ],
                                   ),
                                   children: [
                                     Column(
                                       children: [
                                         createLesson(appendixFiles[0][1], appendixFiles[0][1], "", appendixFiles[0][0], false, true),
                                         createAppendixList(appendixFiles[1][1], appendixFiles[1][1], appendixFiles[1][0]),
                                       ],
                                     )
                                   ],
                                 ),
                               ),
                             ]
                         ),
                       ),



                     ],
                   ),
                 ),
               ],
             )
              ,
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
      ),
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

  createTabs(){
    List<Tab> lessonTabs = [];

    for(int i=1; i<numberOfLessons; i++){
      lessonTabs.add(
          Tab(text: i.toString(),)
      );
    }

    lessonTabs.add(
        Tab(text: "Appendise")
    );

    return lessonTabs;
  }

  createLessonTabView(String lessonTitle, List<Map<String, dynamic>> lessonFile, int lessonNumber){
    return
      SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            ExpansionTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
              collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
              trailing: Icon(Icons.list),
              collapsedBackgroundColor: titleColorList[lessonNumber%6],
              backgroundColor: titleColorList[lessonNumber%6],
              title: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.menu_book_outlined,
                      size: 20,
                    ),
                  ),
                  Expanded(
                      flex: 12,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(lessonTitle, style: GoogleFonts.chivo(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                      )),
                ],
              ),
              children: [
                Column(
                  children:
                  createLessonChildren(lessonFile),
                )
              ],
            ),
          ],
        ),
      );
  }

  createLessonChildren(List<Map<String, dynamic>> lessonFiles){
    List<Widget> lessonTiles = [];
    bool hasText, hasImage;
    Map<String, dynamic> lesson;
    for(int i=0; i<lessonFiles.length; i++){
      lesson = lessonFiles[i];
      if(lesson["isList"]) { //list lesson
        lessonTiles.add(createListLesson(lesson["title"], lesson["btnName"], lesson["csvPath"]));
      }else{ //text / image lesson
        hasText = lesson["csvPath"] != "";
        hasImage = lesson["imgPath"] != "";
        lessonTiles.add(createLesson(lesson["title"], lesson["btnName"], lesson["imgPath"], lesson["csvPath"], hasImage, hasText));
      }
    }

    return lessonTiles;
  }

  createLesson(String title, String btnName, String imgPath, String csvPath, bool hasImage, bool hasText){ //creates a lesson tile
    IconData buttonIcon;
    int colorIndex;
    if(hasImage && hasText){
      buttonIcon = Icons.menu_book;
      colorIndex = 0;
    }else if(hasImage){
      buttonIcon = Icons.photo;
      colorIndex = 1;
    }else{
      buttonIcon = Icons.book;
      colorIndex = 2;
    }

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: lessonColorList[colorIndex]
        ),
        child: TextButton(
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => FutureBuilder(
              future: loadFile(csvPath),
              builder: (context, csvdata) {
                if(csvdata.hasData || hasImage) {
                  List<List<dynamic>>? csvData;
                  csvData = csvdata.data;
                  return Dialog.fullscreen(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: Color(0xfff6eee3)
                      ),
                      child: SizedBox(width: MediaQuery
                          .sizeOf(context)
                          .width,
                          child: Column(
                            children: [
                              //title
                              Center(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional
                                      .fromSTEB(0, 4, 0, 4),
                                  child: AutoSizeText(title,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.chivo(
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView(
                                  controller: scrollControl,
                                  children: [
                                    //creates the text if it has text
                                    if(hasText) createLessonText(
                                        csvData),
                                    //creates the image if it has image
                                    if(hasImage) createLessonImage(
                                        title, imgPath),
                                  ],
                                ),
                              ),
                              //close button
                              ScrollToHide(
                                scrollController: scrollControl,
                                height: 35,
                                hideDirection: Axis.vertical,
                                child: UnconstrainedBox(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    width: 90,
                                    height: 35,
                                    child: ElevatedButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('Close',
                                          style: TextStyle(
                                              fontFamily: "Quicksand",
                                              fontWeight: FontWeight
                                                  .bold)),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                      ),
                    ),
                  );
                }else{
                  return CircularProgressIndicator();
                }
              }
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Icon(
                    buttonIcon,
                    size: 18,
                  ),
                ),
              ),
              Expanded(
                flex: 12,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    btnName,
                    minFontSize: 16,
                    maxLines: 2,
                    style: GoogleFonts.chivo( fontWeight: FontWeight.bold),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  createListLesson(String title, String btnName, String csvPath) { //creates a button that shows the lesson's content as an alert dialog
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: lessonColorList[3]
        ),
        child: TextButton(
          onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => FutureBuilder(
                future: loadFile(csvPath),
                builder: (context, csvdata) {
                  if(csvdata.hasData) {
                    List<List<dynamic>> csvData = csvdata.data!;
                    return Dialog.fullscreen(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Color(0xfff6eee3)
                        ),
                        child: SizedBox(width: MediaQuery
                            .sizeOf(context)
                            .width,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 8, 0, 8),
                                child: AutoSizeText(title,
                                  maxLines: 2,
                                  style: GoogleFonts.chivo(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),

                              Expanded(child: buildLessonDialog(csvData)),

                              //close button
                              ScrollToHide(
                                scrollController: scrollControl,
                                height: 35,
                                hideDirection: Axis.vertical,
                                child: UnconstrainedBox(
                                  child: SizedBox(
                                    width: 90,
                                    height: 35,
                                    child: ElevatedButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text('Close',
                                          style: GoogleFonts.tinos(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),
                              )

                            ],
                          ),
                        ),
                      ),
                    );
                  }else{
                    return CircularProgressIndicator();
                  }
                }
              )),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Icon(
                    Icons.library_books,
                    size: 18,
                  ),
                ),
              ),
              Expanded(
                flex: 12,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    btnName,
                    minFontSize: 16,
                    maxLines: 2,
                    style: GoogleFonts.chivo( fontWeight: FontWeight.bold),),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

  createAppendixList(String title, String btnName, String csvPath){
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: lessonColorList[3]
        ),
        child: TextButton(
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => FutureBuilder(
              future: loadFile(csvPath),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  List<List<dynamic>> csvData = snapshot.data!;
                  return Dialog.fullscreen(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: Color(0xfff6eee3)
                      ),
                      child: SizedBox(width: MediaQuery
                          .sizeOf(context)
                          .width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start,
                            children: [
                              //title
                              Center(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional
                                      .fromSTEB(0, 8, 0, 8),
                                  child: AutoSizeText(title,
                                    maxLines: 2,
                                    style: GoogleFonts.chivo(
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: SearchableList(
                                    initialList: csvData,
                                    itemBuilder: (csvRow) =>
                                        createAppendixItem(csvRow),
                                    emptyWidget: Text(
                                      "Awan iti panekket.",
                                      style: GoogleFonts.chivo(
                                          color: Colors.red),),
                                    filter: (value) =>
                                        csvData
                                            .where((element) =>
                                            element[0]
                                                .toLowerCase()
                                                .contains(value),)
                                            .toList(),
                                    inputDecoration: InputDecoration(
                                      labelText: "Kitaen",
                                      fillColor: Colors.white,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.blue,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius
                                            .circular(10.0),
                                      ),
                                    ),
                                  )
                              ),
                              const Divider(),
                              //close button
                              Center(
                                child: UnconstrainedBox(
                                  child: SizedBox(
                                    width: 90,
                                    height: 35,
                                    child: ElevatedButton(

                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('Close'),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                      ),
                    ),
                  );
                }else{
                  return CircularProgressIndicator();
                }
              }
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Icon(
                    Icons.library_books,
                    size: 18,
                  ),
                ),
              ),
              Expanded(
                flex: 12,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    btnName,
                    minFontSize: 16,
                    maxLines: 3,
                    style: GoogleFonts.chivo( fontWeight: FontWeight.bold),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  createAppendixItem(List<dynamic> csvRow){
    List<String> sampleSentences = [];
    for(var i=1; i<csvRow.length; i++){
      if(!csvRow[i].isEmpty){
        sampleSentences.add(csvRow[i]);
      }
    }
    return
      Container(
        decoration: BoxDecoration(border: Border(
            bottom: BorderSide(color: Theme.of(context).dividerColor))
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
          child: Align(
            alignment: Alignment.centerLeft,
            child: (
                TextButton(
                    onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => Dialog(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: Color(0xfff6eee3)
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.all(8),
                                  child: AutoSizeText("${csvRow[0]}",
                                    maxLines: 5,
                                    style: GoogleFonts.chivo(
                                        fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Center(
                                  child: createSampleSentencesDialog(sampleSentences),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: UnconstrainedBox(
                                    child: SizedBox(
                                      width: 90,
                                      height: 35,
                                      child: ElevatedButton(
                                        onPressed: () => Navigator.of(context).pop(),
                                        child: const Text('Close'),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                    child: AutoSizeText(csvRow[0],
                      style: GoogleFonts.tinos(
                          fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue),
                    )
                )
            ),
          ),
        ),
      );
  }

  createLessonText(List<List<dynamic>>? csvData){
    if(csvData == null) {
      return;
    } else{
      return Padding(
        padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for(int i = 0; i<csvData.length; i++) listText(csvData[i][0])
          ],
        ),
      );
    }
  }

  listText(String text){
    return (
        AutoSizeText(text,
          textAlign: TextAlign.justify,
          minFontSize: 18,
          style: GoogleFonts.tinos(
              fontSize: 18),
        )
    );
  }
  createLessonImage(String title, String imgPath){
    return(InkWell(
      onTap: ()=>Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PhotoView(
            imageProvider: AssetImage(imgPath),
            backgroundDecoration: const BoxDecoration(color: Colors.transparent),
            basePosition: Alignment.center,
            enablePanAlways: true,
            tightMode: true,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: PhotoView(
          imageProvider: AssetImage(imgPath),
          backgroundDecoration: const BoxDecoration(color: Colors.transparent),
          basePosition: Alignment.topCenter,
          enablePanAlways: true,
          tightMode: true,
        ),
      ),
    ));
  }

  buildLessonDialog(List<List<dynamic>> csvData) { //builds listview of the lessons
    return ListView.builder(
        controller: scrollControl,
        itemCount: csvData.length,
        itemBuilder: (context, index) {
            return Container(
                decoration: BoxDecoration(border: Border(
                    bottom: BorderSide(color: Theme.of(context).dividerColor))
                ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                child: Row(
                  children:
                    createCols(csvData[index]) //file have different number of columns

                ),
              ),
            );
          } // itemBuilder
    );
  }

  createCols(List<dynamic> data) { //creates the columns for the listview of lesson
    List<Widget> cols = [];
    List<String> sampleSentences = [];
    int flexVal = 1;
    // print(data);
    for(var i = 0; i<data.length; i++){
      flexVal = 3;
      switch(i){
        case 0: flexVal = 1;
        case 1: flexVal = 6;
      }
      if(i<2){
        cols.add(Expanded(
          flex: flexVal,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(3, 10, 2, 0),
            child: AutoSizeText(data[i],
              style: GoogleFonts.tinos(
                  fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ));
      }
      else{
        if(!data[i].isEmpty) {
          sampleSentences.add(data[i]);
        }
      }

    }
    if(data.length>1){
      //show sample sentences as dialog
      cols.add(Expanded(
          flex: 2,
          child: Center(
              child: TextButton(
                onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => Dialog(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Color(0xfff6eee3)
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                              child: AutoSizeText("Ejemplo ${data[0]}",
                                maxLines: 1,
                                style: GoogleFonts.chivo(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: createSampleSentencesDialog(sampleSentences),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                              child: SizedBox(
                                width: 90,
                                height: 35,
                                child: ElevatedButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Close'),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
                child: AutoSizeText("Ejemplo",
                  maxLines: 1,
                  style: GoogleFonts.tinos(
                      fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue,),
              )
              )))
      );
    }

    return cols;
  }

  createSampleSentencesDialog(List<String> sampleSentences){

    if(sampleSentences.isNotEmpty) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: sampleSentences.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.black))
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AutoSizeText(sampleSentences[index],
                              style: GoogleFonts.tinos(fontSize: 18)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } // itemBuilder
      );
    }else{
      return Text("Empty.", style: GoogleFonts.tinos());
    }
  }

  Future<List<List<dynamic>>> processCsv(String filename) async {
    var result = await DefaultAssetBundle.of(context).loadString(
      filename,
    );
    return const CsvToListConverter().convert(result);
  }
}
