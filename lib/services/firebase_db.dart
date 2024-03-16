// This file contains the code for the database service for the events collection
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vega/models/company.dart';
import 'package:vega/models/myevents.dart';

const String COLLECTION_REF_EVENTS = 'events';
const String COLLECTION_REF_COMPANY = 'company';

class DBservEvents {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _eventsRef;

  DBservEvents() {
    _eventsRef = _firestore
        .collection(COLLECTION_REF_EVENTS)
        .withConverter<myEvents>(
            fromFirestore: (snapshot, _) => myEvents.fromJson(snapshot.data()!),
            toFirestore: (myEvents, _) => myEvents.toJson());
  }

  Stream<QuerySnapshot> getEvents() {
    return _eventsRef.snapshots();
  }

  void addEvent(myEvents event) async {
    _eventsRef.add(event);
  }
}

class DBcompany {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _eventsRef;

  DBcompany() {
    _eventsRef = _firestore
        .collection(COLLECTION_REF_COMPANY)
        .withConverter<Company>(
            fromFirestore: (snapshot, _) => Company.fromJson(snapshot.data()!),
            toFirestore: (Company, _) => Company.toJson());
  }

  Stream<QuerySnapshot> getCompany() {
    return _eventsRef.snapshots();
  }

  void addCompany(Company company) async {
    _eventsRef.add(company);
  }
}
