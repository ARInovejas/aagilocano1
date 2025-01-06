

import 'package:aagilocano1/features/app/splash_screen/loading_screen.dart';
import 'package:aagilocano1/features/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:csv/csv.dart';
import 'package:collection/collection.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
      return isLoading ?
          const NewUserLoadingScreen()
          :Scaffold(

        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body:

        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.symmetric(vertical: 10),
                      child:
                      CircleAvatar(
                        backgroundImage: AssetImage(
                            'packages/aagilocano1/assets/photos/ailocano_logo_canva.png'),
                        backgroundColor: Colors.lightGreen,
                        radius: 64.0,
                      ),
                    ),
                    Stack( //Title
                      children: <Widget>[
                        // Stroked text as border.
                        Text(
                          'iLaing',
                          style: TextStyle(
                            fontSize: 48,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 2
                              ..color = const Color(0xffacece0),
                          ),
                        ),
                        // Solid text as fill.
                        const Text(
                          'iLaing',
                          style: TextStyle(
                            fontSize: 48,
                            color: Color(0xff1a1a1a),
                          ),
                        ),
                      ],
                    ),

                    const Divider(
                      height: 1,
                      // The height of the divider
                      color: Colors.black,
                      // The color of the divider
                      thickness: 1,
                      // The thickness of the divider line
                      indent: 10,
                      // The left padding (indent) of the divider
                      endIndent: 10, // The right padding (endIndent) of the divider
                    ),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'An Ilocano Language Learning Application based on the ',
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black54),
                              ),
                              TextSpan(
                                text: 'ILAING',
                                style: const TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    launchUrlString(
                                        'https://lainghawaii.org/ilaing/');
                                  },
                              ),
                              const TextSpan(
                                text: ' language learning program',
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black54),
                              ),
                            ],
                          ),
                        )
                    ),
                    const Divider(
                      height: 1,
                      // The height of the divider
                      color: Colors.black,
                      // The color of the divider
                      thickness: 1,
                      // The thickness of the divider line
                      indent: 10,
                      // The left padding (indent) of the divider
                      endIndent: 10, // The right padding (endIndent) of the divider
                    ),

                  ],

                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("START LEARNING NOW", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black),)
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          signInWithGoogle();
                        },
                        child: const Text("Continue with Google"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.resolveWith<
                                Color?>((Set<WidgetState> states) {
                              return Colors.blue;
                            })),
                        onPressed: () {
                          signInWithFacebook();
                        },
                        child: const Text("Continue with Facebook"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }




  signInWithGoogle() async{


    try{
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if(googleUser != null){

        final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken,
            idToken: googleAuth?.idToken);

        UserCredential userCredential= await FirebaseAuth.instance.signInWithCredential(credential);
        if(userCredential.additionalUserInfo!.isNewUser){
          setState(() {
            isLoading = true;
          });
          await DatabaseService(uid: userCredential.user!.uid).updateUserData(1, 0);
          await DatabaseService(uid: userCredential.user!.uid).createNewUserDictionary();
          await DatabaseService(uid: userCredential.user!.uid).createNewUserQuizList();
          await DatabaseService(uid: userCredential.user!.uid).createNewUserAchievementsList();
          await DatabaseService(uid: userCredential.user!.uid).createNewUserStoriesList();
        }

        print(userCredential.user?.toString());

        //admin updates to firebase
        // await loadDictionary();
        // await loadQuestions();
        // await loadStories();
        Navigator.pushNamed(context, '/profile');
      }
    }catch(e){
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  } // signInWithGoogle

  signInWithFacebook() async{
    try{
      final LoginResult res = await FacebookAuth.instance.login();
      if(res.status == LoginStatus.success){

        final AuthCredential credential = FacebookAuthProvider.credential(res.accessToken!.tokenString);
        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        if(userCredential.additionalUserInfo!.isNewUser){
          setState(() {
            isLoading = true;
          });
          await DatabaseService(uid: userCredential.user!.uid).updateUserData(1, 0);
          await DatabaseService(uid: userCredential.user!.uid).createNewUserDictionary();
          await DatabaseService(uid: userCredential.user!.uid).createNewUserQuizList();
          await DatabaseService(uid: userCredential.user!.uid).createNewUserAchievementsList();
        }
        print(userCredential.user?.toString());
        // await loadDictionary();
        Navigator.pushNamed(context, '/profile');
      }

    }catch(e){
      setState(() {
        isLoading = false;
      });
      print(e);
    }

  } // signInWithFacebook

  loadDictionary() async{
    //loads file of words from assets and updates the firebase list of words
    //only called by admin when updating the dictionary list
    List<String> filenames = [
      "packages/aagilocano1/assets/csv/Verbs.csv",
      "packages/aagilocano1/assets/csv/Past Tense.csv",
      "packages/aagilocano1/assets/csv/Present Tense.csv",
      "packages/aagilocano1/assets/csv/Future Tense.csv",
      "packages/aagilocano1/assets/csv/Basic Phrases.csv",
      "packages/aagilocano1/assets/csv/Dates.csv",
      "packages/aagilocano1/assets/csv/Family.csv",
      "packages/aagilocano1/assets/csv/Greetings.csv",
      "packages/aagilocano1/assets/csv/Location.csv",
      "packages/aagilocano1/assets/csv/Navigation.csv",
      "packages/aagilocano1/assets/csv/Numbers.csv"

    ];

    List<List<dynamic>> csvData;
    String type = "";
    for(var i = 0; i < filenames.length; i++) {
      csvData = await processCsv(filenames[i]);

      if(i < 4) {
        type = "verb";
      }
      switch(i){
        case 4:
          type = "basic phrase";
        case 5:
          type = "dates";
        case 6:
          type = "family";
        case 7:
          type = "greetings";
        case 8:
          type = "location";
        case 9:
          type = "navigation";
        case 10:
          type = "numbers";
      }
      for (var j = 1; j < csvData.length; j++) {
        // print(csvData[j]);
        await DatabaseService(uid: "admin").updateDictionary(csvData[j][0].toString().toLowerCase(), csvData[j][1].toString().toLowerCase(), type);
      }
    }
    print("Dictionary updated");
  }

  loadStories() async{
    //loads file of stories from assets and updates the firebase list of stories
    //only called by admin when updating the stories list

    String filename =  "packages/aagilocano1/assets/csv/Stories.csv";

    List<List<dynamic>> csvData = await processCsv(filename);
    String title, author;
    List<String> paragraphs = [];
    //0 title, 1 author, > paragraphs
    var data;

    for (var i = 1; i<csvData.length; i++){
      title = csvData[i][0];
      author = csvData[i][1];
      paragraphs = [];
      for(var j = 2; j<csvData[i].length; j++){
        paragraphs.add(csvData[i][j]);
      }
      data = {
        "title": title,
        "author": author,
        "paragraphs": paragraphs
      };
      print(data);
      await DatabaseService(uid: "admin").adminAddStories(data, title);
    }

    print("Stories updated");
  }

  loadQuestions() async{
    //loads questions into firebase
    //called by admin
    List<List<dynamic>> questionList, answerList;
    questionList = await processCsv("packages/aagilocano1/assets/csv/Multiple Choice Questions.csv");
    //0 questionText, 1 leitnerWeight, 2 lesson
    answerList = await processCsv("packages/aagilocano1/assets/csv/Multiple Choice Answers.csv");
    var data;
    List<Map<String, dynamic>> answerAsListMap = [];
    for (var i = 1; i < questionList.length; i++){
      answerAsListMap = convertAnswersToListMap(answerList[i]);
      data = {
        "questionText": questionList[i][0],
        "leitnerWeight": questionList[i][1],
        "lesson": questionList[i][2],
        "answers": answerAsListMap,
      };
      await DatabaseService(uid: "admin").adminUpdateMCQuestions(data, questionList[i][0]);

    }
  }

  List<Map<String, dynamic>> convertAnswersToListMap(List<dynamic> answerSet){
    var slicedAns = answerSet.slices(2);
    // print(slicedAns);
    List<Map<String, dynamic>> listMapAns = [];
    for (var ans in slicedAns) {
      listMapAns.add({
        "answer": ans[0].toString(),
        "score": ans[1],
      });
    }
    // print(listMapAns);
    return listMapAns;
  }

  Future<List<List<dynamic>>> processCsv(String filename) async {
    var result = await DefaultAssetBundle.of(context).loadString(
      filename,
    );
    return const CsvToListConverter().convert(result);
  }
}

