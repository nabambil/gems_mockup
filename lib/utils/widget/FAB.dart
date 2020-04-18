import 'package:flutter/material.dart';
import '../constant.dart';

class AwesomeFAB extends StatefulWidget {
  @override
  _AwesomeFABState createState() => _AwesomeFABState();
}

class _AwesomeFABState extends State<AwesomeFAB> with SingleTickerProviderStateMixin{

  final double _fabHeight = -17.0;
  final Curve _curve = Curves.easeOut;

  AnimationController _animationController;
  Animation<Color> _opacity;
  Animation<double> _matrixY;
  Animation<double> _animateIcon;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: Duration(milliseconds: 300), vsync: this)
    ..addListener((){
      setState(() {});
      if (_animationController.status == AnimationStatus.dismissed)
        Navigator.pop(context);
    });

    _animateIcon = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    
    _opacity = ColorTween(
      begin: Colors.transparent,
      end: Colors.black.withOpacity(0.7),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval( 0.00, 1.00, curve: Curves.linear ),
    ));

    _matrixY = Tween<double>(
      begin: 60.0,
      end: -15.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        color: _opacity.value,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          matrix(y: _matrixY.value *5.0, child: container(colorTheme2, "My Dashboard", value: "My Dashboard", icon: Icons.assessment)),
          matrix(y: _matrixY.value *4.0, child: container(colorTheme2, "My Check Out", value: "My Check Out", icon: Icons.assignment_late)),
          matrix(y: _matrixY.value *3.0, child: container(colorTheme2, "My Check In", value: "My Check In", icon: Icons.assignment_turned_in)),
          matrix(y: _matrixY.value *2.0, child: container(colorTheme2, "My Stock",value: "My Stock", icon: Icons.category)),
          matrix(
            y: _fabHeight *1.0, 
            child: container(
              colorTheme1, "", 
              aIcon:  AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                progress: _animateIcon,
                color: Colors.white,
              )
            )
          )
        ],
      )
    );
  }

  Transform matrix({double y,Widget child}) => new Transform(
    transform: Matrix4.translationValues(0.0, y, 0.0),
    child: child,
  );

  Widget container(color, text, {String value, IconData icon, AnimatedIcon aIcon}) => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
      new Text(
        text, 
        style: TextStyle(
          fontFamily: "Avenir",
          color: Colors.white, 
          fontSize: 16.0, 
          fontWeight: FontWeight.normal,
          decoration: TextDecoration.none,
        )
      ),
      new RawMaterialButton(
        onPressed: value == null ? () => _animationController.reverse() : () => Navigator.pop(context, value),
        child: aIcon == null? new Icon(
          icon,
          color: Colors.white,
          size: 27.0,
        ): aIcon,
        shape: new CircleBorder(),
        elevation: 2.0,
        fillColor: color,
        padding: const EdgeInsets.all(15.0),
      )
    ],
  );
}