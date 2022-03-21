import 'package:audioplayers/audioplayers.dart';
import 'package:decibels/pages/customList.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

Future<void> downloadURLExample() async {
  String downloadURL = await firebase_storage.FirebaseStorage.instance
      .ref('intento/Nunca Es Suficiente.mp3')
      .getDownloadURL();
  print(downloadURL);
  // Within your widgets:
  // Image.network(downloadURL);
}

AudioPlayer audioPlayer = new AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);

class Biblioteca extends StatelessWidget {
  final String userId;
  Biblioteca(this.userId, {Key? key}) : super(key: key);

  static const String routeName = "/Biblioteca";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MusicApp(),
    );
  }
}

class MusicApp extends StatefulWidget {
  @override
  State<MusicApp> createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  List musicList = [
    {
      'title': "Nunca es suficiente",
      'singer': "Natalia Lafourcade",
      'url':
          "https://firebasestorage.googleapis.com/v0/b/decibels-3361d.appspot.com/o/intento%2FNunca%20Es%20Suficiente.mp3?alt=media&token=43d5c8a4-f1f5-4872-9939-a9a66c031a21",
      'coverUrl':
          "https://firebasestorage.googleapis.com/v0/b/decibels-3361d.appspot.com/o/intento%2Fnunca_es_suficiente.jpg?alt=media&token=406fb9aa-96a9-491c-8107-0fa888b82d04"
    },
    {
      'title': "La leyenda del hada y el mago",
      'singer': "Rata blanca",
      'url':
          "https://firebasestorage.googleapis.com/v0/b/decibels-3361d.appspot.com/o/intento%2Fla%20leyenda%20del%20hada%20y%20el%20mago.mp3?alt=media&token=df2bcdf9-59cc-4bfd-997d-e4142d46a444",
      'coverUrl':
          "https://firebasestorage.googleapis.com/v0/b/decibels-3361d.appspot.com/o/intento%2Frata_blamca.jpg?alt=media&token=3246e394-dceb-45c4-921e-7a95895f6d03"
    },
  ];

  String currentTitle = "";
  String currentCover = "";
  String currentSinger = "";
  IconData btnIcon = Icons.play_arrow;

  bool isPlaying = false;
  String currentSong = "";
  Duration duration = new Duration();
  Duration position = new Duration();

  void playMusic(String url) async {
    if (isPlaying && currentSong != url) {
      audioPlayer.pause();
      int result = await audioPlayer.play(url);
      if (result == 1) {
        setState(() {
          currentSong = url;
        });
      }
    } else if (!isPlaying) {
      int result = await audioPlayer.play(url);
      if (result == 1) {
        setState(() {
          isPlaying = true;
          btnIcon = Icons.play_arrow;
        });
      }
    }
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Biblioteca',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: musicList.length,
                itemBuilder: (context, index) => customListTitle(
                      onTap: () {
                        playMusic(musicList[index]['url']);

                        if (isPlaying) {
                          audioPlayer.pause();
                          setState(() {
                            btnIcon = Icons.pause;
                            isPlaying = false;
                          });
                        } else {
                          audioPlayer.resume();
                          setState(() {
                            btnIcon = Icons.play_arrow;
                            isPlaying = true;
                          });
                        }
                        setState(() {
                          currentTitle = musicList[index]['title'];
                          currentCover = musicList[index]['coverUrl'];
                          currentSinger = musicList[index]['singer'];
                        });
                      },
                      title: musicList[index]['title'],
                      singer: musicList[index]['singer'],
                      cover: musicList[index]['coverUrl'],
                    )),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Color(0x55212121),
                blurRadius: 8.0,
              ),
            ]),
            child: Column(
              children: [
                Slider.adaptive(
                  value: position.inSeconds.toDouble(),
                  min: 0.0,
                  max: duration.inSeconds.toDouble(),
                  onChanged: (value) {
                    seekToSec(value.toInt());
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 8.0, left: 12.0, right: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 60.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                                image: NetworkImage(currentCover))),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentTitle,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              currentSinger,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14.0),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  position.toString().split(".")[0],
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  duration.toString().split(".")[0],
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (isPlaying) {
                            audioPlayer.pause();
                            setState(() {
                              btnIcon = Icons.pause;
                              isPlaying = false;
                            });
                          } else {
                            audioPlayer.resume();
                            setState(() {
                              btnIcon = Icons.play_arrow;
                              isPlaying = true;
                            });
                          }
                        },
                        iconSize: 42.0,
                        icon: Icon(btnIcon),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void seekToSec(int sec) {
  Duration newPos = Duration(seconds: sec);
  audioPlayer.seek(newPos);
}
