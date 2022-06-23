import 'package:flutter/material.dart';
import 'package:mockup_gems/route/storekeeper/list_checkin.dart';
import 'package:mockup_gems/route/storekeeper/list_stock.dart';
import 'package:mockup_gems/route/storekeeper/list_task.dart';
import 'package:mockup_gems/route/storekeeper/thresholdList.dart';
import 'package:mockup_gems/utils/bloc/bloc_inventory.dart';
import 'package:mockup_gems/utils/constant.dart';
import 'package:mockup_gems/utils/widget/FAB.dart';

import 'dashboard.dart';
import 'list_checkout.dart';

class Homepage extends StatefulWidget {
  final BlocInventory bloc = BlocInventory();

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  TabController _controller;

  _HomepageState() {
    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(widget.bloc),
      body: _Body(widget.bloc),
      floatingActionButton:
          _controller.index == 0 ? _FloatingButton(widget.bloc) : null,
    );
  }
}

class _AppBar extends StatelessWidget with PreferredSizeWidget {
  final BlocInventory _bloc;

  _AppBar(this._bloc);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: StreamBuilder<Object>(
        stream: _bloc.view$,
        builder: (ctx, snapshot) =>
            Tab(text: "Inventory - " + (snapshot.data ?? "")),
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: leading,
      actions: <Widget>[_SearchButton(), SizedBox(width: 6)],
    );
  }

  get leading {
    return Container(
      child: Image.asset("assets/icon_trans.png", height: 30, width: 30),
      padding: EdgeInsets.all(14),
    );
  }

  get specialTab {
    return StreamBuilder<String>(
      stream: _bloc.view$,
      builder: (ctx, snapshot) => Tab(text: snapshot.data ?? "My Stock"),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}

class _Body extends StatelessWidget {
  final BlocInventory _bloc;

  _Body(this._bloc);

  @override
  Widget build(BuildContext context) {
    return firstTab;
  }

  get secondTab {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _Header(_bloc),
          Container(
            width: double.infinity,
            color: colorTheme3,
            height: 0.5,
          ),
          TaskList(_bloc),
        ],
      ),
    );
  }

  get firstTab {
    return StreamBuilder<String>(
        stream: _bloc.view$,
        builder: (ctx, snapshot) {
          switch (snapshot.data) {
            case "My Stock":
              return MyStock(_bloc);
            case "My Check In":
              return CheckInList();
            case "My Check Out":
              return CheckOutList();
            case "My Dashboard":
              return MyDashboard();
            case "Threshold":
              return ThresholdListView();
            case "My Task":
              return secondTab;
            default:
              return Center(child: Text(snapshot.data ?? "My Stock"));
          }
        });
  }
}

class _Header extends StatelessWidget {
  final BlocInventory bloc;
  _Header(this.bloc);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _DropdownFilter(bloc),
          RaisedButton(
            onPressed: () => Navigator.pushNamed(context, routePurchaseRequest),
            child: Row(
              children: <Widget>[
                Icon(Icons.send, color: Colors.white),
                SizedBox(width: 6),
                Text("10", style: TextStyle(color: Colors.white, fontSize: 16)),
              ],
            ),
            color: colorTheme2,
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(18.0),
            ),
          )
        ],
      ),
    );
  }
}

class _DropdownFilter extends StatelessWidget {
  final BlocInventory bloc;

  _DropdownFilter(this.bloc);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: bloc.selected$,
      builder: (ctx, snapshot) => DropdownButton<String>(
        underline: Container(),
        value: snapshot.data,
        items: statuses
            .map((f) => DropdownMenuItem(child: Text(f), value: f))
            .toList(),
        onChanged: bloc.setSelected,
      ),
    );
  }
}

class _SearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.search,
        size: 30,
      ),
      onPressed: () {},
    );
  }
}

class _FloatingButton extends StatelessWidget {
  final BlocInventory bloc;

  _FloatingButton(this.bloc);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: bloc.view$,
      builder: (ctx, snapshot) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          if (snapshot.data == "My Check In")
            FloatingActionButton(
              heroTag: "Submit",
              child: Icon(Icons.add),
              onPressed: () => Navigator.pushNamed(context, routeStockIn),
            ),
          if (snapshot.data == "My Check In") SizedBox(width: 12),
          // if (snapshot.data == "My Stock")
          //   FloatingActionButton(
          //     heroTag: "Submit",
          //     child: Icon(Icons.add),
          //     onPressed: () {
          //       Navigator.pushNamed(context, routeRegisterItem);
          //     },
          //   ),
          // SizedBox(width: 12),
          FloatingActionButton(
            heroTag: "FAB",
            child: new Icon(Icons.menu),
            backgroundColor: colorTheme1,
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (ctx, _, __) => AwesomeFAB(),
                ),
              ).then((value) => value == null ? null : bloc.setView(value));
            },
          ),
        ],
      ),
    );
  }
}
