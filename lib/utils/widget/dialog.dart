import 'package:flutter/material.dart';
import 'package:mockup_gems/utils/widget/button.dart';
import 'package:mockup_gems/utils/constant.dart';
import 'package:toast/toast.dart';

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 40.0;
}

typedef void VoidCallback(String text);

class CustomDialog extends StatelessWidget {
  final VoidCallback remarkTapped;
  final String title, description, buttonText, buttonText2;
  final Image image;
  final bool cancel, useDescription;
  final bool secondButton;
  final String rootPage;
  String remark;
  final Function okayTapped;
  final Function secondTapped;
  final bool showError = false;

  var controller = TextEditingController();

  CustomDialog(
      {this.title,
      @required this.description,
      @required this.buttonText,
      this.useDescription = false,
      this.buttonText2,
      this.cancel = false,
      this.image,
      this.rootPage,
      this.remarkTapped,
      this.okayTapped,
      this.secondButton,
      this.secondTapped}) {
    controller.addListener(_updateRemark);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: title == "Remark"
          ? remarkDialogContent(context)
          : dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              title == null
                  ? Container()
                  : Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
              SizedBox(height: 16.0),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 24.0),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  cancel == false
                      ? Container()
                      : FlatButton(
                          onPressed: () {
                            print("keluar");
                            Navigator.of(context).pop();  // To close the dialog
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                  Button(
                    text: buttonText,
                    onPressed: () {
                      if (okayTapped != null) {return okayTapped();}
                      if (rootPage == null)
                        Navigator.of(context).pop();
                      else
                        Navigator.popUntil(
                            context,
                            ModalRoute.withName(
                                rootPage)); // To close the dialog
                    },
                    color: colorTheme2,
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          left: Consts.padding,
          right: Consts.padding,
          child: Material(
            elevation: 6.0,
            child: Padding(
              padding: const EdgeInsets.all(Consts.padding),
              child: image,
            ),
            shape: CircleBorder(),
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  _updateRemark() {
    remark = controller.text;
  }

  remarkDialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              title == null || useDescription
                  ? Container()
                  : Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
              SizedBox(height: 16.0),
              useDescription? Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ) : TextField(
                maxLength: 60,
                controller: controller,
              ),
              SizedBox(height: 24.0),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  cancel == false
                      ? Container()
                      : FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // To close the dialog
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                  secondButton == false
                      ? Container()
                      : FlatButton(
                          onPressed: () {
                            if(useDescription) secondTapped();
                            else if (controller.text.length == 0)
                              Toast.show(
                                  "Please enter remark before submit.", context,
                                  gravity: Toast.TOP);
                            else if (controller.text.length <= 60)
                              secondTapped(controller.text);
                            else
                              Toast.show("Maximum 60 character", context,
                                  gravity: Toast.TOP);
                          },
                          child: Text(
                            buttonText2,
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                  Button(
                    text: buttonText,
                    onPressed: () {
                      if(useDescription) remarkTapped("");
                      else if (controller.text.length == 0)
                        Toast.show(
                            "Please enter remark before submit.", context,
                            gravity: Toast.TOP);
                      else if (controller.text.length <= 60)
                        remarkTapped(controller.text);
                      else
                        Toast.show("Maximum 60 character", context,
                            gravity: Toast.TOP);
                    },
                    color: colorTheme2,
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          left: Consts.padding,
          right: Consts.padding,
          child: Material(
            elevation: 6.0,
            child: Padding(
              padding: const EdgeInsets.all(Consts.padding),
              child: image,
            ),
            shape: CircleBorder(),
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
