import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decibels/classes/DataController.dart';
import 'package:decibels/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class Busqueda extends StatefulWidget {
  Busqueda({Key? key}) : super(key: key);

  @override
  State<Busqueda> createState() => _BusquedaState();
}

class _BusquedaState extends State<Busqueda> {
  final TextEditingController BusquedaController = TextEditingController();
  late QuerySnapshot snapshotData;
  bool isExcecuted = false;
  @override
  Widget build(BuildContext context) {
    Widget searchedData() {
      return ListView.builder(
        itemCount: snapshotData.docs.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              String userId = snapshotData.docs[index].get('userId');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Perfil(userId),
                ),
              );
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  snapshotData.docs[index].get('photourl'),
                ),
              ),
              title: Text(
                snapshotData.docs[index].get('name'),
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 26.0),
              ),
              subtitle: Text(
                snapshotData.docs[index].get('email'),
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.clear),
          onPressed: () {
            setState(() {
              isExcecuted = false;
            });
          }),
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          GetBuilder<DataController>(
              init: DataController(),
              builder: (val) {
                return IconButton(
                  onPressed: () {
                    val.queryData(BusquedaController.text).then((value) {
                      snapshotData = value;
                      setState(() {
                        isExcecuted = true;
                      });
                    });
                  },
                  icon: Icon(Icons.search),
                );
              })
        ],
        title: TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              hintText: 'Buscar', hintStyle: TextStyle(color: Colors.white)),
          controller: BusquedaController,
        ),
        backgroundColor: Colors.black,
      ),
      body: isExcecuted
          ? searchedData()
          : Container(
              child: Center(
                child: Text(
                  'Buscas personas',
                  style: TextStyle(color: Colors.white, fontSize: 30.0),
                ),
              ),
            ),
    );
  }
}
