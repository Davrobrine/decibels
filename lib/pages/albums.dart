import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decibels/classes/DataController.dart';
import 'package:decibels/pages/create_album.dart';
import 'package:decibels/pages/profile_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'customList.dart';
import 'generate_album.dart';

class Album extends StatefulWidget {
  Album({Key? key}) : super(key: key);

  @override
  State<Album> createState() => _AlbumState();
}

class _AlbumState extends State<Album> {
   List musicList = [
    {
      'albun': "Esto es un albun",
      'singer': "Creador o copositor",
      'coverUrl':
          "https://firebasestorage.googleapis.com/v0/b/decibels-3361d.appspot.com/o/intento%2Fnunca_es_suficiente.jpg?alt=media&token=406fb9aa-96a9-491c-8107-0fa888b82d04"
    },
    {
      'albun': "Otro albun",
      'singer': "otro compositor",
      'coverUrl':
          "https://firebasestorage.googleapis.com/v0/b/decibels-3361d.appspot.com/o/intento%2Frata_blamca.jpg?alt=media&token=3246e394-dceb-45c4-921e-7a95895f6d03"
    },
  ];
  final TextEditingController BusquedaController = TextEditingController();
  late QuerySnapshot snapshotData;
  bool isExcecuted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          foregroundColor: Colors.white,
        onPressed: () async {
           Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CrearAlbum(),
                    ),
                  );
        },
        label: const Text(
          'Generar Album',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.add_circle,
        ),
        elevation: 10,
      ),
        
         
      backgroundColor: Colors.blue,
      appBar: AppBar(
        
        backgroundColor: Colors.black,
         title: Text('Albums', 
        style: TextStyle(
          color: Color.fromARGB(255, 255, 255, 255)
        ),
      ), 
      ),
        body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: musicList.length,
              itemBuilder: (context, index) => customListTitle(
                onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GenerarAlbum(),
                  ),
                );
                },
                title: musicList[index]['albun'],
                singer: musicList[index]['singer'],
                cover: musicList[index]['coverUrl'],
                //añadir texto añadir canción 
              ),
              
            ),
          ),
        ],
      ),
    );
  }
}
