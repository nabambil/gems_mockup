import 'package:flutter/material.dart';
import 'package:mockup_gems/utils/constant.dart';
import 'package:photo_view/photo_view.dart';
import 'package:toast/toast.dart';

class CheckinDetails extends StatelessWidget {
  final bool newUpload;

  const CheckinDetails({Key key, this.newUpload = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Check In Information"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _Info(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text(
                  "List of DO attachments : ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                IconButton(icon: Icon(Icons.add), onPressed: () {})
              ],
            ),
          ),
          AttachmentsDO(),
          Divider(color: Colors.black38),
          _ListView(newUpload),
        ],
      ),
    );
  }
}

class _Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Table(
        columnWidths: {
          0: FractionColumnWidth(.30),
        },
        children: <TableRow>[
          row("PR No : ", "PR023212G"),
          row("Do No : ", "DO023953"),
          row("Vendor Selection : ", "ABC Sdn. Bhd."),
          row("Request By : ", "Muhammad Nabil"),
          row("Date Time : ", "02 Mac 2020"),
          row("Total Price (RM) : ", "10,000.00"),
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

class _ListView extends StatelessWidget {
  final bool newUpload;

  const _ListView(this.newUpload);
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: 20),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: List.generate(
        10,
        (index) => _Material(
          index + 1,
          newUpload: newUpload,
        ),
      ),
    );
  }
}

class _Material extends StatelessWidget {
  final bool newUpload;

  final int index;

  _Material(this.index, {this.newUpload = false});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          index.toString() + '.  Material $index',
          overflow: TextOverflow.fade,
        ),
      ),
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        text(value: "Category A  |  Type A", top: 8.0),
        text(value: "Quantity : 10"),
      ]),
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 16),
            child: Text('no description'),
          ),
        ),
        if (newUpload)
          TextButton(
              onPressed: () => _showMyDialog(context),
              child: Text(
                "Report",
                style: TextStyle(color: colorTheme4),
              )),
      ],
    );
  }

  Widget text({@required String value, double top = 3.0, Color color}) {
    return Padding(
      padding: EdgeInsets.only(top: top),
      child: Text(
        value,
        style: TextStyle(color: color == null ? colorTheme3 : color),
      ),
    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Report Item'),
          content: TextField(
            decoration: InputDecoration(labelText: "Report : "),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                Navigator.of(context).pop();
                Toast.show("Report Submitted", context);
              },
            ),
          ],
        );
      },
    );
  }
}

class AttachmentsDO extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            3,
            (index) => TextButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ViewImage(
                        url:
                            "https://ohiostate.pressbooks.pub/app/uploads/sites/160/h5p/content/5/images/image-5bd08790e1864.png"))),
                child: Text("$index. File $index")),
          )),
    );
  }
}

class ViewImage extends StatelessWidget {
  final String url;

  const ViewImage({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoView(
      imageProvider: AssetImage("assets/large-image.jpg"),
    ));
  }
}
