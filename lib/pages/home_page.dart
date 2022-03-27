import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decibels/classes/DataController.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  final String userId;
  final CollectionReference newsCollection;
  HomePage(this.userId, this.newsCollection, {Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _newsCollection =
        FirebaseFirestore.instance.collection('news').snapshots();

    return FutureBuilder<DocumentSnapshot>(
      future: widget.newsCollection.doc(widget.userId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            backgroundColor: Colors.black,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 140.0,
                      width: 450.0,
                      color: const Color(0xff902D41),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/head.png'),
                          const Text(
                            'Más Popular',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                            ),
                          ),
                          const Text(
                            'Hoy',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Canciones',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    width: 400,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _newsCollection,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("Loading");
                        }

                        return ListView(
                          scrollDirection: Axis.horizontal,
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> newsData =
                                document.data()! as Map<String, dynamic>;
                            return Container(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.contain,
                                              image: NetworkImage(
                                                  newsData['imgurl']))),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Container(
                                        constraints:
                                            const BoxConstraints(maxWidth: 150),
                                        child: Text(
                                          newsData['title'],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: Text(
                                        newsData['author'],
                                        style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 15),
                                      ),
                                    ),
                                    Row(
                                      children: const [
                                        Icon(
                                          EvaIcons.star,
                                          color: Colors.yellowAccent,
                                        ),
                                        Icon(
                                          EvaIcons.star,
                                          color: Colors.yellowAccent,
                                        ),
                                        Icon(
                                          EvaIcons.star,
                                          color: Colors.yellowAccent,
                                        ),
                                        Icon(
                                          EvaIcons.star,
                                          color: Colors.yellowAccent,
                                        ),
                                        Icon(
                                          EvaIcons.star,
                                          color: Colors.yellowAccent,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: 90,
                        width: 450,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xff902d41),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                'Nuestra radio en vivo',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      launch('https://toluvaradio.000webhostapp.com/');
                    },
                  )
                ],
              ),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
