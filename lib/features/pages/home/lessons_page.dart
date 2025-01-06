import 'package:aagilocano1/features/app/splash_screen/loading_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class LessonsPage extends StatefulWidget {
  const LessonsPage({super.key});

  @override
  State<LessonsPage> createState() => _LessonsPageState();
}

class _LessonsPageState extends State<LessonsPage> {
  List<List<String>> lessonFiles = [
    ["packages/aagilocano1/assets/csv/Unit System.csv", "Sistema Ti Uni"],
    ["packages/aagilocano1/assets/csv/Diptonggo.csv", "Diptonggo"],

  ];
  late Future<List<List<List<dynamic>>>> lessonData;

  @override
  void initState(){
    super.initState();
    lessonData = loadFiles();
  }

  Future<List<List<List<dynamic>>>> loadFiles() async{ //loads lesson files to display
    List<List<List<dynamic>>> loadedData = [];
    List<List<dynamic>> csvData;


    for(var i=0; i<lessonFiles.length; i++){
      csvData = await processCsv(lessonFiles[i][0]);
      loadedData.add(csvData);
    }

    return loadedData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: lessonData,
        builder: (context, snapshot){
           if(snapshot.hasData){
             return Column(
               children: [
                 ExpansionTile(
                   title: const Text("Lessons"),
                   children: [
                     ExpansionTile(
                       title: const Text("Lesson 1", style: TextStyle(color: Colors.blueAccent),),
                       children: [
                         Column(
                           children: [
                             //Alphabet Evolution
                             createImageLesson("Evolusion Dagiti Uni ken Letra ti Kur-itan", "Evolusion Dagiti Uni ken Letra ti Kur-itan (1)", 'packages/aagilocano1/assets/photos/Alphabet Evolution 1.jpg'),
                             createImageLesson("Evolusion Dagiti Uni ken Letra ti Kur-itan", "Evolusion Dagiti Uni ken Letra ti Kur-itan (2)", 'packages/aagilocano1/assets/photos/Alphabet Evolution 2.jpg')
                           ],
                         ),
                         listLessons(snapshot.data)
                         ,
                         Column(
                           children: [
                             createImageLesson("Diptonggo", "Diptonggo (3)", 'packages/aagilocano1/assets/photos/Diptonggo Table.png'),
                             createImageLesson("Ridis", "Ridis", 'packages/aagilocano1/assets/photos/Ridis.png')
                           ],
                         )
                       ],
                     ),
                   ]
                 ),
                 ExpansionTile(
                   title: const Text("Practice Quizzes"),
                   children: [
                     // listPrevQuizzes()
                   ],
                 )
               ],
             );
           }else{
             return const DefaultLoadingScreen();
           }

          });
  }

  createImageLesson(String title, String btnName, String imgPath){ //creates a lesson tile (image format)
    return(
        TextButton(
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text(title),
              content: SizedBox(width: MediaQuery
                  .sizeOf(context)
                  .width,
                  child: PhotoView(imageProvider: AssetImage(imgPath))),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                )
              ],
            ),
          ),
          child: Text(btnName),
        )
    );
  }

  listLessons(List<List<List>>? snapData) { //creates a list of lessons
    return Column(
        children:[
          for(var index=0; index<lessonFiles.length; index++)
            createLessonTile(lessonFiles[index][0], lessonFiles[index][1], snapData![index])
        ]
    );
  }

  createLessonTile(String filename, String tileName, List<List<dynamic>> csvData) { //creates a button that shows the lesson's content as an alert dialog
    return(
        TextButton(
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text(tileName),
              content: SizedBox(width: MediaQuery
                  .sizeOf(context)
                  .width,
                  child: buildLessonDialog(csvData)),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                )
              ],
            ),
          ),
          child: Text(tileName),
        )
    );


  }

  buildLessonDialog(List<List<dynamic>> csvData) { //builds listview of the lessons
    return ListView.builder(
        itemCount: csvData.length,
        itemBuilder: (context, index) {
            return Row(
              children:
                createCols(csvData[index]) //file have different number of columns

            );
          } // itemBuilder
    );
  }

  createCols(List<dynamic> data) { //creates the columns for the listview of lesson
    List<Widget> cols = [];
    // print(data);
    for(var i = 0; i<data.length; i++){
      cols.add(Expanded(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: AutoSizeText(data[i],
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15),
            ),
        ),
      )
      );

    }

    return cols;
  }

  listPrevQuizzes() async{

  }

  Future<List<List<dynamic>>> processCsv(String filename) async {
    var result = await DefaultAssetBundle.of(context).loadString(
      filename,
    );
    return const CsvToListConverter().convert(result);
  }
}
