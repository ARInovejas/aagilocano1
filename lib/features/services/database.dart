import 'package:aagilocano1/Models/answer.dart';
import 'package:aagilocano1/Models/mc_question.dart';
import 'package:aagilocano1/Models/vocabulary.dart';
import 'package:aagilocano1/Models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Models/achievement.dart';


class AnswerDoc {
  late List<Answer> answers;
}

class DatabaseService{
  final String uid;
  DatabaseService({required this.uid});
  //collection of userInfo
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('userInfo');

  Future updateUserData(int level, int exp) async {

    return await userCollection.doc(uid).set({
      'level': level,
      'experience': exp
    });
  }

  Future deleteUserData() async{
    return await userCollection.doc(uid).delete();
  }
  //loads masterlist of dictionary collection of words and translations
  final CollectionReference dictionaryCollection = FirebaseFirestore.instance.collection('dictionary');

  //updates dictionary db (admin only)
  Future updateDictionary(String ilocano, String english, String type) async{
    return await dictionaryCollection.doc(ilocano).set({
      'ilocano': ilocano,
      'english': english,
      'type': type
    });

  }

  //creates a copy of dictionary for the new user, which acts as the vocabulary list
  Future createNewUserDictionary() async{
    dynamic snapshotData;
    String snapshotId;
    bool learned = false;
    return await dictionaryCollection.get().then(
            (querySnapshot) async {
              for(var docSnapshot in querySnapshot.docs){

                snapshotData = docSnapshot.data();
                snapshotId = docSnapshot.id;

                if(snapshotId == 'naimbag nga isasampet'){
                  learned = true;
                }else{
                  learned = false;
                }
                await addUserVocab(snapshotData, snapshotId);
                await updateUserVocab(snapshotId, learned);

              }

    }
    );
  }


  Future addUserVocab(dynamic data, String id) async {
    return await userCollection.doc(uid).collection('vocabulary').doc(id).set(data);
  }

  //updates if a new word is learned by the user
  Future updateUserVocab(String ilocano, bool learned) async{

    return await userCollection.doc(uid).collection('vocabulary').doc(ilocano).update({
      'ilocano': ilocano,
      'learned': learned
    }).then(
        (value) => print("Successfully updated"),
      onError: (e) => print(e)
    );
  }

  //gets all learned words by the user
  Future getUserVocab() async {
    dynamic res;
    await userCollection.doc(uid).collection('vocabulary').where('learned', isEqualTo: true).get().then(
          (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
        }
        res = querySnapshot.docs;
      },
      onError: (e) => print("Error completing: $e"),
    );
    return res;
  }

  //vocabulary list from snapshot
  List<Vocabulary> vocabListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Vocabulary(
          ilocano: doc.get('ilocano') ?? '',
          english: doc.get('english') ?? '',
          type: doc.get('type') ?? '',
          learned: doc.get('learned') ?? false);
    }).toList();
  }

  //user info from snapshot
  UserData userInfoFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      level: snapshot.get('level'),
      experience: snapshot.get('experience')
    );
  }

  //get user's vocabulary stream
  Stream<List<Vocabulary>> get vocabulary {
    return userCollection.doc(uid).collection('vocabulary').snapshots().map(
      vocabListFromSnapshot);
  }

  //get user data stream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(
        userInfoFromSnapshot);
  }


  //MULTIPLE CHOICE QUIZ

  final CollectionReference quizzesCollection = FirebaseFirestore.instance.collection('quizzes');
  final CollectionReference mcQuizzesCollection = FirebaseFirestore.instance.collection('quizzes').doc('multiple_choices').collection('mc_quizlist');
  //creates a copy of quizzes list for the new user
  Future createNewUserQuizList() async{
    dynamic snapshotData;
    String snapshotId;
    return await mcQuizzesCollection.get().then(
            (querySnapshot) async {
          for(var docSnapshot in querySnapshot.docs){

            snapshotData = docSnapshot.data();
            snapshotId = docSnapshot.id;

            await addUserMCQuestion(snapshotData, snapshotId);

          }

        }
    );
  }

  Future addUserMCQuestion(dynamic data, String id) async {
    return await userCollection.doc(uid).collection('mc_quizlist').doc(id).set(data);
  }

  //admin only
  Future adminUpdateMCQuestions(dynamic data, String id) async {
    return await mcQuizzesCollection.doc(id).set(data);
  }

  //updates the leitner weight, indicator of whether the user answered the question correctly or not
  Future updateUserMCQuestion(String id, int leitnerWeight) async{

    return await userCollection.doc(uid).collection('mc_quizlist').doc(id).update({
      'leitnerWeight': FieldValue.increment(leitnerWeight)
    }).then(
            (value) => print("Successfully updated"),
        onError: (e) => print(e)
    );
  }

  Future getUserMCQuestion() async {
    dynamic res;
    await userCollection.doc(uid).collection('mc_quizlist').get().then(
          (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
        }
        res = querySnapshot.docs;
      },
      onError: (e) => print("Error completing: $e"),
    );
    return res;
  }

  //multiple choice questions list from snapshot
  List<MultipleChoiceQuestion> mcQuestionsFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return MultipleChoiceQuestion(
          questionText: doc.get('questionText') ?? '',
          answers: doc.get('answers') ?? [],
          leitnerWeight: doc.get('leitnerWeight') ?? 0,
          lesson: doc.get('lesson') ?? 1);
    }).toList();
  }

  //get user's multiple choice questions stream
  Stream<List<MultipleChoiceQuestion>> get mcQuizlist {
    return userCollection.doc(uid).collection('mc_quizlist').orderBy('leitnerWeight').snapshots().map(
        mcQuestionsFromSnapshot);
  }


  //ACHIEVEMENTS
  final CollectionReference achievementsCollection = FirebaseFirestore.instance.collection('achievements');
  //creates a copy of achievements list for the new user
  Future createNewUserAchievementsList() async{
    dynamic snapshotData;
    String snapshotId;
    return await achievementsCollection.get().then(
            (querySnapshot) async {
          for(var docSnapshot in querySnapshot.docs){

            snapshotData = docSnapshot.data();
            snapshotId = docSnapshot.id;

            await addUserAchievement(snapshotData, snapshotId);

          }

        }
    );
  }


  Future addUserAchievement(dynamic data, String id) async {
    return await userCollection.doc(uid).collection('achievements').doc(id).set(data);
  }

  //updates if the user gets an achievement
  Future updateUserAchievement(String id, bool achieved) async{

    return await userCollection.doc(uid).collection('achievements').doc(id).update({
      'achieved': achieved
    }).then(
            (value) => print("Successfully updated"),
        onError: (e) => print(e)
    );
  }

  Future getUserAchievements() async {
    dynamic res;
    await userCollection.doc(uid).collection('achievements').get().then(
          (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
        }
        res = querySnapshot.docs;
      },
      onError: (e) => print("Error completing: $e"),
    );
    return res;
  }

  //achievements list from snapshot
  List<Achievement> achievementsFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Achievement(
          description: doc.get('description') ?? '',
          achieved: doc.get('achieved') ?? false);
    }).toList();
  }

  //get user's multiple choice questions stream
  Stream<List<Achievement>> get achievement {
    return userCollection.doc(uid).collection('achievements').snapshots().map(
        achievementsFromSnapshot);
  }



  //STORIES
  final CollectionReference storiesCollection = FirebaseFirestore.instance.collection('stories');
  //creates a copy of achievements list for the new user
  Future createNewUserStoriesList() async{
    dynamic snapshotData;
    String snapshotId;
    return await storiesCollection.get().then(
            (querySnapshot) async {
          for(var docSnapshot in querySnapshot.docs){

            snapshotData = docSnapshot.data();
            snapshotId = docSnapshot.id;

            await addUserStories(snapshotData, snapshotId);

          }

        }
    );
  }

  Future addUserStories(dynamic data, String id) async {
    return await userCollection.doc(uid).collection('stories').doc(id).set(data);
  }

  //admin only
  Future adminAddStories(dynamic data, String id) async {
    return await storiesCollection.doc(id).set(data);
  }
}

