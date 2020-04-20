import 'package:mockup_gems/utils/bloc/bloc_technician.dart';
import 'package:flutter/material.dart';
import 'package:mockup_gems/utils/constant.dart';
import 'package:mockup_gems/utils/widget/dialog.dart';

class RouteEngineer extends StatefulWidget {
  final BlocTechnician bloc;

  RouteEngineer({BlocTechnician value}) : this.bloc = value ?? BlocTechnician();

  @override
  _RouteEngineerState createState() => _RouteEngineerState();
}

class _RouteEngineerState extends State<RouteEngineer> {
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Material Requisition Form"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          _Info(),
          Divider(color: Colors.black38),
          _Title(widget.bloc),
          StreamBuilder<List<Item>>(
            stream: widget.bloc.stream,
            builder: (ctx, snapshot) {
              if (snapshot.data == null || snapshot.error != null)
                return Container();
              else if (snapshot.data.length == 0) 
                return Container();

              return _ListView(snapshot.data, widget.bloc);
            },
          ),
          SizedBox(height: 70),
        ]),
      ),
      floatingActionButton: _FloatingButton(widget.bloc),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
          row("Request Date : ", "02 Mac 2020"),
          row("Request By : ", "Muhammad Zaid"),
          row("WO No : ", "WO0014"),
          row("Priority : ", "High"),
          row("Locaiton : ", "BNM"),
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

class _Title extends StatelessWidget {
  final BlocTechnician bloc;

  _Title(this.bloc);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onPressed(context),
      title: Text(
        "Material",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: Icon(Icons.add, color: Colors.grey),
    );
  }

  void onPressed(BuildContext context) =>
      Navigator.pushNamed(context, routeTechnicianDetail).then(
        (value) => value != null ? bloc.setSink(value) : null,
      );
}

class _ListView extends StatefulWidget {
  final List<Item> items;
  final BlocTechnician bloc;

  _ListView(this.items, this.bloc);

  @override
  _ListViewState createState() => _ListViewState();
}

class _ListViewState extends State<_ListView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: widget.items
          .map<Widget>((f) => _buildItem(widget.items.indexOf(f) + 1, f))
          .toList(),
    );
  }

  Widget _buildItem(int index, Item item) {
    return ExpansionTile(
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          index.toString() + '.  ' + item.name,
          overflow: TextOverflow.fade,
        ),
      ),
      subtitle: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.edit, color: colorTheme2),
            onPressed: () => Navigator.pushNamed(context, routeTechnicianDetail,
                    arguments: item)
                .then((value) => value != null
                    ? widget.bloc.replaceItem(item, value)
                    : null),
          ),
          IconButton(
            icon: Icon(Icons.delete, color: colorTheme4),
            onPressed: () => widget.bloc.removeItem(item),
          ),
          Spacer(),
          IconButton(
              icon: Icon(Icons.remove, color: Colors.grey),
              onPressed: () => setState(item.minusQuantity)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              item.quantity.toString(),
              style: TextStyle(fontSize: 20),
            ),
          ),
          IconButton(
            icon: Icon(Icons.add, color: Colors.grey),
            onPressed: () => setState(item.addQuantity),
          ),
        ],
      ),
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 16),
            child: Text(item.desc != null ? item.desc : 'no description'),
          ),
        ),
      ],
    );
  }
}

class _FloatingButton extends StatelessWidget {
  final BlocTechnician bloc;

  _FloatingButton(this.bloc);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[reject(context), SizedBox(width: 20), submit(context)],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Widget submit(BuildContext context) => FloatingActionButton.extended(
        heroTag: "submit",
        onPressed: () => submitPressed(context),
        label: Text("Submit"),
        backgroundColor: colorTheme2,
      );

  Widget reject(BuildContext context) => FloatingActionButton.extended(
        heroTag: "reject",
        onPressed: () => rejectPressed(context),
        label: Text("Reject"),
        backgroundColor: colorTheme4,
      );

  void submitPressed(BuildContext context) {
      Navigator.pushNamed(context, routeInventory);
  }

  void rejectPressed(BuildContext context) {
    var dialog = CustomDialog(
      rootPage: "/workorder",
      title: "Remark",
      description: "Remark",
      buttonText: "Okay",
      secondButton: false,
      cancel: true,
      okayTapped: () {
        Navigator.pop(context);
      },
      image: Image.asset(
        "assets/icon_trans.png",
        height: 40,
      ),
      remarkTapped: (text) {
        bloc.type = ScreenType.forTechnician;
        bloc.setComment(text);
        
        Navigator.pushReplacementNamed(context, routeTechnician, arguments: bloc);
      },
    );

    showDialog(context: context, builder: (BuildContext context) => dialog);
  }
}
