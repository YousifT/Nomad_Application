import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nomad/Global_Var.dart';

String? type_Value = "Event";
var type_choices = ["Event", "Restaurant", "Cafe"];

class ProposalForm extends StatefulWidget {
  final Function() onSubmitted;

  const ProposalForm({Key? key, required this.onSubmitted}) : super(key: key);

  @override
  State<ProposalForm> createState() => _ProposalFormState();
}

class _ProposalFormState extends State<ProposalForm> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController locationController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    Future<void> submit() {
      CollectionReference database =
          FirebaseFirestore.instance.collection('proposals');
      var docID = database.doc();
      return database.doc(docID.id).set({
        'title': nameController.text,
        'category': type_Value,
        'description': descriptionController.text,
        'location': locationController.text,
        'user': global_UserEmail,
        'ID': docID.id,
        'topSpot': "False",
      }).then((value) {
        Navigator.pop(context);
        widget
            .onSubmitted(); // Add this line to call the callback function after submitting the proposal
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Submit a proposal form'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 185, 157, 139),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              // Type (dropdown menu)

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Category',
                      style: TextStyle(fontSize: 18),
                    ),
                    DropdownButton(
                        value: type_Value,
                        items: type_choices.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          var nameHolder = nameController.text;
                          var descHolder = descriptionController.text;
                          var locHolder = locationController.text;
                          setState(() {
                            type_Value = newValue!;
                          });
                        }),
                  ],
                ),
              ),
              // Name
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Text(
                      'Name',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter the name of your Establishment or Event',
                    border: OutlineInputBorder(),
                  )),
              SizedBox(height: 20),

              // Location URL
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Text(
                      'Location Details',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                    hintText: 'Enter the Location URL',
                    border: OutlineInputBorder(),
                  )),

              // Description
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Text(
                      'Description & Extra details',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              TextField(
                  maxLines: null,
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Describe the details of your Establishment.',
                    border: OutlineInputBorder(),
                  )),
              SizedBox(height: 30),

              // Upload Images *Optional

              // Submit Form button
              ElevatedButton.icon(
                onPressed: submit,
                icon: Icon(Icons.save),
                label: Text('Submit'),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Color.fromARGB(255, 66, 92, 105)),
              ),
              // Submitted By: User email info.
            ],
          ),
        ),
      ),
    );
  }
}
