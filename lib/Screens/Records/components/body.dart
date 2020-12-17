import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dfidmobilen/Screens/Records/components/background.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  BodyState createState() {
    return BodyState();
  }
}

class BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Patient List')),
      body: _buildBody(context),
    );
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
                'Gender',
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
                    DataCell(Text(document['gender'])),
                    DataCell(Text(document['typeOfDiabetes'])),
                    DataCell(Text(document['yearOfDmDiagnosis'])),
                  ],
                ),
              )
              .toList())
    ]);
  }
  //end
}
