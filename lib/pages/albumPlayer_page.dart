import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decibels/classes/FirestoreStorage.dart';
import 'package:decibels/pages/customList.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

AudioPlayer audioPlayer = new AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);

class AlbumPlayer extends StatelessWidget {
  final String albumName;
  final String userId;
  final String coverUrl;
  const AlbumPlayer(this.albumName, this.userId, this.coverUrl, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PlayerApp(albumName, userId, coverUrl),
    );
  }
}

class PlayerApp extends StatefulWidget {
  final String albumName;
  final String userId;
  final String coverUrl;
  PlayerApp(this.albumName, this.userId, this.coverUrl, {Key? key})
      : super(key: key);

  @override
  State<PlayerApp> createState() => PlayerAppState();
}

class PlayerAppState extends State<PlayerApp> {
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

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
        backgroundColor: const Color(0xff208AAE),
        title: Text(
          widget.albumName,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder(
        future: usersCollection
            .doc(widget.userId)
            .collection('albums')
            .doc(widget.albumName)
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.hasData) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: data['songs'].length,
                    itemBuilder: (BuildContext context, int index) {
                      String albumName = data['albumName'];
                      String fileName = data['songs'][index]['songUrl'];
                      String userPath =
                          'albums/${widget.userId}/$albumName/$fileName';

                      return FutureBuilder(
                        future: FirestoreStorage().getData(userPath),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return customListTitle(
                              onTap: () {
                                playMusic(snapshot.data.toString());

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
                                  currentTitle =
                                      data['songs'][index]['songName'];
                                  currentCover = widget.coverUrl;
                                  currentSinger = data['albumAuthor'];
                                });
                              },
                              title: data['songs'][index]['songName'],
                              singer: data['albumAuthor'],
                              cover: widget.coverUrl,
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                    },
                  ),
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
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14.0),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

void seekToSec(int sec) {
  Duration newPos = Duration(seconds: sec);
  audioPlayer.seek(newPos);
}
