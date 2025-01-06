import 'package:aagilocano1/Models/mc_question.dart';
import 'package:aagilocano1/features/app/splash_screen/loading_screen.dart';
import 'package:aagilocano1/features/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  bool shuffleIt = true;

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<List<MultipleChoiceQuestion>>(
        stream: DatabaseService(uid: widget.uid).mcQuizlist,
        builder: (context, snapshot){
          if(snapshot.hasData){
            List<MultipleChoiceQuestion> quizQuestions = snapshot.data!;
            // if(shuffleIt){
            //   quizQuestions.shuffle();
            //   shuffleIt = false;
            // }
            return Padding(
              padding: const EdgeInsets.all(30.0),
              child: startQuiz(quizQuestions)
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
      return showResults();
    }
  }

  showQuestion(MultipleChoiceQuestion currentQuestion){
    return Column(
      children: [
        Container( //question text
          width: double.infinity,
          margin: const EdgeInsets.all(10),
          child: Text(
            "Q"+ (questionIndex+1).toString() + ': ' + currentQuestion.questionText,
            style: const TextStyle(fontSize: 28),
            textAlign: TextAlign.center,
          ),
        ),
        listAnswers(currentQuestion)
      ],
    );
  }

  listAnswers(MultipleChoiceQuestion currentQuestion){
    return Expanded(
      child: ListView.builder(
          itemCount: currentQuestion.answers.length,
          itemBuilder: (context, index){
            return SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: ()=> answerQuestion(currentQuestion.answers[index]['score'], currentQuestion.questionText),
                  child: Text(currentQuestion.answers[index]['answer'])
              ),
            );
          }
      ),
    );
  }

  answerQuestion(int score, String questionText){
    totalScore += score;
    setState(() {
      questionIndex += 1;
    });

    if(score==10){ //correct answer increases leitner weight value, else it decreases

    }else{

    }
  }

  showResults(){
    var score = 0;
    if(totalScore > 0){
      score = totalScore~/10;
    }
    String resultMessage = '';
    if(score < 5) {
      resultMessage = "Try reviewing lessons in the Practice menu";
    }else if(score == 10){
      resultMessage = "Perfect!";
    }else{
      resultMessage = "Great Job!";
    }
    return Center(
      child: Column(
        children: [
          Text('Correct Answers: $score', style: const TextStyle(fontSize: 28)),
          const Divider(color: Colors.white),
          Text(resultMessage, style: const TextStyle(fontSize: 16)),
          const Divider(color: Colors.white),
          ElevatedButton(
              onPressed: ()=>{
                Navigator.popAndPushNamed(context, '/quiz_menu')
              },
              child: const Text("Go back")),
        ],
      ),
    );
  }
}
