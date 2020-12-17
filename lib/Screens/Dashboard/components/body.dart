import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dfidmobilen/Screens/Dashboard/components/background.dart';

import 'package:dfidmobilen/Screens/Records/patientlist.dart';
import 'package:dfidmobilen/Screens/Registration/newpatient.dart';
import 'package:dfidmobilen/Screens/Review/review.dart';
import 'package:dfidmobilen/Screens/Reviewed/reviewedPatients.dart';
import 'package:dfidmobilen/Screens/UserProfile/userprofile.dart';
import 'package:dfidmobilen/constants.dart';
import 'package:flutter/material.dart';

import '../../../model/usermanagement.dart';

class Body extends StatefulWidget {
  @override
  BodyState createState() {
    return BodyState();
  }
}

class BodyState extends State<Body> {
  int numberReviewed = 0;
  int allPatients;
  int newPatients;
  int patientsReviewed;
  int onMedication;
  int _selectedIndex = 0;

  _countAllPatients() async {
    QuerySnapshot _myDoc =
        await FirebaseFirestore.instance.collection('patients').get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    allPatients = _myDocCount.length;
    return allPatients;
  }

  UserManagement tick = new UserManagement();

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    List<Widget> _widgetOptions = <Widget>[
      Center(child: _buildBody(context)),
      NewPatient(),
      PatientList(),
      Reviewed(),
      Review(),
      UserProfile(),
      // tick.signIn(),
      Text('This function is currently not implemented'),
    ];

    _countAllPatients();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DFID MOBILE APPLICATION',
          textScaleFactor: 1.0,
        ),
        centerTitle: true,
      ),

      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //       DrawerHeader(
      //         child: SvgPicture.asset(
      //           "assets/images/solidarmedlogo.svg",
      //           height: size.height * 0.35,
      //           color: Colors.red,
      //         ),
      //         decoration: BoxDecoration(
      //           color: kPrimaryLightColor,
      //         ),
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.dashboard),
      //         title: Text('Dashboard'),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.person_add),
      //         title: Text('New Patient'),
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (BuildContext context) => new NewPatient()),
      //           );
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.people),
      //         title: Text('Patient Records'),
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (BuildContext context) => new PatientList()),
      //           );
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.verified_user),
      //         title: Text('User Profile'),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.logout),
      //         title: Text('SignOut'),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //     ],
      //   ),
      // ),

      bottomNavigationBar: BottomNavigationBar(
        iconSize: 50.0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Home',
            backgroundColor: kPrimaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'New Patient',
            backgroundColor: kPrimaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Patient Records',
            backgroundColor: kPrimaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rate_review),
            label: 'Reviewed',
            backgroundColor: kPrimaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_on),
            label: 'Review *',
            backgroundColor: kPrimaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User Profile',
            backgroundColor: kPrimaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'SignOut',
            backgroundColor: kPrimaryColor,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return new Background(
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(50.0),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: FlatButton(
              padding: EdgeInsets.all(70.0),
              color: Colors.purple[200],
              onPressed: () => _countAllPatients(),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.people,
                    size: 100.0,
                    color: Colors.black38,
                  ),
                  Text(
                    '\n Total Patients \n \n $allPatients',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: FlatButton(
              padding: EdgeInsets.all(70.0),
              color: kPrimaryColor,
              onPressed: () {},
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.person_add,
                    size: 100.0,
                    color: Colors.black38,
                  ),
                  Text(
                    '\n New Patients \n \n $numberReviewed',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: FlatButton(
              padding: EdgeInsets.all(70.0),
              color: Color.fromRGBO(255, 129, 129, 50),
              onPressed: () {},
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.rate_review,
                    size: 100.0,
                    color: Colors.black38,
                  ),
                  Text(
                    '\n Patients Reviewed \n \n $numberReviewed',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: FlatButton(
              padding: EdgeInsets.all(70.0),
              color: Colors.redAccent,
              onPressed: () {},
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.medical_services,
                    size: 100.0,
                    color: Colors.black38,
                  ),
                  Text(
                    '\n On Medication \n \n $numberReviewed',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
