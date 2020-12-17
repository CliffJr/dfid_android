import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dfidmobilen/model/values.dart';

// import './values.dart';

typedef PatientPressedCallback = void Function(String patientId);

typedef ClosePatientPressedCallback = void Function();

class Patient {
  final String id;
  final String fullName;
  final String ncdNumber;
  final String dfidStudyNumber;
  final String gender;
  final String dob;
  final String typeOfDiabetes;
  final String yearOfDmDiagnosis;
  final String dateReview;
  final String symptoms;
  final String diabetesTherapy;
  final String recentHba1c;
  final String dateHba1cTaken;
  final String visualAquityRight;
  final String visualAquityLeft;
  final String intraOcularPressureRight;
  final String intraOcularPressureLeft;
  final String other;
  final String rightEyeImage1;
  final String rightEyeImage2;
  final String leftEyeImage1;
  final String leftEyeImage2;
  final String dateImagesTaken;
  final String signsOfDiabeticRetinopathy;
  final String additionalComments;
  final String dateOfElectronicReferal;
  final DocumentReference reference;

  // ignore: unused_element
  Patient._(
      {this.fullName,
      this.ncdNumber,
      this.dfidStudyNumber,
      this.gender,
      this.dob,
      this.typeOfDiabetes,
      this.yearOfDmDiagnosis,
      this.dateReview,
      this.symptoms,
      this.diabetesTherapy,
      this.recentHba1c,
      this.dateHba1cTaken,
      this.visualAquityRight,
      this.visualAquityLeft,
      this.intraOcularPressureRight,
      this.intraOcularPressureLeft,
      this.other,
      this.rightEyeImage1,
      this.rightEyeImage2,
      this.leftEyeImage1,
      this.leftEyeImage2,
      this.dateImagesTaken,
      this.signsOfDiabeticRetinopathy,
      this.additionalComments,
      this.dateOfElectronicReferal})
      : id = null,
        reference = null;

  Patient.fromSnapshot(DocumentSnapshot snapshot)
      : assert(snapshot != null),
        id = snapshot.id,
        fullName = snapshot.data()['fullName'],
        ncdNumber = snapshot.data()['ncdNumber'],
        dfidStudyNumber = snapshot.data()['dfidStudyNumber'],
        gender = snapshot.data()['gender'],
        dob = snapshot.data()['dob'],
        typeOfDiabetes = snapshot.data()['typeOfDiabetes'],
        yearOfDmDiagnosis = snapshot.data()['yearOfDmDiagnosis'],
        dateReview = snapshot.data()['dateReview'],
        symptoms = snapshot.data()['symptoms'],
        diabetesTherapy = snapshot.data()['diabetesTherapy'],
        recentHba1c = snapshot.data()['recentHba1c'],
        dateHba1cTaken = snapshot.data()['dateHba1cTaken'],
        visualAquityRight = snapshot.data()['visualAquityRight'],
        visualAquityLeft = snapshot.data()['visualAquityLeft'],
        intraOcularPressureRight = snapshot.data()['intraOcularPressureRight'],
        intraOcularPressureLeft = snapshot.data()['intraOcularPressureLeft'],
        other = snapshot.data()['other'],
        rightEyeImage1 = snapshot.data()['rightEyeImage1'],
        rightEyeImage2 = snapshot.data()['rightEyeImage2'],
        leftEyeImage1 = snapshot.data()['leftEyeImage1'],
        leftEyeImage2 = snapshot.data()['leftEyeImage2'],
        dateImagesTaken = snapshot.data()['dateImagesTaken'],
        signsOfDiabeticRetinopathy =
            snapshot.data()['signsOfDiabeticRetinopathy'],
        additionalComments = snapshot.data()['additionalComments'],
        dateOfElectronicReferal = snapshot.data()['dateOfElectronicReferal'],
        reference = snapshot.reference;

  factory Patient.random() {
    return Patient._(
      fullName: getRandomCategory(),
      ncdNumber: getRandomCity(),
      dfidStudyNumber: getRandomName(),
      gender: getRandomCategory(),
      dob: getRandomCategory(),
      typeOfDiabetes: getRandomCategory(),
      yearOfDmDiagnosis: getRandomCity(),
      dateReview: getRandomName(),
      symptoms: getRandomCategory(),
      diabetesTherapy: getRandomCategory(),
      recentHba1c: getRandomCategory(),
      dateHba1cTaken: getRandomCity(),
      visualAquityRight: getRandomName(),
      visualAquityLeft: getRandomCategory(),
      intraOcularPressureRight: getRandomCategory(),
      intraOcularPressureLeft: getRandomCategory(),
      other: getRandomCity(),
      rightEyeImage1: getRandomPhoto(),
      rightEyeImage2: getRandomPhoto(),
      leftEyeImage1: getRandomPhoto(),
      leftEyeImage2: getRandomPhoto(),
      dateImagesTaken: getRandomCity(),
      signsOfDiabeticRetinopathy: getRandomName(),
      additionalComments: getRandomCategory(),
      dateOfElectronicReferal: getRandomCategory(),
    );
  }
}
