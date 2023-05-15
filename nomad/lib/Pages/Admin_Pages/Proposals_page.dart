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
        result[i]['user'],
      );
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
        backgroundColor: Color.fromARGB(255, 185, 157, 139),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                for (var proposal in list_of_Proposals)
                  AdminPropsals(proposal, context, removeProposalFromList),
              ],
            ),
          ),
        ),
      ),
    );
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
    decoration:
        BoxDecoration(border: Border.all(width: 10, color: Colors.black12)),
    child: SizedBox(
      height: 550,
      width: double.maxFinite,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(8, 10, 4, 3),
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
                    style: TextStyle(fontSize: 20),
                  ),
                ),
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
                    style: TextStyle(fontSize: 20),
                  ),
                ),
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
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 25,
                  width: double.maxFinite,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                  child: Row(
                    children: [
                      Text("Location Details", style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: true,
                    initialValue: proposal.location,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          // Adjust the height as needed
          SizedBox(
            height: 60, // Adjust the height as needed
            child: ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    ProposalApprove(proposal, context);
                    removeCallback(proposal);
                  },
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.check, color: Colors.white),
                  ),
                ),
                InkWell(
                  onTap: () {
                    EditProposal(proposal, context);
                  },
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.edit, color: Colors.white),
                  ),
                ),
                InkWell(
                  onTap: () {
                    ClearProposal(proposal, context);
                    removeCallback(proposal);
                  },
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.close, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
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
  Proposal(
    String _name,
    String _category,
    String _description,
    String _location,
    String _id,
    String _user,
  ) {
    name = _name;
    category = _category;
    description = _description;
    location = _location;
    id = _id;
    user = _user;
  }
}
