import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopro/components/plan.dart';

class ChunkService {
  static Future<List<PlanningApplication>> getPlansInChunk(
      String chunkId) async {
    List<PlanningApplication> planningApplications = [];

    var chunkRef = FirebaseFirestore.instance.collection('chunks').doc(chunkId);

    var planningAppsRef = chunkRef.collection('planning_applications');

    var snapshot = await planningAppsRef.get();
    for (var doc in snapshot.docs) {
      planningApplications.add(PlanningApplication(
          address: doc.data()["address"],
          reference: doc.data()["reference"],
          status: doc.data()["status"],
          dataReceived: doc.data()["date_received"],
          proposal: doc.data()["proposal"]));
    }

    return planningApplications;
  }
}
