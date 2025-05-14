

import 'package:aagilocano1/features/app/splash_screen/loading_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_to_hide/scroll_to_hide.dart';

class PracticePage extends StatefulWidget {
  const PracticePage({super.key});

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> with TickerProviderStateMixin {

  List<List<String>> practiceLessonFiles1 = [
    ["assets/csv/Practice Quizzes - Panagdaydayaw.csv", "Panagdaydayaw"], //0
    ["assets/csv/Practice Quizzes - Ti Oras ita nga Aldaw.csv", "Ti Oras ita nga Aldaw"], //1
    ["assets/csv/Practice Quizzes - Serie dagiti numero.csv", "Serie dagiti numero"], //2
  ];

  late Future<List<List<List<dynamic>>>> lesson1;
  late List<Future<List<List<List<dynamic>>>>> dataFiles;

  //show/hide close button while reading
  ScrollController scrollControl = ScrollController();
  //rotating color list for titles
  List<Color> titleColorList = [Color(0xffd6e6ff), Color(0xffd7f9f8), Color(0xffffffea), Color(0xfffff0d4), Color(0xfffbe0e0), Color(0xffe5d4ef)];
  //rotating color list for lessons
  List<Color> lessonColorList = [Color(0xffecacb8), Color(0xffadacec), Color(0xffecc6ac), Color(0xffe0acec)];

  int numberOfLessons = 1;
  late TabController tcontroller = TabController(length: numberOfLessons, vsync: this);

  @override
  void initState(){
    super.initState();
    lesson1 = loadLessonFiles(practiceLessonFiles1);
    dataFiles = [lesson1];
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

  @override
  Widget build(BuildContext context) {

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
          title: Text("Praktis"),

        ),
        body: FutureBuilder(
            future: Future.wait(dataFiles),
            builder: (context, snapshot){
              if(snapshot.hasData){
                var lesson1Snapshot = snapshot.data![0]; //lesson1

                return Stack(
                  children: [
                    SizedBox(
                      width: MediaQuery
                          .sizeOf(context)
                          .width,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/photos/app_bg.png"), fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                                for(int i=0; i<numberOfLessons; i++) createQuizzesTab(lessonTitles[0], lesson1Snapshot),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }else{
                return const DefaultLoadingScreen();
              }

            }),
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

    for(int i=1; i<=numberOfLessons; i++){
      lessonTabs.add(
          Tab(text: i.toString(),)
      );
    }

    return lessonTabs;
  }

  createQuizzesTab(String title, List<List<List<dynamic>>> lessonFiles){
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          ExpansionTile(
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
                    Icons.question_answer,
                    size: 20,
                  ),
                ),
                Expanded(
                    flex: 12,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(title, style: GoogleFonts.chivo(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),),
                    )),
              ],
            ),
            children: [
              Column(
                children: [
                  for(int i=0; i<lessonFiles.length; i++) createPracticeQuiz(practiceLessonFiles1[i][1], practiceLessonFiles1[i][1], lessonFiles[i], true),


                ],
              )
            ],
          )

        ],
      ),
    );
  }

  createPracticeQuiz(String title, String btnName, List<List<dynamic>> csvData, bool hasAnswers) {
    IconData buttonIcon;
    int colorIndex;
    if(hasAnswers){
      buttonIcon = Icons.view_list;
      colorIndex = 0;
    }else{
      buttonIcon = Icons.list;
      colorIndex = 2;
    }
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: lessonColorList[colorIndex]
        ),
        child: TextButton(
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => Dialog.fullscreen(
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: Color(0xfff6eee3)
                ),
                child: SizedBox(width: MediaQuery
                    .sizeOf(context)
                    .width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //title
                        Center(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                            child: AutoSizeText(title,
                              maxLines: 2,
                              style: GoogleFonts.chivo(
                                  fontSize: 36, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: createPracticeQuizForm(csvData, hasAnswers),
                        ),
                        const Divider(),
                        //close button
                        Center(
                          child: ScrollToHide(
                            scrollController: scrollControl,
                            height: 35,
                            hideDirection: Axis.vertical,
                            child: UnconstrainedBox(
                              child: SizedBox(
                                width: 90,
                                height: 35,
                                child: ElevatedButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text('Close', style: GoogleFonts.tinos( fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                ),
              ),
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

  createPracticeQuizForm(List<List<dynamic>> csvData, bool hasAnswers){
    var colNum=csvData[0][0];
    var label=csvData[1][colNum-1];
    return(
        ListView.builder(
            controller: scrollControl,
            itemCount: csvData.length-1,
            itemBuilder: (context, index) {
              if(index+1 == 1){ //creates header
                return Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                    child: Row(
                      children:
                      createHeaders(csvData[index+1], colNum, hasAnswers)
                      ,
                    ),
                  ),
                );
              }else{
                return Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: Row(
                    children:
                    createFormContent(csvData[index+1], colNum, hasAnswers, label)
                    ,
                  ),
                );
              }
            }
        )
    );

  }

  createHeaders(List<dynamic> csvRow, var colNum, bool hasAnswers){
    List<Widget> headers = [];
    for(var i=0; i<colNum; i++){
      headers.add(
          Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: AutoSizeText(csvRow[i],
                  minFontSize: 20,
                  style: GoogleFonts.chivo(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              )
          )
      );
    }
    if(hasAnswers){
      headers.add(
          Expanded(
              flex: 1,
              child: const Text("")
          )
      );
    }
    return headers;
  }

  createFormContent(List<dynamic> csvRow, var colNum, bool hasAnswers, var label){
    List<Widget> colWidgets = [];
    var totalCol = colNum;
    if(hasAnswers) totalCol--;
    for(var i=0; i<totalCol; i++){
      // add "questions"
      colWidgets.add(
          Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: AutoSizeText(csvRow[i],
                  minFontSize: 18,
                  style: GoogleFonts.tinos(
                      fontSize: 18),
                ),
              )
          )
      );
    }
    //add form
    colWidgets.add(
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: label,
                labelStyle: GoogleFonts.tinos(fontSize: 16),
              ),
            ),
          ),
        )
    );
    //add hint/answer popup
    if(hasAnswers){
      colWidgets.add(
          Expanded(
              flex: 1,
              child: Tooltip(
                message: csvRow[totalCol],
                triggerMode: TooltipTriggerMode.tap,
                child: Icon(Icons.lightbulb_circle_rounded),
              )
          )
      );
    }
    return colWidgets;
  }

  Future<List<List<dynamic>>> processCsv(String filename) async {
    var result = await DefaultAssetBundle.of(context).loadString(
      filename,
    );
    return const CsvToListConverter().convert(result);
  }
}
