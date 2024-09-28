import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopro/service/chunk_service.dart';
import 'package:demopro/service/location_service.dart';
import 'package:flutter/material.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  Future<String> getLocationChunk() async {
    var location = await LocationService.findLocation();

    String aStr = location.latitude!
        .abs()
        .toStringAsFixed(5)
        .split('.')[1]
        .substring(0, 4);
    String bStr = location.longitude!
        .abs()
        .toStringAsFixed(5)
        .split('.')[1]
        .substring(0, 4);

    return aStr + bStr;
  }

  Future<void> getPlan(String chunkId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Reference to the specific document
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await firestore
        .collection('planning_applications')
        .doc('3803-3761')
        .get();

    print(documentSnapshot.data()!["address"]);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: ChunkService.getPlansInChunk("37533796"),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          return ListView(
            children: [
              Column(
                children: [...snapshot.data!],
              )
            ],
          );
        },
      ),
    );
  }
}
