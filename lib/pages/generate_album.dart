import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decibels/classes/Storage.dart';
import 'package:decibels/pages/add_songs.dart';
import 'package:decibels/pages/settings_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'customList.dart';


class GenerarAlbum extends StatefulWidget {
  GenerarAlbum({Key? key}) : super(key: key);

  @override
  State<GenerarAlbum> createState() => _GenerarAlbumState();


}

class _GenerarAlbumState extends State<GenerarAlbum> {
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
                      builder: (context) => AnadirCanciones(),
                    ),
                  );
        },
        label: const Text(
          'Añadir Canciones',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.add,
        ),
        elevation: 10,
      ),
      backgroundColor: Colors.orange,
      appBar: AppBar(
        
        backgroundColor: Colors.green,
        title: Text('Agregar Canciones', 
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
                onTap: () {},
                title: musicList[index]['albun'],
                singer: musicList[index]['singer'],
                cover: musicList[index]['coverUrl'],
              ),
            ),
          ),
        ],
      ),
      
    );
  }
}

