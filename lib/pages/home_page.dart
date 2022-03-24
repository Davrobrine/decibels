import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decibels/classes/DataController.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    CollectionReference newsCollection =
        FirebaseFirestore.instance.collection('news');

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
                          Text(
                            'Más Popular',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                            ),
                          ),
                          Text(
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
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
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
                    child: GetBuilder<DataController>(
                      init: DataController(),
                      builder: (value) {
                        return FutureBuilder(
                          future: value.getData('users'),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                  child: CircularProgressIndicator(
                                      backgroundColor: Colors.black));
                            } else {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 150,
                                            width: 150,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.contain,
                                                    image: NetworkImage(
                                                        data['photourl']))),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Container(
                                              constraints:
                                                  BoxConstraints(maxWidth: 150),
                                              child: Text(
                                                data['email'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20.0),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              data['name'],
                                              style: TextStyle(
                                                  color: Colors.grey.shade600,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          Row(
                                            children: [
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
                                              Text(
                                                data['name'],
                                                style: TextStyle(
                                                    color: Colors.grey.shade600,
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 90,
                      width: 450,
                      color: Colors.blue,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Aqui es la radio',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
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
