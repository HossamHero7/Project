import 'package:flutter/cupertino.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 70),
      child:Container(
        padding: EdgeInsets.only(top: 0),
        height: 150,
        child: Stack(
          alignment: Alignment.center,
          children:<Widget>[
            Positioned(
              top: 0,
              child:Image(image: AssetImage("images/Centeral/startImg.png"),height: 130,),
            ),
            Positioned(
              bottom: 0,
              child:
              Text("ReineTech Shopping",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily:("Schyler"),
                  fontSize: 27,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
