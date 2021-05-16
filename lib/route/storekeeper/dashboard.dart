import 'package:flutter/material.dart';

class MyDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("My Dashboard"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        children: <Widget>[
          Card(
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                child: Table(
                  columnWidths: {
                    0: FractionColumnWidth(.5),
                  },
                  children: <TableRow>[
                    row("TOTAL ITEM : ", "521"),
                    row("TOTAL QUANTITY : ", "1376"),
                    row("TOTAL STORE : ", "3"),
                  ],
                ),
              )),
          SizedBox(height: 12),
          Card(
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                child: Table(
                  columnWidths: {
                    0: FractionColumnWidth(.5),
                  },
                  children: <TableRow>[
                    row("STORE A : ", "1000"),
                    row("STORE B : ", "300"),
                    row("STORE C : ", "76"),
                  ],
                ),
              )),
          SizedBox(height: 12),
          Card(
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                child: Table(
                  columnWidths: {
                    0: FractionColumnWidth(.5),
                  },
                  children: <TableRow>[
                    row("TOTAL VALUE : ", "RM 250,000.00"),
                    row("VALUE IN STORE : ", "RM 100,000.00"),
                    row("USED VALUE : ", "RM 150,000.00"),
                  ],
                ),
              )),
          SizedBox(height: 12),
          Card(
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                child: Table(
                  columnWidths: {
                    0: FractionColumnWidth(.5),
                  },
                  children: <TableRow>[
                    row("LOW STOCK : ", "4 Item(s)"),
                    row("NEED STOCK : ", "1 Location(s)"),
                    row("LOW STOCK : ", "5 Item(s)"),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  TableRow row(String title, String value) {
    return TableRow(children: [
      TableCell(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      )),
      TableCell(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(value),
      )),
    ]);
  }
}
