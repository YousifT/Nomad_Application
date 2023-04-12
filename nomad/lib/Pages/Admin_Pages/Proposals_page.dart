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
  AdminPropsals(Proposal("Empty", "NULL", "NULL", "NULL")),
];

Future<void>? getProposals(var context) {
  // Connect to DB
  // Get all Proposals from DB
  // update list_of_Proposals
  list_of_Proposals = [];
  list_of_Proposals = [
    AdminPropsals(
        Proposal("Tester1", "Event", "_description", "_location"), context),
    AdminPropsals(
        Proposal("Tester2", "Cafe", "_description", "_location"), context),
    AdminPropsals(
        Proposal("Tester3", "Event", "_description", "_location"), context)
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
                                      readOnly: proposal.readOnlyFlag,
                                      initialValue: proposal.category,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 25,
                          width: double.maxFinite,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                              child: Text(
                                "Details: ",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
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
                              child: Text(
                                "items",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ])),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: ProposalApprove(proposal),
                  child: Text("Approve\nProposal")),
              InkWell(
                onTap: () => {EditProposal(proposal, context)},
                child: Text("Edit\nProposal"),
              ),
              ElevatedButton(
                  onPressed: ProposalReject(proposal),
                  child: Text("Reject\nProposal")),
            ],
          )
        ],
      ));
}

ProposalApprove(Proposal spot) {
  // Sanitize the entries
  // add to the DB the new spot
}

EditProposal(Proposal spot, [var context]) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditingPage(proposal: spot),
      ));
}

ProposalReject(Proposal spot) {
  // Delete it from the DB list of Pending Proposal
  //Optional: pop up a text box, write a reason, send it as an email respone to the user
}

class Proposal {
  late String name;
  late String category;
  late String description;
  late String location;
  bool readOnlyFlag = true;

  Proposal(
      String _name, String _category, String _description, String _location) {
    this.name = _name;
    this.category = _category;
    this.description = _description;
    this.location = _location;
  }
}
