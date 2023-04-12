import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:nomad/Pages/Admin_Pages/Proposals_page.dart';
import 'package:flutter/material.dart';

var type_choices = ["Event", "Resturant", "Cafe"];

class EditingPage extends StatefulWidget {
  final Proposal proposal;
  EditingPage({required this.proposal});

  @override
  State<EditingPage> createState() => _EditingPageState();
}

class _EditingPageState extends State<EditingPage> {
  @override
  Widget build(BuildContext context) {
    print("name, category, location, description");
    print(widget.proposal.name);

    print(widget.proposal.category);
    print(widget.proposal.location);

    print(widget.proposal.description);

    TextEditingController nameController = TextEditingController();
    TextEditingController locationController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit the proposal'),
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
              TextFormField(
                  initialValue: widget.proposal.name,
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
                  initialValue: widget.proposal.location,
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
                  initialValue: widget.proposal.description,
                  decoration: InputDecoration(
                    hintText: 'Describe the details of your Establishment.',
                    border: OutlineInputBorder(),
                  ))

              // Upload Images *Optional

              // Submit Form button
              // Submitted By: User email info.
            ],
          ),
        ),
      ),
    );
  }
}
