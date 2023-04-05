import 'package:flutter/material.dart';
import 'package:nomad/Pages/Home_page.dart';

class ProposalPage extends StatefulWidget {
  const ProposalPage({super.key});

  @override
  State<ProposalPage> createState() => _ProposalPageState();
}

class _ProposalPageState extends State<ProposalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 80, 8, 0),
        child: Column(children: [
          AdminPropsals(
              "Proposal_1", ["Proposal_1", "Submitted by:", "Details:"])
        ]),
      ),
    );
  }
}

Widget AdminPropsals(String title, var items) {
  return Container(
      padding: const EdgeInsets.fromLTRB(8, 10, 4, 3),
      child: Column(
        children: [
          SizedBox(
              height: 470,
              width: double.maxFinite,
              child: Column(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )
                    ]),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    width: double.maxFinite,
                    child: Card(
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 00, 5, 0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  child: Text(
                                    items[0],
                                    style: TextStyle(fontSize: 20),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  child: Text(
                                    items[1],
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
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  child: Text(
                                    items[2],
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ])),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: null, child: Text("Approve Proposal")),
              ElevatedButton(onPressed: null, child: Text("Reject Proposal")),
              ElevatedButton(onPressed: null, child: Text("Skip")),
            ],
          )
        ],
      ));
}