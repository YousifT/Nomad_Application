import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nomad/Pages/Admin_Pages/FormEdit_Page.dart';
import 'package:nomad/Pages/Guide_Pages/Guide_page.dart';
import 'package:nomad/Pages/Home_page.dart';
import 'package:nomad/Pages/User_Pages/Proposal_Form.dart';

class ProposalPage extends StatefulWidget {
  const ProposalPage({Key? key}) : super(key: key);

  @override
  State<ProposalPage> createState() => _ProposalPageState();
}

class _ProposalPageState extends State<ProposalPage> {
  late List<Proposal> list_of_Proposals;

  @override
  void initState() {
    super.initState();
    list_of_Proposals = [];
    getProposals();
  }

  Future<void> getProposals() async {
    CollectionReference database =
        FirebaseFirestore.instance.collection('proposals');
    QuerySnapshot snapshot = await database.get();
    List<dynamic> result = snapshot.docs.map((doc) => doc.data()).toList();

    int i;
    List<Proposal> tempList = [];

    for (i = 0; i < result.length; i++) {
      Proposal p = Proposal(
          result[i]['title'],
          result[i]['category'],
          result[i]['description'],
          result[i]['location'],
          result[i]['ID'],
          result[i]['user']);
      tempList.add(p);
    }

    setState(() {
      list_of_Proposals = tempList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Review Pending Proposals'),
          centerTitle: true,
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 80, 8, 0),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(children: [
                for (var proposal in list_of_Proposals)
                  AdminPropsals(proposal, context, removeProposalFromList)
              ]),
            ),
          ),
        ));
  }

  void removeProposalFromList(Proposal proposal) {
    setState(() {
      list_of_Proposals.remove(proposal);
    });
  }
}

Widget AdminPropsals(Proposal proposal, BuildContext context,
    Function(Proposal) removeCallback) {
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
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ElevatedButton(
                onPressed: () {
                  ProposalApprove(proposal, context);
                  removeCallback(proposal);
                },
                child: Text("Approve\nProposal")),
            InkWell(
              onTap: () => {EditProposal(proposal, context)},
              child: Text("Edit\nProposal"),
            ),
            ElevatedButton(
                onPressed: () {
                  ClearProposal(proposal, context);
                  removeCallback(proposal);
                },
                child: Text("Reject\nProposal")),
          ])
        ],
      ));
}

Future<void> ProposalApprove(Proposal spot, BuildContext context) async {
  CollectionReference database = FirebaseFirestore.instance.collection('spots');
  var docID = database.doc();
  await database.doc(docID.id).set({
    'title': spot.name,
    'category': spot.category,
    'description': spot.description,
    'location': spot.location,
    'topSpot': "False",
    // REPLACE THIS WITH Global_var.Username
    'User': spot.user,
    'ID': docID.id
  });
  await ClearProposal(spot, context);
}

EditProposal(Proposal spot, BuildContext context) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EditingPage(proposal: spot),
    ),
  );
  (context as BuildContext)
      .findAncestorStateOfType<_ProposalPageState>()
      ?.getProposals();
}

ClearProposal(Proposal spot, BuildContext context) async {
  CollectionReference database =
      FirebaseFirestore.instance.collection('proposals');

  await database.doc(spot.id).delete();

  if (context != null) {
    await ClearProposal(spot, context);
  }
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
