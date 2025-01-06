import 'package:aagilocano1/Models/vocabulary.dart';
import 'package:aagilocano1/features/app/splash_screen/loading_screen.dart';
import 'package:aagilocano1/features/services/database.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VocabList extends StatefulWidget {
  final User currentUser;
  final String uid;
  const VocabList({super.key, required this.currentUser, required this.uid});

  @override
  State<VocabList> createState() => _VocabListState();
}

class _VocabListState extends State<VocabList> {

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<List<Vocabulary>>(
        stream: DatabaseService(uid: widget.uid).vocabulary,
        builder: (context, snapshot){
          if(snapshot.hasData){
            List<Vocabulary> userVocab = snapshot.data!;
            return ListView.builder(
                itemCount: userVocab.length,
                itemBuilder: (context, index) {
                  if(userVocab[index].learned) {
                    return Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: AutoSizeText(userVocab[index].ilocano,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              maxLines: 1,),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: AutoSizeText(userVocab[index].english,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              maxLines: 1,),
                          ),
                        )
                      ],
                    );
                  }else{
                    return const Row();
                  }
                }
            );
          }else{
            return const DefaultLoadingScreen();
          }
        }
    );
  }
}
