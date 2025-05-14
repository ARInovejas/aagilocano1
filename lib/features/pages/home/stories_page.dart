import 'package:aagilocano1/features/app/splash_screen/loading_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:scroll_to_hide/scroll_to_hide.dart';

class StoriesPage extends StatefulWidget {
  const StoriesPage({super.key});

  @override
  State<StoriesPage> createState() => _StoriesPageState();
}

class _StoriesPageState extends State<StoriesPage> {

  List<String> quizFiles = [
    "assets/csv/Stories - Ti Umuna nga Iyaadakko Idiay Mindanao Quiz.csv", //0
    "assets/csv/Stories - Siak ken ti Familiak Quiz.csv", //1
    "assets/csv/Stories - Siak ken ti Familiak Quiz.csv", //2
    "assets/csv/Stories - Siak ken Dagiti Kabagiak Quiz.csv", //3
  ];
  List<String> imgFiles = [
    "assets/photos/Ti Umuna 1.jpg", //0
    "assets/photos/Ti Pagsasao nga Ilokano iti Utob-Nakemko.png", //1
    "assets/photos/Siak ken ti Familiak 1.png", //2
    "assets/photos/Siak ken Dagiti Kabagiak.png", //3
  ];

  late Future<List<List<dynamic>>> storiesData;
  late Future<List<List<List<dynamic>>>> quizzesData;
  late List<Future<dynamic>> dataFiles;

  //show/hide close button while reading
  ScrollController scrollControl = ScrollController();

  @override
  void initState(){
    super.initState();
    storiesData = loadStories();
    quizzesData = loadFiles(quizFiles);
    dataFiles = [storiesData, quizzesData];

  }

  @override
  void dispose(){
    super.dispose();
    scrollControl.dispose();
  }

  Future<List<List<dynamic>>> loadStories() async{ //loads stories to display
    List<List<dynamic>> csvData;
    csvData = await processCsv("assets/csv/Stories.csv");

    return csvData;
  }

  Future<List<List<List<dynamic>>>> loadFiles(List<String> filesToLoad) async{ //loads lesson files to display
    List<List<List<dynamic>>> loadedData = [];
    List<List<dynamic>> csvData;


    for(var i=0; i<filesToLoad.length; i++){
      csvData = await processCsv(filesToLoad[i]);
      loadedData.add(csvData);
    }

    return loadedData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait(dataFiles),
        builder: (context, snapshot){
         if(snapshot.hasData){
           var stories = snapshot.data![0];
           var storyQuizzes = snapshot.data![1];
           var colorList = [Color(0xffecacb8), Color(0xffadacec), Color(0xffecc6ac), Color(0xffe0acec)];

           return Padding(
             padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
             child: ListView.builder(
                 itemCount: (stories.length)!-1,
                 itemBuilder: (context, index){
                   return Padding(
                     padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                     child: DecoratedBox(
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         color: colorList[index % 4]
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
                                           children: [

                                             //title and author
                                             AutoSizeText(stories[index+1][0],
                                                 textAlign: TextAlign.center, maxLines: 2,
                                                 style: GoogleFonts.chivo(
                                                     fontWeight: FontWeight.bold, fontSize: 36)),
                                             Text("Ni ${stories[index+1][1]}",
                                                 textAlign: TextAlign.center,
                                                 style: GoogleFonts.chivo(
                                                     fontSize: 16, fontStyle: FontStyle.italic)),


                                             //story
                                             Expanded(
                                               child: Padding(
                                                 padding: EdgeInsets.all(8.0),
                                                 child: buildStoryDialog(stories[index+1], imgFiles[index]),
                                               ),
                                             ),

                                             //quiz/exercise
                                             if(index == 2 || index == 3) createStoryQuiz(stories[index+1][0], "Ejersisio", storyQuizzes[index], true),



                                             //close button
                                             ScrollToHide(
                                               scrollController: scrollControl,
                                               hideDirection: Axis.vertical,
                                               child: ElevatedButton(
                                                 onPressed: () => Navigator.of(context).pop(),
                                                 child: Text('Close', style: GoogleFonts.tinos( fontWeight: FontWeight.bold)),
                                               ),
                                             )
                                           ],
                                         )
                                     ),
                                   ),
                                 ),
                               ),
                               child: Column(
                                 children: [
                                   //image
                                   if(imgFiles[index] != "") Container(
                                       child: Image.asset(imgFiles[index])
                                   ),
                                   Row(
                                     children: [
                                       Expanded(
                                         child: Padding(
                                           padding: const EdgeInsets.symmetric(vertical: 8.0),
                                           child: Align(
                                             alignment: Alignment.centerLeft,
                                             child: Column(
                                               mainAxisAlignment: MainAxisAlignment.center,
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               children: [
                                                 AutoSizeText(
                                                   stories[index+1][0],
                                                   minFontSize: 20,
                                                   maxLines: 2,
                                                   style: GoogleFonts.chivo( fontWeight: FontWeight.bold),),
                                                 Text("Ni ${stories[index+1][1]}",
                                                     textAlign: TextAlign.left,
                                                     style: GoogleFonts.chivo(
                                                         fontSize: 16, fontStyle: FontStyle.italic))
                                               ],
                                             ),
                                           ),
                                         ),
                                       ),
                                     ],
                                   ),
                                 ],
                               ),
                             ),
                     ),
                   );
                 }
             ),
           );
         }else{
           return const DefaultLoadingScreen();
         }
        }
    );
  }


  insertImage(String title, String imgPath){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: (InkWell(
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
      )),
    );
  }


  buildStoryDialog(List<dynamic> data, String imgPath){
    return ListView.builder(
        controller: scrollControl,
        shrinkWrap: true,
        itemCount: data.length - 1,
        itemBuilder: (context, index) {
          if(index == 0) {
            //insert photo first
            if(imgPath == "") {
              return const Row();
            }else{
            return insertImage(data[index+1][0], imgPath);
            }
          }else{
            if (data[index + 1] != '') {
              return AutoSizeText("${data[index + 1]}\n",
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.tinos( fontSize: 18)
              );
            } else {
              return const Row();
            }
          }
        }
    );
  }

  createStoryQuiz(String title, String btnName, List<List<dynamic>> csvData, bool hasAnswers) {
    return(
        TextButton(
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //title
                        AutoSizeText(title,
                            textAlign: TextAlign.center, maxLines: 2,
                            style: GoogleFonts.chivo(
                                fontWeight: FontWeight.bold, fontSize: 36)),
                        Expanded(
                          child: createStoryQuizForm(csvData, hasAnswers),
                        ),
                        //close button
                        Center(
                          child: ScrollToHide(
                            scrollController: scrollControl,
                            hideDirection: Axis.vertical,
                            height: 35,
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
          child: Text(btnName, style: GoogleFonts.tinos( fontWeight: FontWeight.bold)),
        )
    );
  }

  createStoryQuizForm(List<List<dynamic>> csvData, bool hasAnswers){
    var colNum=csvData[1][0];
    var label=csvData[2][colNum-1];
    var quizType=csvData[0][0];
    return Column(
      children: [
        if(quizType == "True or False") Align(
          alignment: Alignment.centerLeft,
          child: AutoSizeText(" True or False",
              textAlign: TextAlign.left, maxLines: 1,
              style: GoogleFonts.chivo(
                  fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        Expanded(
          child: ListView.builder(
              // controller: scrollControl,
              itemCount: csvData.length-2,
              itemBuilder: (context, index) {
                if(index+2 == 2){ //creates header
                  if(!csvData[index+2][0].isEmpty){
                    return Container(
                      decoration: BoxDecoration(border: Border.all()),
                      child: Row(
                        children:
                        createHeaders(csvData[index+2], colNum, hasAnswers)
                        ,
                      ),
                    );
                  }else{
                    return const Row();
                  }
          
                }else{
                  return Container(
                    decoration: BoxDecoration(border: Border.all()),
                    child: Row(
                      children:
                      createFormContent(csvData[index+2], colNum, hasAnswers, label)
                      ,
                    ),
                  );
                }
              }
          ),
        )
      ],
    );

  }

  createHeaders(List<dynamic> csvRow, var colNum, bool hasAnswers){
    List<Widget> headers = [];
    for(var i=0; i<colNum; i++){
      headers.add(
          Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(8.0),
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
                child: AutoSizeText("${csvRow[i]}",
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
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: label,
              labelStyle: GoogleFonts.tinos(fontSize: 18),
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
                message: "${csvRow[totalCol]}",
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
