import 'package:aagilocano1/Models/vocabulary.dart';
import 'package:aagilocano1/features/app/splash_screen/loading_screen.dart';
import 'package:aagilocano1/features/services/database.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            return DecoratedBox(
              decoration: BoxDecoration(
                  color: Color(0xfff6eee3)
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0,8,0,8),
                child: ListView.builder(
                    itemCount: userVocab.length,
                    itemBuilder: (context, index) {
                      // if(userVocab[index].learned) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0,8,0,8),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.black12))
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0,0,2,0),
                                    child: AutoSizeText(userVocab[index].ilocano,
                                      style: GoogleFonts.tinos(
                                          fontWeight: FontWeight.bold, fontSize: 18),
                                      maxLines: 2,),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(2,0,0,0),
                                    child: AutoSizeText(userVocab[index].english,
                                      style: GoogleFonts.tinos(
                                          fontWeight: FontWeight.bold, fontSize: 18),
                                      maxLines: 2,),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      // }else{
                      //   return const Row();
                      // }
                    }
                ),
              ),
            );
          }else{
            return const CircularProgressIndicator();
          }
        }
    );
  }
}
