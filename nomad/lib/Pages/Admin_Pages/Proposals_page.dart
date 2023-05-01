import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nomad/Pages/Admin_Pages/FormEdit_Page.dart';
import 'package:nomad/Pages/Guide_Pages/Guide_page.dart';
import 'package:nomad/Pages/Home_page.dart';
import 'package:nomad/Pages/User_Pages/Proposal_Form.dart';

class ProposalPage extends StatefulWidget {
  const ProposalPage({super.key});

  @override
  State<ProposalPage> createState() => _ProposalPageState();
}

var list_of_Proposals = [];

Future<void>? getProposals(var context) async {
  CollectionReference database =
      FirebaseFirestore.instance.collection('proposals');
  QuerySnapshot snapshot = await database.get();
  List<dynamic> result = snapshot.docs.map((doc) => doc.data()).toList();

  int i;
  list_of_Proposals = [];

  for (i = 0; i < result.length; i++) {
    Proposal p = Proposal(
        result[i]['title'],
        result[i]['category'],
        result[i]['description'],
        result[i]['location'],
        result[i]['ID'],
        result[i]['user']);
    list_of_Proposals.add(AdminPropsals(p, context));
  }

  /*if (list_of_Proposals.length > 0)
    return 1;
  else
    return 0; */
}

class _ProposalPageState extends State<ProposalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Review Pending Proposals'),
          centerTitle: true,
        ),
        body: FutureBuilder<dynamic>(
          future: getProposals(context),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 80, 8, 0),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(children: [
                    for (var proposal in list_of_Proposals) proposal
                  ]),
                ),
              ),
            );
          },
        ));
  }
}

Widget AdminPropsals(Proposal proposal, [var context]) {
  return Container(
      padding: const EdgeInsets.fromLTRB(8, 10, 4, 3),
      child: Column(
        children: [
          SizedBox(
              height: 500,
              width: double.maxFinite,
              child: Column(children: [
                Text(
                  proposal.name,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Card(
                    //color: Colors.blue,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25,
                          width: double.maxFinite,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                          child: Row(
                            children: [
                              Text("Name", style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                              readOnly: true,
                              initialValue: proposal.name,
                              style: TextStyle(fontSize: 20)),
                        ),

                        // End of Name details

                        SizedBox(
                          height: 25,
                          width: double.maxFinite,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                          child: Row(
                            children: [
                              Text("Category", style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                              readOnly: true,
                              initialValue: proposal.category,
                              style: TextStyle(fontSize: 20)),
                        ),

                        // End of Category

                        SizedBox(
                          height: 25,
                          width: double.maxFinite,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                          child: Row(
                            children: [
                              Text("Description Details",
                                  style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                              readOnly: true,
                              initialValue: proposal.description,
                              style: TextStyle(fontSize: 20)),
                        ),

                        // End of details

                        SizedBox(
                          height: 25,
                          width: double.maxFinite,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                          child: Row(
                            children: [
                              Text("Location Details",
                                  style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                              readOnly: true,
                              initialValue: proposal.location,
                              style: TextStyle(fontSize: 20)),
                        )

                        // End of location details
                      ],
                    ),
                  ),
                ),
              ])),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () => ProposalApprove(proposal, context),
                  child: Text("Approve\nProposal")),
              InkWell(
                onTap: () => {EditProposal(proposal, context)},
                child: Text("Edit\nProposal"),
              ),
              ElevatedButton(
                  onPressed: () => ClearProposal(proposal, context),
                  child: Text("Reject\nProposal")),
            ],
          )
        ],
      ));
}

Future<void> ProposalApprove(Proposal spot, [var context]) {
  CollectionReference database = FirebaseFirestore.instance.collection('spots');
  return database
      .add({
        'title': spot.name,
        'category': spot.category,
        'description': spot.description,
        'location': spot.location,
        'topSpot': "False",
        'User': 'user'
        // REPLACE THIS WITH Global_var.Username
      })
      .then((value) => ClearProposal(spot))
      .then((value) => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProposalPage(),
          )));
}

EditProposal(Proposal spot, [var context]) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditingPage(proposal: spot),
      ));
}

ClearProposal(Proposal spot, [var context]) {
  CollectionReference database =
      FirebaseFirestore.instance.collection('proposals');

  database.doc(spot.id).delete();
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProposalPage(),
      ));
}

class Proposal {
  late String name;
  late String category;
  late String description;
  late String location;
  late String id;
  late String user;
  Proposal(String _name, String _category, String _description,
      String _location, String _id, String _user) {
    name = _name;
    category = _category;
    description = _description;
    location = _location;
    id = _id;
    user = _user;
  }
}
