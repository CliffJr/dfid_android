import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dfidmobilen/Screens/Review/components/background.dart';
import 'package:dfidmobilen/Screens/Review/review.dart';
import 'package:dfidmobilen/components/rounded_button.dart';
import 'package:dfidmobilen/components/rounded_input_field.dart';

import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  @override
  BodyState createState() {
    return BodyState();
  }
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

//doctor
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

  //display
  String rfullName;
  String rdateImagesTaken;
  String rsymptoms;
  String rother;
  String rtypeOfDiabetes;
  String rdiabetesTherapy;
  String rleftEyeImage1;
  String rleftEyeImage2;
  String rrightEyeImage1;
  String rrightEyeImage2;

  final _formKey = new GlobalKey<FormState>();

  TabController _tabController;

  DateTime selectedDate;

  final format = DateFormat("dd-MM-yyyy");

  DateTime dates;

  String value = 'null';

  List<S2Choice<String>> optionsSIGNSOFDIABETICRETINOPATHY = [
    S2Choice<String>(value: 'Yes', title: 'Yes'),
    S2Choice<String>(value: 'No', title: 'No'),
    S2Choice<String>(value: 'Not able to assess', title: 'Not able to assess'),
  ];

  List<S2Choice<String>> optionsNONPROLIFERATIVEDIABETICRETINOPATHY = [
    S2Choice<String>(value: 'Mild', title: 'Mild'),
    S2Choice<String>(value: 'Moderate', title: 'Moderate'),
    S2Choice<String>(value: 'Severe', title: 'Severe'),
    S2Choice<String>(value: 'Not able to access', title: 'Not able to access'),
  ];

  List<S2Choice<String>> optionsADDITIONALSUSPECTEDEYEPATHOLOGIES = [
    S2Choice<String>(
        value: 'Age related macular edema (ARMD)',
        title: 'Age related macular edema (ARMD)'),
    S2Choice<String>(value: 'Amblyopia', title: 'Amblyopia'),
    S2Choice<String>(value: 'Cataracts', title: 'Cataracts'),
    S2Choice<String>(value: 'Glaucoma', title: 'Glaucoma'),
  ];

  List<S2Choice<String>> optionsDIAGNOSIS = [
    S2Choice<String>(
        value: 'No abnormalities detected', title: 'No abnormalities detected'),
    S2Choice<String>(value: 'Cataracts', title: 'Cataracts'),
    S2Choice<String>(
        value: 'Cataracts, suspected', title: 'Cataracts, suspected'),
    S2Choice<String>(value: 'Maculophaty', title: 'Maculophaty'),
    S2Choice<String>(
        value: 'Macular degeneration, Age related (ARMD)',
        title: 'Macular degeneration, Age related (ARMD)'),
    S2Choice<String>(
        value: 'Macula Edema, Clinical Significant (CSME)',
        title: 'Macula Edema, Clinical Significant (CSME)'),
    S2Choice<String>(
        value: 'Retinopathy, hypertensive', title: 'Retinopathy, hypertensive'),
    S2Choice<String>(value: 'Retinopathy, NPDR', title: 'Retinopathy, NPDR'),
    S2Choice<String>(value: 'Retinopathy, PDR', title: 'Retinopathy, PDR'),
    S2Choice<String>(value: 'Retinal dystrophy', title: 'Retinal dystrophy'),
  ];

  List<S2Choice<String>> optionsRECOMMENDEDMANAGEMENT = [
    S2Choice<String>(value: 'Anti VEGF', title: 'Anti VEGF'),
    S2Choice<String>(
        value: 'Cateract extraction', title: 'Cateract extraction'),
    S2Choice<String>(
        value: 'MControl Risk Factorsale', title: 'Control Risk Factors'),
    S2Choice<String>(
        value: 'Evaluation Cataract', title: 'Evaluation Cataract'),
    S2Choice<String>(
        value: 'Evaluation Slit lamp', title: 'Evaluation Slit lamp'),
    S2Choice<String>(
        value: 'Evaluation Refraction', title: 'Evaluation Refraction'),
    S2Choice<String>(value: 'Laser', title: 'Laser'),
    S2Choice<String>(value: 'Observe & Monitor', title: 'Observe & Monitor'),
  ];

  List<S2Choice<String>> optionsREPEATFUNDOSCOPY = [
    S2Choice<String>(value: '3 months', title: '3 months'),
    S2Choice<String>(value: '6 months', title: '6 months'),
    S2Choice<String>(value: 'Annual', title: 'Annual'),
  ];

  List<S2Choice<String>> optionsREFERRALTOCONSULTANT = [
    S2Choice<String>(value: 'No referal', title: 'No referal'),
    S2Choice<String>(value: 'Urgent', title: 'Urgent'),
    S2Choice<String>(value: '3 months', title: '3 months'),
    S2Choice<String>(value: '6 months', title: '6 months'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    selectedDate = DateTime.now();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  sendToNurse() {
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
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: new Text('Patient'),
          bottom: TabBar(controller: _tabController, tabs: [
            Tab(
              icon: Icon(Icons.details_outlined),
              text: 'Patient Details',
            ),
            Tab(icon: Icon(Icons.note_add), text: 'Referal Notes'),
            Tab(icon: Icon(Icons.insert_photo), text: 'Image Transfer'),
            Tab(icon: Icon(Icons.recommend), text: 'Recommendation'),
          ]),
        ),
        body: Form(
          key: _formKey,
          child: DefaultTabController(
            length: 4,
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                //first form
                Background(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Center(child: _buildBody(context)),
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
                        RoundedInputField(
                          icon: Icons.calendar_today,
                          hintText: rfullName,
                          onChanged: (value) {
                            setState(() {
                              rfullName = value;
                            });
                          },
                        ),
                        RoundedInputField(
                          icon: Icons.calendar_today,
                          hintText: rdateImagesTaken,
                          onChanged: (value) {
                            setState(() {
                              rdateImagesTaken = value;
                            });
                          },
                        ),
                        RoundedInputField(
                          icon: Icons.sick_outlined,
                          hintText: rsymptoms,
                          onChanged: (value) {
                            setState(() {
                              rsymptoms = value;
                            });
                          },
                        ),
                        RoundedInputField(
                          icon: Icons.sticky_note_2_outlined,
                          hintText: rother,
                          onChanged: (value) {},
                        ),
                        RoundedInputField(
                          icon: Icons.merge_type,
                          hintText: rtypeOfDiabetes,
                          onChanged: (value) {
                            setState(() {
                              rtypeOfDiabetes = value;
                            });
                          },
                        ),
                        RoundedInputField(
                          icon: Icons.medical_services_outlined,
                          hintText: rdiabetesTherapy,
                          onChanged: (value) {
                            setState(() {
                              rdiabetesTherapy = value;
                            });
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                        ),
                        RoundedButton(
                            text: "(1 of 3): NEXT",
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
                        Container(
                            child: Image.network(
                          '$rleftEyeImage1',
                          semanticLabel: 'Left Eye',
                          width: 500.0,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, progress) {
                            return progress == null
                                ? child
                                : LinearProgressIndicator();
                          },
                        )),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                        ),
                        Container(
                            child: Image.network(
                          '$rleftEyeImage2',
                          semanticLabel: 'Left Eye',
                          width: 500.0,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, progress) {
                            return progress == null
                                ? child
                                : LinearProgressIndicator();
                          },
                        )),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                        ),
                        Container(
                            child: Image.network(
                          'rrightEyeImage1',
                          semanticLabel: 'Left Eye',
                          width: 500.0,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, progress) {
                            return progress == null
                                ? child
                                : LinearProgressIndicator();
                          },
                        )),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                        ),
                        Container(
                            child: Image.network(
                          '$rrightEyeImage2',
                          semanticLabel: 'Left Eye',
                          width: 500.0,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, progress) {
                            return progress == null
                                ? child
                                : LinearProgressIndicator();
                          },
                        )),
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

                //fourth
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
                        SmartSelect<String>.single(
                            title: 'SIGNS OF DIABETIC RETINOPATHY',
                            value: value,
                            choiceItems: optionsSIGNSOFDIABETICRETINOPATHY,
                            onChange: (state) => setState(() {
                                  value = state.value;
                                  signsOfDiabeticRetinopathy = value;
                                })),
                        SmartSelect<String>.single(
                            title:
                                'NON PROLIFERATIVE DIABETIC RETINOPATHY - RIGHT EYE',
                            value: value,
                            choiceItems:
                                optionsNONPROLIFERATIVEDIABETICRETINOPATHY,
                            onChange: (state) => setState(() {
                                  value = state.value;
                                  nonProliferativeDiabeticRetinopathyRight =
                                      value;
                                })),
                        SmartSelect<String>.single(
                            title:
                                'NON PROLIFERATIVE DIABETIC RETINOPATHY - LEFT EYE',
                            value: value,
                            choiceItems:
                                optionsNONPROLIFERATIVEDIABETICRETINOPATHY,
                            onChange: (state) => setState(() {
                                  value = state.value;
                                  nonProliferativeDiabeticRetinopathyLeft =
                                      value;
                                })),
                        SmartSelect<String>.single(
                            title:
                                'PROLIFERATIVE DIABETIC RETINOPATHY - RIGHT EYE',
                            value: value,
                            choiceItems:
                                optionsNONPROLIFERATIVEDIABETICRETINOPATHY,
                            onChange: (state) => setState(() {
                                  value = state.value;
                                  proliferativeDiabeticRetinopathyRight = value;
                                })),
                        SmartSelect<String>.single(
                            title:
                                'PROLIFERATIVE DIABETIC RETINOPATHY - LEFT EYE',
                            value: value,
                            choiceItems:
                                optionsNONPROLIFERATIVEDIABETICRETINOPATHY,
                            onChange: (state) => setState(() {
                                  value = state.value;
                                  proliferativeDiabeticRetinopathyLeft = value;
                                })),
                        SmartSelect<String>.single(
                            title:
                                'ADDITIONAL SUSPECTED EYE PATHOLOGIES - RIGHT EYE',
                            value: value,
                            choiceItems:
                                optionsADDITIONALSUSPECTEDEYEPATHOLOGIES,
                            onChange: (state) => setState(() {
                                  value = state.value;
                                  additionalSuspectedEyePathologiesRight =
                                      value;
                                })),
                        SmartSelect<String>.single(
                            title:
                                'ADDITIONAL SUSPECTED EYE PATHOLOGIES - LEFT EYE',
                            value: value,
                            choiceItems:
                                optionsADDITIONALSUSPECTEDEYEPATHOLOGIES,
                            onChange: (state) => setState(() {
                                  value = state.value;
                                  additionalSuspectedEyePathologiesLeft = value;
                                })),
                        SmartSelect<String>.single(
                            title: 'DIAGNOSIS',
                            value: value,
                            choiceItems: optionsDIAGNOSIS,
                            onChange: (state) => setState(() {
                                  value = state.value;
                                  diagnosis = value;
                                })),
                        SmartSelect<String>.single(
                            title: 'RECOMMENDED MANAGEMENT',
                            value: value,
                            choiceItems: optionsRECOMMENDEDMANAGEMENT,
                            onChange: (state) => setState(() {
                                  value = state.value;
                                  recommendedManagement = value;
                                })),
                        SmartSelect<String>.single(
                            title: 'REPEAT FUNDOSCOPY',
                            value: value,
                            choiceItems: optionsREPEATFUNDOSCOPY,
                            onChange: (state) => setState(() {
                                  value = state.value;
                                  repeatFundascopy = value;
                                })),
                        SmartSelect<String>.single(
                            title: 'REFERRAL TO CONSULTANT',
                            value: value,
                            choiceItems: optionsREFERRALTOCONSULTANT,
                            onChange: (state) => setState(() {
                                  value = state.value;
                                  referralToConsult = value;
                                })),
                        SmartSelect<String>.single(
                            title:
                                'ADDITIONAL SUSPECTED EYE PATHOLOGIES - RIGHT EYE',
                            value: value,
                            choiceItems:
                                optionsADDITIONALSUSPECTEDEYEPATHOLOGIES,
                            onChange: (state) => setState(() {
                                  value = state.value;
                                  additionalSuspectedEyePathologiesRight =
                                      value;
                                })),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                        ),
                        RoundedButton(
                            text: "(3 of 3): SUBMIT",
                            color: kPrimaryColor,
                            press: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return Review();
                                },
                              ));
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildBody(BuildContext context) {
    return Background(
        child: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('patients').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.docs);
      },
    ));
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(padding: const EdgeInsets.only(top: 20.0), children: [
      DataTable(
          columns: <DataColumn>[
            DataColumn(
              label: Text(
                'FullName',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'NCD No.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Study No.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Diabetes Type',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Year Of DM',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
          rows: snapshot
              .map(
                (DocumentSnapshot document) => DataRow(
                  cells: <DataCell>[
                    DataCell(Text(document['fullName'])),
                    DataCell(Text(document['dfidStudyNumber'])),
                    DataCell(Text(document['ncdNumber'])),
                    DataCell(Text(document['typeOfDiabetes'])),
                    DataCell(Text(document['yearOfDmDiagnosis'])),
                  ],
                  onSelectChanged: (value) {
                    rfullName = document['fullName'];
                    rdateImagesTaken = document['dateImagesTaken'];
                    rsymptoms = document['symptoms'];
                    rother = document['other'];
                    rtypeOfDiabetes = document['typeOfDiabetes'];
                    rdiabetesTherapy = document['diabetesTherapy'];
                    rleftEyeImage1 = document['leftEyeImage1'];
                    rrightEyeImage1 = document['rightEyeImage1'];
                    rleftEyeImage2 = document['leftEyeImage2'];
                    rrightEyeImage2 = document['rightEyeImage2'];

                    print(rfullName);
                    print(dateImagesTaken);
                    print(symptoms);
                    print(other);
                    print(typeOfDiabetes);
                    print(diabetesTherapy);
                    print(rleftEyeImage1);
                    print(rrightEyeImage1);
                    print(typeOfDiabetes);
                    print(rleftEyeImage2);

                    _tabController.animateTo((_tabController.index + 1));
                  },
                ),
              )
              .toList())
    ]);
  }
  //end
}
