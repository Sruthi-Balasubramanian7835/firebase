import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase/readdelete.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _nameController = TextEditingController();
  final _placeController = TextEditingController();
  // ignore: unused_field
  // final _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
            ),
            TextField(
              controller: _placeController,
            ),
            // TextField(
            //   controller: _ageController,
            // ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_nameController.text.isEmpty ||
                    _placeController.text.isEmpty) {
                  debugPrint('empty feild');
                }
                await FirebaseFirestore.instance.collection('datas').add({
                  'name': _nameController.text,
                  'place': _placeController.text,
                  // 'age': _ageController.text
                }).then((value) => debugPrint('--------Success------------'));
              },
              child: const Text('Upload'),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('datas')
                    .get()
                    .then((snapshot) {
                  List<DocumentSnapshot> docList = snapshot.docs;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => ViewSreen(docs: docList,),
                    ),
                  );
                });
              },
              child: const Text('View'),
            ),
          ],
        ),
      ),
    );
  }
}