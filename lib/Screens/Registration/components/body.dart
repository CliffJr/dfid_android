import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dfidmobilen/Screens/Registration/components/background.dart';
import 'package:dfidmobilen/components/rounded_button.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:dfidmobilen/Screens/Records/patientlist.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';

import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dfidmobilen/Screens/Registration/newpatient.dart';

import 'package:flutter/material.dart';
import 'package:dfidmobilen/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_select/smart_select.dart';

class Body extends StatefulWidget {
  Body({Key key, this.title}) : super(key: key);
  final String title;

  @override
  BodyState createState() => new BodyState();
}

class BodyState extends State<Body> with TickerProviderStateMixin {
  String fullName;
  String ncdNumber;
  String dfidStudyNumber;
  String gender;
  DateTime dob;
  String typeOfDiabetes;
  String yearOfDmDiagnosis;
  DateTime dateReview;
  String symptoms;
  String diabetesTherapy;
  String recentHba1c;
  DateTime dateHba1cTaken;
  String visualAquityRight;
  String visualAquityLeft;
  String intraOcularPressureRight;
  String intraOcularPressureLeft;
  String other = "";
  String leftEyeImage1;
  String leftEyeImage2;
  String rightEyeImage1;
  String rightEyeImage2;
  DateTime dateImagesTaken;
  String signsOfDiabeticRetinopathy;
  String additionalComments;
  DateTime dateOfElectronicReferal;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final myController = TextEditingController();

  final scaffoldKey = new GlobalKey<ScaffoldState>();

  final _formKey = new GlobalKey<FormState>();

  String dropdownValue = 'Female';

  TabController _tabController;

  DateTime selectedDate;

  String value = 'null';

  final format = DateFormat("dd-MM-yyyy");

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    selectedDate = DateTime.now();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  sendToServer() {
    _formKey.currentState.save();

    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference =
          FirebaseFirestore.instance.collection('patients');

      await reference.add({
        "fullName": "$fullName",
        "ncdNumber": "$ncdNumber",
        "dfidStudyNumber": "$dfidStudyNumber",
        "gender": "$gender",
        "dob": "$dob",
        "typeOfDiabetes": "$typeOfDiabetes",
        "yearOfDmDiagnosis": "$yearOfDmDiagnosis",
        "dateReview": "$dateReview",
        "symptoms": "$symptoms",
        "diabetesTherapy": "$diabetesTherapy",
        "recentHba1c": "$recentHba1c",
        "dateHba1cTaken": "$dateHba1cTaken",
        "visualAquityRight": "$visualAquityRight",
        "visualAquityLeft": "$visualAquityLeft",
        "intraOcularPressureRight": "$intraOcularPressureRight",
        "intraOcularPressureLeft": "$intraOcularPressureLeft",
        "other": "$other",
        "leftEyeImage1": "$leftEyeImage1",
        "leftEyeImage2": "$leftEyeImage2",
        "rightEyeImage1": "$rightEyeImage1",
        "rightEyeImage2": "$rightEyeImage2",
        "dateImagesTaken": "$dateImagesTaken",
        "signsOfDiabeticRetinopathy": "$signsOfDiabeticRetinopathy",
        "additionalComments": "$additionalComments",
        "dateOfElectronicReferal": "$dateOfElectronicReferal",
      }).then((value) {
        print(value.id);
      });
      FirebaseFirestore.instance
          .collection('patients')
          .doc(value)
          .collection('review')
          .add({
        "nonProliferativeDiabeticRetinopathyRight":
            "$nonProliferativeDiabeticRetinopathyRight",
        "nonProliferativeDiabeticRetinopathyLeft":
            "$nonProliferativeDiabeticRetinopathyLeft",
        "proliferativeDiabeticRetinopathyRight":
            "$proliferativeDiabeticRetinopathyRight",
        "proliferativeDiabeticRetinopathyLeft":
            "$proliferativeDiabeticRetinopathyLeft",
        "additionalSuspectedEyePathologiesRight":
            "$additionalSuspectedEyePathologiesRight",
        "additionalSuspectedEyePathologiesLeft":
            "$additionalSuspectedEyePathologiesLeft",
        "diagnosis": "$diagnosis",
        "recommendedManagement": "$recommendedManagement",
        "repeatFundascopy": "$repeatFundascopy",
        "referralToConsult": "$referralToConsult",
      });
    });
  }

  String nonProliferativeDiabeticRetinopathyRight;
  String nonProliferativeDiabeticRetinopathyLeft;
  String proliferativeDiabeticRetinopathyRight;
  String proliferativeDiabeticRetinopathyLeft;
  String additionalSuspectedEyePathologiesRight;
  String additionalSuspectedEyePathologiesLeft;
  String diagnosis;
  String recommendedManagement;
  String repeatFundascopy;
  String referralToConsult;

  List<S2Choice<String>> selectGender = [
    S2Choice<String>(value: 'Male', title: 'Male'),
    S2Choice<String>(value: 'Female', title: 'Female'),
  ];

  List<S2Choice<String>> optionYesNo = [
    S2Choice<String>(value: 'Yes', title: 'Yes'),
    S2Choice<String>(value: 'No', title: 'No'),
  ];

  List<S2Choice<String>> optionTypeDiabetes = [
    S2Choice<String>(value: 'DM 1', title: 'DM 1'),
    S2Choice<String>(value: 'DM 2', title: 'DM 2'),
    S2Choice<String>(value: 'Gestational', title: 'Gestational'),
  ];

  List<S2Choice<String>> optionsDiabetesTherapy = [
    S2Choice<String>(value: 'oral medication', title: 'oral medication'),
    S2Choice<String>(value: 'injectables', title: 'injectables'),
    S2Choice<String>(value: 'Diet', title: 'Diet'),
    S2Choice<String>(value: 'None', title: 'None'),
  ];

  List<S2Choice<String>> optionsIntraOcularPressure = [
    S2Choice<String>(value: 'mmHg', title: 'mmHg'),
    S2Choice<String>(value: 'Not Done', title: 'Not Done'),
  ];

  List<S2Choice<String>> optionsSignsDR = [
    S2Choice<String>(value: 'Yes', title: 'Yes'),
    S2Choice<String>(value: 'No', title: 'No'),
    S2Choice<String>(value: 'Dont Know', title: 'Dont Know'),
  ];

  List<S2Choice<String>> optionsSymptoms = [
    S2Choice<String>(value: 'Blurred vision', title: 'Blurred vision'),
    S2Choice<String>(
        value: 'Change of spectacles', title: 'Change of spectacles'),
    S2Choice<String>(
        value: 'Dark empty areas in your vision',
        title: 'Dark empty areas in your vision'),
    S2Choice<String>(value: 'Discharge', title: 'Discharge'),
    S2Choice<String>(value: 'Dryness of eyes', title: 'Dryness of eyes'),
    S2Choice<String>(value: 'Flashes of light', title: 'Flashes of light'),
    S2Choice<String>(value: 'Floaters', title: 'Floaters'),
    S2Choice<String>(value: 'Fluctuating vision', title: 'Fluctuating vision'),
    S2Choice<String>(
        value: 'Impaired color vision', title: 'Impaired color vision'),
    S2Choice<String>(value: 'Itchiness', title: 'Itchiness'),
    S2Choice<String>(value: 'Pain', title: 'Pain'),
    S2Choice<String>(value: 'Poor vision', title: 'Poor vision'),
    S2Choice<String>(value: 'Redness', title: 'Redness'),
    S2Choice<String>(value: 'Stys', title: 'Stys'),
  ];

  List<S2Choice<String>> optionsVisualAquity = [
    S2Choice<String>(value: '6/6', title: '6/6'),
    S2Choice<String>(value: '6/9', title: '6/9'),
    S2Choice<String>(value: '6/12', title: '6/12'),
    S2Choice<String>(value: '6/18', title: '6/18'),
    S2Choice<String>(value: '6/24', title: '6/24'),
    S2Choice<String>(value: '6/36', title: '6/36'),
    S2Choice<String>(value: '6/60', title: '6/60'),
    S2Choice<String>(value: '5/60', title: '5/60'),
    S2Choice<String>(value: 'Light Perception', title: 'Light Perception'),
    S2Choice<String>(
        value: 'No Light Perception', title: 'No Light Perception'),
    S2Choice<String>(value: 'Not Done', title: 'Not Done'),
  ];

  DateTime dates;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MaterialApp(
        home: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              title: new Text('Register New Patient'),
              bottom: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(icon: Icon(Icons.person_add), text: 'Patient Details'),
                  Tab(icon: Icon(Icons.note_add), text: 'Referal Notes'),
                  Tab(icon: Icon(Icons.insert_photo), text: 'Image Transfer'),
                ],
              ),
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: SvgPicture.asset(
                      "assets/images/solidarmedlogo.svg",
                      height: size.height * 0.35,
                      color: Colors.red,
                    ),
                    decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.dashboard),
                    title: Text('Dashboard'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.person_add),
                    title: Text('New Patient'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new NewPatient()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.people),
                    title: Text('Patient Records'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new PatientList()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.verified_user),
                    title: Text('User Profile'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('SignOut'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            body: Form(
              key: _formKey,
              child: DefaultTabController(
                length: 3,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    //first form
                    Background(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(30.0),
                        child: Column(
                          children: [
                            TextFormField(
                                keyboardType: TextInputType.text,
                                decoration:
                                    InputDecoration(labelText: 'FULL NAME '),
                                validator: (val) =>
                                    val.length == 0 ? "Field required" : null,
                                onChanged: (final val) {
                                  setState(() {
                                    fullName = val;
                                  });
                                }),
                            TextFormField(
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    labelText: 'PATIENT NCD NUMBER'),
                                validator: (val) =>
                                    val.length == 0 ? 'Field required' : null,
                                onChanged: (final val) {
                                  setState(() {
                                    ncdNumber = val;
                                  });
                                }),
                            TextFormField(
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    labelText: 'PATIENT DFID STUDY NUMBER'),
                                validator: (val) =>
                                    val.length == 0 ? 'Field required' : null,
                                onChanged: (final val) {
                                  setState(() {
                                    dfidStudyNumber = val;
                                  });
                                }),
                            DateTimeField(
                              decoration: InputDecoration(
                                  labelText: 'DATE OF BIRTH',
                                  icon: Icon(Icons.date_range_outlined)),
                              format: format,
                              onShowPicker: (context, selectedDate) async {
                                dates = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    initialDate: selectedDate ?? DateTime.now(),
                                    lastDate: DateTime(2100));

                                return dates;
                              },
                              onChanged: (dates) {
                                setState(() {
                                  dob = dates;
                                });
                              },
                            ),
                            SmartSelect<String>.single(
                                title: 'GENDER',
                                value: value,
                                choiceItems: selectGender,
                                onChange: (state) => setState(() {
                                      value = state.value;
                                      gender = value;
                                    })),
                            SmartSelect<String>.single(
                                title: 'TYPE OF DIABETES',
                                value: value,
                                choiceItems: optionTypeDiabetes,
                                onChange: (state) => setState(() {
                                      value = state.value;
                                      typeOfDiabetes = value;
                                    })),
                            TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: 'YEAR OF DM DIAGNOSIS',
                                    icon: Icon(Icons.date_range_outlined)),
                                validator: (val) => val.length < 4
                                    ? 'Year has four intergers required'
                                    : null,
                                onChanged: (final val) {
                                  setState(() {
                                    yearOfDmDiagnosis = val;
                                  });
                                }),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                            ),
                            RoundedButton(
                                text: "(1 of 3): NEXT",
                                color: kPrimaryColor,
                                press: () {
                                  _tabController
                                      .animateTo((_tabController.index + 1));

                                  // _showProgress();
                                }),
                          ],
                        ),
                      ),
                    ),
                    //second form
                    Background(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(30.0),
                        child: Column(
                          children: [
                            DateTimeField(
                              decoration: InputDecoration(
                                  labelText: 'DATE REVIEW',
                                  icon: Icon(Icons.date_range_outlined)),
                              format: format,
                              onShowPicker: (context, selectedDate) async {
                                dates = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    initialDate: selectedDate ?? DateTime.now(),
                                    lastDate: DateTime(2100));

                                return dates;
                              },
                              onChanged: (dates) {
                                setState(() {
                                  dateReview = dates;
                                });
                              },
                            ),
                            DateTimeField(
                              decoration: InputDecoration(
                                  labelText: 'DATE HBA1C TAKEN',
                                  icon: Icon(Icons.date_range_outlined)),
                              format: format,
                              onShowPicker: (context, selectedDate) async {
                                dates = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    initialDate: selectedDate ?? DateTime.now(),
                                    lastDate: DateTime(2100));

                                return dates;
                              },
                              onChanged: (dates) {
                                setState(() {
                                  dateHba1cTaken = dates;
                                });
                              },
                            ),
                            TextFormField(
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    labelText: 'MOST RECENT HBA1C'),
                                validator: (val) =>
                                    val.length == 0 ? 'Field required' : null,
                                onChanged: (final val) {
                                  setState(() {
                                    recentHba1c = val;
                                  });
                                }),
                            SmartSelect<String>.single(
                                title: 'SYMPTOMS',
                                value: value,
                                choiceItems: optionsSymptoms,
                                onChange: (state) => setState(() {
                                      value = state.value;
                                      symptoms = value;
                                    })),
                            SmartSelect<String>.single(
                                title: 'DIABETES THERAPY',
                                value: value,
                                choiceItems: optionsDiabetesTherapy,
                                onChange: (state) => setState(() {
                                      value = state.value;
                                      diabetesTherapy = value;
                                    })),
                            SmartSelect<String>.single(
                                title: 'VISUAL AQUITY RIGHT',
                                value: value,
                                choiceItems: optionYesNo,
                                onChange: (state) => setState(() {
                                      value = state.value;
                                      visualAquityRight = value;
                                    })),
                            SmartSelect<String>.single(
                                title: 'VISUAL AQUITY LEFT',
                                value: value,
                                choiceItems: optionYesNo,
                                onChange: (state) => setState(() {
                                      value = state.value;
                                      visualAquityLeft = value;
                                    })),
                            SmartSelect<String>.single(
                                title: 'INTRA OCULAR PRESSURE RIGHT',
                                value: value,
                                choiceItems: optionYesNo,
                                onChange: (state) => setState(() {
                                      value = state.value;
                                      intraOcularPressureRight = value;
                                    })),
                            SmartSelect<String>.single(
                                title: 'INTRA OCULAR PRESSURE LEFT',
                                value: value,
                                choiceItems: optionYesNo,
                                onChange: (state) => setState(() {
                                      value = state.value;
                                      intraOcularPressureLeft = value;
                                    })),
                            TextFormField(
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: 'OTHER',
                                ),
                                validator: (val) =>
                                    val.length == 0 ? 'Field required' : null,
                                onChanged: (final val) {
                                  setState(() {
                                    other = val;
                                  });
                                }),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                            ),
                            RoundedButton(
                                text: "(2 of 3): NEXT",
                                color: kPrimaryColor,
                                press: () {
                                  _tabController
                                      .animateTo((_tabController.index + 1));
                                }),
                          ],
                        ),
                      ),
                    ),
                    //third form
                    Background(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(30.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: FlatButton(
                                        padding: EdgeInsets.all(40.0),
                                        color: Colors.redAccent,
                                        onPressed: () {
                                          uploadFile();
                                          leftEyeImage1 = downloadURL;
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Icon(
                                              Icons.image,
                                              size: 40.0,
                                              color: Colors.black38,
                                            ),
                                            Text(
                                              '\n Left Eye Image 1 \n \n ',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: FlatButton(
                                        padding: EdgeInsets.all(40.0),
                                        color: Colors.redAccent,
                                        onPressed: () {
                                          uploadFile();
                                          leftEyeImage2 = downloadURL;
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Icon(
                                              Icons.image,
                                              size: 40.0,
                                              color: Colors.black38,
                                            ),
                                            Text(
                                              '\n Left Eye Image 2 \n \n',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: FlatButton(
                                        padding: EdgeInsets.all(40.0),
                                        color: Colors.redAccent,
                                        onPressed: () {
                                          uploadFile();
                                          rightEyeImage1 = downloadURL;
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Icon(
                                              Icons.image,
                                              size: 40.0,
                                              color: Colors.black38,
                                            ),
                                            Text(
                                              '\n Right Eye Image 1 \n \n ',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: FlatButton(
                                        padding: EdgeInsets.all(40.0),
                                        color: Colors.redAccent,
                                        onPressed: () {
                                          uploadFile();

                                          setState(() {
                                            rightEyeImage2 = downloadURL;
                                          });
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Icon(
                                              Icons.image,
                                              size: 40.0,
                                              color: Colors.black38,
                                            ),
                                            Text(
                                              '\n Right Eye Image 2 \n \n ',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                            ),
                            Divider(
                              thickness: 20,
                            ),
                            DateTimeField(
                              decoration: InputDecoration(
                                  labelText: 'DATE IMAGES TAKEN',
                                  icon: Icon(Icons.date_range_outlined)),
                              format: format,
                              onShowPicker: (context, selectedDate) async {
                                dates = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    initialDate: selectedDate ?? DateTime.now(),
                                    lastDate: DateTime(2100));

                                return dates;
                              },
                              onChanged: (dates) {
                                setState(() {
                                  dateImagesTaken = dates;
                                });
                              },
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  labelText: 'SIGNS OF DIABETIC RETINOPATHY'),
                              validator: (val) =>
                                  val.length == 0 ? 'Field required' : null,
                              onSaved: (val) =>
                                  signsOfDiabeticRetinopathy = val,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  labelText: 'ADDITIONAL COMMENTS'),
                              validator: (val) =>
                                  val.length == 0 ? 'Field required' : null,
                              onSaved: (val) => additionalComments = val,
                            ),
                            DateTimeField(
                              decoration: InputDecoration(
                                  labelText: 'DATE OF ELECTRONIC REFERAL',
                                  icon: Icon(Icons.date_range_outlined)),
                              format: format,
                              onShowPicker: (context, selectedDate) async {
                                dates = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    initialDate: selectedDate ?? DateTime.now(),
                                    lastDate: DateTime(2100));

                                return dates;
                              },
                              onChanged: (dates) {
                                setState(() {
                                  dateOfElectronicReferal = dates;
                                });
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                            ),
                            RoundedButton(
                                text: "(3 of 3): SUBMIT",
                                press: () {
                                  sendToServer();

                                  if (downloadURL != null) {
                                    _showMyDialog();
                                  } else {
                                    return AlertDialog(
                                      title: Text(
                                          ' ERROR PLEASE SELECT ALL FOUR(4) EYE IMAGES!!!'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('Exit'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  }
                                }),
                            Text('$fullName '),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }

  void navigateToPatientList() {
    Navigator.pushNamed(context, "/mypatientlist");
  }

  final picker = ImagePicker();

  Future<void> uploadFile() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    String filePath = pickedFile.path;
    File file = File(filePath);

    firebase_storage.Reference ref;

    try {
      ref = firebase_storage.FirebaseStorage.instance
          .ref('uploads/${DateTime.now()}.png');
      await ref.putFile(file);

      _downloadURLExample(ref);
      // ignore: unused_catch_clause
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print('Cannot upload');
    }
  }

  String downloadURL;
  Future<void> _downloadURLExample(ref) async {
    downloadURL = await ref.getDownloadURL();
    // Within your widgets:
  }

  _showMyDialog() {
    return showDialog(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Patient Successfully Saved!'),
          actions: <Widget>[
            TextButton(
              child: Text('PROCEED'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // _showProgress() {
  //   return showDialog(
  //       context: context,
  //       barrierDismissible: true, // user must tap button!
  //       builder: (BuildContext context) {
  //         return Expanded(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: <Widget>[
  //               CircularStepProgressIndicator(
  //                 totalSteps: 100,
  //                 currentStep: 5,
  //                 stepSize: 5,
  //                 selectedColor: Colors.blueAccent,
  //                 unselectedColor: Colors.grey[100],
  //                 width: 200,
  //                 height: 200,
  //                 padding: 0,
  //                 selectedStepSize: 10.0,
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }

//end
}
