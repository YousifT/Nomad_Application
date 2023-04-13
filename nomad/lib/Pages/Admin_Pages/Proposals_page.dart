import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nomad/Pages/Admin_Pages/FormEdit_Page.dart';
import 'package:nomad/Pages/Guide_page.dart';
import 'package:nomad/Pages/Home_page.dart';
import 'package:nomad/Pages/Proposal_Form.dart';

class ProposalPage extends StatefulWidget {
  const ProposalPage({super.key});

  @override
  State<ProposalPage> createState() => _ProposalPageState();
}

var list_of_Proposals = [
  AdminPropsals(Proposal("Empty", "NULL", "NULL", "NULL", "NULL")),
];

Future<void>? getProposals(var context) {
  // Connect to DB
  // Get all Proposals from DB
  // update list_of_Proposals
  list_of_Proposals = [];
  list_of_Proposals = [
    AdminPropsals(
        Proposal("Tester1", "Event", "_description", "_location", "_ID"),
        context),
    AdminPropsals(
        Proposal("Tester2", "Cafe", "_description", "_location", "_ID"),
        context),
    AdminPropsals(
        Proposal("Tester3", "Event", "_description", "_location", "_ID"),
        context)
  ];
}

class _ProposalPageState extends State<ProposalPage> {
  @override
  Widget build(BuildContext context) {
    getProposals(context);
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 80, 8, 0),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
                children: [for (var proposal in list_of_Proposals) proposal]),
          ),
        ),
      ),
    );
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                              child: Row(
                                children: [
                                  Text(
                                    "Name",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(width: 100),
                                  SizedBox(
                                    width: 150,
                                    child: TextFormField(
                                      readOnly: true,
                                      initialValue: proposal.name,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),

                        // End of Name details

                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Type:",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(width: 100),
                                  SizedBox(
                                    width: 150,
                                    child: TextFormField(
                                      readOnly: true,
                                      initialValue: proposal.category,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),

                        // End of Type

                        SizedBox(
                          height: 25,
                          width: double.maxFinite,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                              child: Row(
                                children: [
                                  Text(
                                    "Details: ",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(width: 100),
                                  SizedBox(
                                    width: 150,
                                    child: TextFormField(
                                      readOnly: true,
                                      initialValue: proposal.description,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),

                        // End of details

                        SizedBox(
                          height: 25,
                          width: double.maxFinite,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                              child: Row(
                                children: [
                                  Text(
                                    "Location Details",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(width: 100),
                                  SizedBox(
                                    width: 150,
                                    child: TextFormField(
                                      readOnly: true,
                                      initialValue: proposal.location,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
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
                  onPressed: () => ProposalApprove(proposal),
                  child: Text("Approve\nProposal")),
              InkWell(
                onTap: () => {EditProposal(proposal, context)},
                child: Text("Edit\nProposal"),
              ),
              ElevatedButton(
                  onPressed: () => ClearProposal(proposal),
                  child: Text("Reject\nProposal")),
            ],
          )
        ],
      ));
}

Future<void> ProposalApprove(Proposal spot) {
  CollectionReference database = FirebaseFirestore.instance.collection('spots');
  return database.add({
    'title': spot.name,
    'category': spot.category,
    'description': spot.description,
    'location': spot.location,
    // REPLACE THIS WITH Global_var.Username
    'user': "Username"
  });
}

EditProposal(Proposal spot, [var context]) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditingPage(proposal: spot),
      ));
}

ClearProposal(Proposal spot) {
  CollectionReference database = FirebaseFirestore.instance.collection('spots');

  database.get();

  //Optional: pop up a text box, write a reason, send it as an email respone to the user
}

class Proposal {
  late String name;
  late String category;
  late String description;
  late String location;
  late String id;
  Proposal(String _name, String _category, String _description,
      String _location, String _id) {
    this.name = _name;
    this.category = _category;
    this.description = _description;
    this.location = _location;
    this.id = _id;
  }
}
