import 'package:cloud_firestore/cloud_firestore.dart';

import './filter.dart';
import './patient.dart';
import './review.dart';

Future<void> addPatient(Patient patient) {
  CollectionReference patients =
      FirebaseFirestore.instance.collection('patients');
  // final patients = FirebaseFirestore.instance.collection('patients');
  return patients
      .add({
        'fullName': patient.fullName,
        'ncdNumber': patient.ncdNumber,
        'dfidStudyNumber': patient.dfidStudyNumber,
        'gender': patient.gender,
        'dob': patient.dob,
        'typeOfDiabetes': patient.typeOfDiabetes,
        'yearOfDmDiagnosis': patient.yearOfDmDiagnosis,
        'dateReview': patient.dateReview,
        'symptoms': patient.symptoms,
        'diabetesTherapy': patient.diabetesTherapy,
        'recentHba1c': patient.recentHba1c,
        'dateHba1cTaken': patient.dateHba1cTaken,
        'visualAquityRight': patient.visualAquityRight,
        'visualAquityLeft': patient.visualAquityLeft,
        'intraOcularPressureRight': patient.intraOcularPressureRight,
        'intraOcularPressureLeft': patient.intraOcularPressureLeft,
        'other': patient.other,
        'rightEyeImage1': patient.rightEyeImage1,
        'rightEyeImage2': patient.rightEyeImage2,
        'leftEyeImage1': patient.leftEyeImage1,
        'leftEyeImage2': patient.leftEyeImage2,
        'dateImagesTaken': patient.dateImagesTaken,
        'signsOfDiabeticRetinopathy': patient.signsOfDiabeticRetinopathy,
        'additionalComments': patient.additionalComments,
        'dateOfElectronicReferal': patient.dateOfElectronicReferal,
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}

Stream<QuerySnapshot> loadAllPatients() {
  // ignore: todo
  // TODO: Complete the "Display data from Cloud Firestore" step.
  return Stream<QuerySnapshot>.value(null);
}

List<Patient> getPatientsFromQuery(QuerySnapshot snapshot) {
  // ignore: todo
  // TODO: Complete the "Display data from Cloud Firestore" step.
  return [];
}

Future<Patient> getPatient(String patientId) {
  // ignore: todo
  // TODO: Complete the "Get data" step.
  return Future.value(null);
}

Future<void> addReview({String patientId, Review review}) {
  // ignore: todo
  // TODO: Complete the "Write data in a transaction" step.
  return Future.value();
}

Stream<QuerySnapshot> loadFilteredPatients(Filter filter) {
  // ignore: todo
  // TODO: Complete the "Sorting and filtering data" step.
  return Stream<QuerySnapshot>.value(null);
}

void addPatientsBatch(List<Patient> patients) {
  patients.forEach((Patient patient) {
    addPatient(patient);
  });
}
