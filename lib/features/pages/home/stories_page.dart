import 'package:aagilocano1/features/app/splash_screen/loading_screen.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StoriesPage extends StatefulWidget {
  const StoriesPage({super.key});

  @override
  State<StoriesPage> createState() => _StoriesPageState();
}

class _StoriesPageState extends State<StoriesPage> {

  late Future<List<List<dynamic>>> storiesData;

  @override
  void initState(){
    super.initState();
    storiesData = loadStories();
  }

  Future<List<List<dynamic>>> loadStories() async{ //loads stories to display
    List<List<dynamic>> csvData;
    csvData = await processCsv("packages/aagilocano1/assets/csv/Stories.csv");

    return csvData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: storiesData,
        builder: (context, snapshot){
         if(snapshot.hasData){
           return ListView.builder(
               itemCount: (snapshot.data?.length)!-1,
               itemBuilder: (context, index){
                 return TextButton(
                         onPressed: () => showDialog<String>(
                           context: context,
                           builder: (BuildContext context) => AlertDialog(
                             title: Column(
                               children: [
                                 Text(snapshot.data?[index+1][0],
                                     textAlign: TextAlign.center,
                                     style: const TextStyle(
                                         fontWeight: FontWeight.bold, fontSize: 20)),
                                 Text("Ni ${snapshot.data?[index+1][1]}",
                                     textAlign: TextAlign.center,
                                     style: const TextStyle(
                                         fontSize: 14, fontStyle: FontStyle.italic)),
                               ],
                             ),
                             content: SizedBox(width: MediaQuery
                                 .sizeOf(context)
                                 .width,
                                 child: buildStoryDialog(snapshot.data?[index+1])),
                             actions: [
                               TextButton(
                                 onPressed: () => Navigator.of(context).pop(),
                                 child: const Text('Close'),
                               )
                             ],
                           ),
                         ),
                         child: Text(snapshot.data?[index+1][0]),
                       );
               }
           );
         }else{
           return const DefaultLoadingScreen();
         }
        }
    );
  }

  buildStoryDialog(List? data){

    return ListView.builder(
        itemCount: data!.length-2,
        itemBuilder: (context, index){
          if(data[index+2] != ''){
            return Text("${data[index+2]} \n",
              style: GoogleFonts.lato(
                fontSize: 16
              )
            );
          }
        }
    );
  }

  Future<List<List<dynamic>>> processCsv(String filename) async {
    var result = await DefaultAssetBundle.of(context).loadString(
      filename,
    );
    return const CsvToListConverter().convert(result);
  }
}
