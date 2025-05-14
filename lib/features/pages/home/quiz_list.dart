import 'dart:math';

import 'package:aagilocano1/Models/achievement.dart';
import 'package:aagilocano1/Models/mc_question.dart';
import 'package:aagilocano1/features/app/splash_screen/loading_screen.dart';
import 'package:aagilocano1/features/services/database.dart';
import 'package:achievement_view/achievement_view.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizList extends StatefulWidget {
  final User currentUser;
  final String uid;
  const QuizList({super.key, required this.currentUser, required this.uid});

  @override
  State<QuizList> createState() => _QuizListState();
}

class _QuizListState extends State<QuizList> {

  var questionIndex = 0;
  var totalScore = 0;
  late ConfettiController confettiControl;

  late Future<List<MultipleChoiceQuestion>> quizQuestions;

  @override
  void initState(){
    super.initState();
    quizQuestions = loadQuizFiles();
    confettiControl = ConfettiController(duration: const Duration(seconds: 10));
  }

  Future<List<MultipleChoiceQuestion>> loadQuizFiles() async{
    List<MultipleChoiceQuestion> loadedData = [];
    loadedData = await DatabaseService(uid: widget.uid).getUserMCQuestionList();
    return loadedData;
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: quizQuestions,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: ConfettiWidget(
                    confettiController: confettiControl,
                    blastDirection: pi / 2,
                    maxBlastForce: 5, // set a lower max blast force
                    minBlastForce: 2, // set a lower min blast force
                    emissionFrequency: 0.05,
                    numberOfParticles: 50, // a lot of particles at once
                    gravity: 1,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: ConfettiWidget(
                    confettiController: confettiControl,
                    blastDirection: pi / 2,
                    maxBlastForce: 5, // set a lower max blast force
                    minBlastForce: 2, // set a lower min blast force
                    emissionFrequency: 0.05,
                    numberOfParticles: 50, // a lot of particles at once
                    gravity: 1,
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: ConfettiWidget(
                    confettiController: confettiControl,
                    blastDirection: pi / 2,
                    maxBlastForce: 5, // set a lower max blast force
                    minBlastForce: 2, // set a lower min blast force
                    emissionFrequency: 0.05,
                    numberOfParticles: 50, // a lot of particles at once
                    gravity: 1,
                  ),
                ),
                Center(
                  child: startQuiz(snapshot.data!),
                ),
              ],
            ),
          );
        }else{
          return const DefaultLoadingScreen();
        }
      }
    );
  }

  startQuiz(List<MultipleChoiceQuestion> quizQuestions){
    if(questionIndex < 10){
      return showQuestion(quizQuestions[questionIndex]);
    }else{
      return FutureBuilder(
          future: showResults(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.hasData) {
              return snapshot.data;
            }

            return CircularProgressIndicator();
          });
    }
  }

  showQuestion(MultipleChoiceQuestion currentQuestion){
    return Align(
      alignment: AlignmentDirectional(0, 0),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container( //question text
              width: double.infinity,
              margin: const EdgeInsets.all(30),
              child: Column(
                children: [
                  Text(
                    "Q${questionIndex+1}:",
                    style: GoogleFonts.tinos(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                      currentQuestion.questionText,
                      style: GoogleFonts.tinos(fontSize: 30, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center
                  )
                ],
              ),
            ),
            listAnswers(currentQuestion)
          ],
        ),
      ),
    );
  }

  listAnswers(MultipleChoiceQuestion currentQuestion){
    return ListView.builder(
        itemCount: currentQuestion.answers.length,
        shrinkWrap: true,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 8),
            child: SizedBox(
              height: 60,
              child: ElevatedButton(
                  onPressed: ()=> answerQuestion(currentQuestion.answers[index]['score'], currentQuestion.questionText),
                  child: Text(
                      currentQuestion.answers[index]['answer'],
                      style: GoogleFonts.tinos(fontSize: 22, color: Colors.white),
                      textAlign: TextAlign.center
                  )
              ),
            ),
          );
        }
    );
  }

  answerQuestion(int score, String questionText) {
    totalScore += score;
    String right = "Correct!";
    Color tColor = Colors.green;
    String rightPhoto = "assets/photos/correct.png";
    int lweight = 1; //correct answer increases leitner weight value, else it decreases

    if(score!=10){
      right = "Incorrect";
      lweight = -1;
      tColor = Colors.red;
      rightPhoto = "assets/photos/wrong.jpg";
    }

    DatabaseService(uid: widget.uid).updateUserMCQuestion(questionText, lweight);

    String confirm = "Next question";
    if(questionIndex == 9) confirm = "Finish quiz";
    showDialog(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(
              title: Column(
                children: [
                  Padding(padding: EdgeInsets.symmetric(vertical: 10),
                    child:
                    CircleAvatar(
                      backgroundImage: AssetImage(
                         rightPhoto),

                      radius: 48.0,
                    ),
                  ),
                  Text(right, style: GoogleFonts.chivo(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
                      textAlign: TextAlign.center),
                ],
              ),
              // content: Text(right),
              backgroundColor: tColor,
              actions: [
                Align(
                  alignment: Alignment.center,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.yellow),
                    child: TextButton(
                        onPressed: ()=> {
                          Navigator.pop(context),
                          setState(() {
                            questionIndex += 1;
                          })
                        },
                        child: Text(confirm, style: GoogleFonts.tinos(fontWeight: FontWeight.bold, color: Colors.black),
                            textAlign: TextAlign.center)
                    ),
                  ),
                )
              ],
            )
    );


  }

  showResults() async {
    var achievement;

    var score = 0;
    Color scoreColor;
    if(totalScore > 0){
      score = totalScore~/10;
    }
    String resultMessage = '';
    if(score < 5) {
      resultMessage = "Try reviewing lessons in the Practice menu.";
      scoreColor = Color(0xffffb700);
      if(score == 0){
        scoreColor = Colors.red;
        achievement = await DatabaseService(uid: widget.uid).getUserAchievement("try_harder");
        if(!achievement['achieved']){
          DatabaseService(uid: widget.uid).updateUserAchievement("try_harder", true);
          showAchievementView(context, achievement['title'], achievement['description']);
        }
      }
    }else if(score == 10){
      scoreColor = Color(0xff2cba00);
      resultMessage = "Perfect!";
      confettiControl.play();
      achievement = await DatabaseService(uid: widget.uid).getUserAchievement("perfect");
      if(!achievement['achieved']){
        DatabaseService(uid: widget.uid).updateUserAchievement("perfect", true);
        showAchievementView(context, achievement['title'], achievement['description']);
      }
    }else{
      resultMessage = "Great Job!";
      scoreColor = Color(0xff96d700);
      if(score == 5) scoreColor = Color(0xfffff400);
      confettiControl.play();
      if(score == 8){
        achievement = await DatabaseService(uid: widget.uid).getUserAchievement("eight");
        if(!achievement['achieved']){
          DatabaseService(uid: widget.uid).updateUserAchievement("eight", true);
          showAchievementView(context, achievement['title'], achievement['description']);
        }
      }
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('$score/10', textAlign: TextAlign.center, style: GoogleFonts.tinos(fontSize: 78, fontWeight: FontWeight.bold, color: scoreColor, letterSpacing: 0)),
            ),
            Container(
              height: 16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: scoreColor),
                gradient: LinearGradient( //gradient for score
                  colors: [
                    Color(0xff2cba00),
                    Color(0xff96d700),
                    Color(0xffcbe600),
                    Color(0xfffff400),
                    Color(0xffffb700),
                    Color(0xffff7a00),
                    Colors.red,
                  ],
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: LinearProgressIndicator(
                  value: 1-(score / 10),
                  backgroundColor: Colors.white10,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(resultMessage, style: GoogleFonts.tinos(fontSize: 26, fontWeight: FontWeight.bold)),
            ),

          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                  onPressed: ()=>{
                    Navigator.popAndPushNamed(context, '/quiz_menu')
                  },
                  child: Text("Go back", style: GoogleFonts.tinos(fontWeight: FontWeight.bold),)),
            ),
          ),
        )
      ],
    );
  }

  void showAchievementView(BuildContext context, String title, String subTitle){
    AchievementView(
        title: title,
        subTitle: subTitle,
        icon: Icon(Icons.emoji_events_rounded, color: Color(0xffffd700),),
        color: Colors.blueGrey,
        alignment: Alignment.topCenter,
        duration: Duration(seconds: 5),
        //isCircle: false,
        listener: (status){
        }
    ).show(context);
  }
}
