import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:nomad/Pages/Admin_Pages/Admin_Page.dart';
import 'package:nomad/Pages/Admin_Pages/Proposals_page.dart';
import 'package:flutter/material.dart';

var type_choices = ["Event", "Restaurant", "Cafe"];

class EditingPage extends StatefulWidget {
  final Proposal proposal;
  EditingPage({required this.proposal});

  @override
  State<EditingPage> createState() => _EditingPageState();
}

class _EditingPageState extends State<EditingPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: widget.proposal.name);
    TextEditingController locationController =
        TextEditingController(text: widget.proposal.location);
    TextEditingController descriptionController =
        TextEditingController(text: widget.proposal.description);

    submitEdit() {
      var ID_holder = widget.proposal.id;
      CollectionReference database =
          FirebaseFirestore.instance.collection('proposals');

      database.doc(ID_holder).update({
        'title': nameController.text,
        'category': widget.proposal.category,
        'description': descriptionController.text,
        'location': locationController.text,
        'user': widget.proposal.user,
        'ID': ID_holder
      }).then((value) => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const AdminPage())));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit the proposal'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 185, 157, 139),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Name
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter the name of your Establishment or Event',
                    border: OutlineInputBorder(),
                  )),
              // Type (dropdown menu)
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Type Category',
                      style: TextStyle(fontSize: 18),
                    ),
                    DropdownButton(
                        value: widget.proposal.category,
                        items: type_choices.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            widget.proposal.category = newValue!;
                          });
                        }),
                  ],
                ),
              ),

              // Location URL
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Location Details',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                  controller: locationController,
                  decoration: InputDecoration(
                    hintText: 'Enter the Location URL',
                    border: OutlineInputBorder(),
                  )),

              // Description
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Description & Extra details',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Describe the details of your Establishment.',
                    border: OutlineInputBorder(),
                  )),
              SizedBox(height: 30),
              ElevatedButton(
                  onPressed: () => submitEdit(), child: Text("submit"))

              // Upload Images *Optional

              // Submit Form button
            ],
          ),
        ),
      ),
    );
  }
}
