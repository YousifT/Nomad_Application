import 'package:flutter/material.dart';

String? type_Value = "Event";
var type_choices = ["Event", "Resturant", "Cafe"];

class ProposalForm extends StatefulWidget {
  const ProposalForm({super.key});

  @override
  State<ProposalForm> createState() => _ProposalFormState();
}

class _ProposalFormState extends State<ProposalForm> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController locationController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit a proposal form'),
        centerTitle: true,
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
              TextField(
                  controller: nameController,
                  decoration: InputDecoration(
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
                        value: type_Value,
                        items: type_choices.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            type_Value = newValue!;
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
              TextField(
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
              TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Describe the details of your Establishment.',
                    border: OutlineInputBorder(),
                  ))

              // Upload Images *Optional
            ],
          ),
        ),
      ),
    );
  }
}
