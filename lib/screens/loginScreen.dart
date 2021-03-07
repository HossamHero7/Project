import 'dart:ui';
import 'package:reine_tech_shopping/const.dart';
import 'package:reine_tech_shopping/provider/adminMode.dart';
import 'package:reine_tech_shopping/provider/modelHud.dart';
import 'package:reine_tech_shopping/screens/HomePageScreen.dart';
import 'package:reine_tech_shopping/screens/SignUpScreen.dart';
import 'package:reine_tech_shopping/widgets/customIcon.dart';
import 'package:reine_tech_shopping/widgets/customText.dart';
import 'package:reine_tech_shopping/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:reine_tech_shopping/provider/adminMode.dart';
import 'package:reine_tech_shopping/admin/adminScreen.dart';
class LoginScreen extends StatelessWidget {
  final GlobalKey <FormState> _globalKey=GlobalKey<FormState>();
  static String id='LoginScreen';
  final adminPass="admin1234";
  String email,password;
  bool isAdmin=false;
  final _auth=Auth();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: mainColor,
      body:ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).loading,
        child:Form(
          key: _globalKey,
          child:ListView(
            children:<Widget>[
              CustomIcon(),
              SizedBox(
                height: h*0.1,
              ),
              CustomText(
                onClick:(value){
                  email=value;
                }
                ,hint: "Email",icon: Icons.email, check: false,),
              SizedBox(
                height: h*0.01,
              ),
              CustomText(
                onClick: (value){
                  password=value;
                },
                icon: Icons.lock, hint: "Password", check: true,),
              SizedBox(
                height: h*0.05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 130),
                child:Builder(
                  builder:(context)=>FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: (){
                      _validate(context);
                    },
                    color: Colors.black,
                    child:Text("Sign in",style: TextStyle(color: Colors.white),),
                  ),
                ),
              ),
              SizedBox(
                height: h*0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Don't have an account ? ",style:TextStyle(fontSize:16),),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, SignUp.id);
                    },
                    child:Text("Sign up",style:TextStyle(color: Colors.blueAccent,fontSize: 16),),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Provider.of<AdminMode>(context,listen: false).changeIsAdmin(true);
                        },
                      child:Text(
                        "I'm an admin",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Provider.of<AdminMode>(context).isAdmin?Colors.white:Colors.black,
                        ),
                      ),
                    ),
                    ),
                    Expanded(
                      child: GestureDetector(
                      onTap:() {
                        Provider.of<AdminMode>(context,listen: false).changeIsAdmin(false);
                      },
                      child:Text(
                        "I'm a user",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: !Provider.of<AdminMode>(context).isAdmin?Colors.white:Colors.black,
                        ),
                      ),
                    ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validate(BuildContext context) async{
    final modelHud=Provider.of<ModelHud>(context,listen: false);
    modelHud.changeLoad(true);
    if(_globalKey.currentState.validate()){
      _globalKey.currentState.save();
      if(Provider.of<AdminMode>(context,listen: false).isAdmin) {
          if(password==adminPass){
            try {
             await _auth.signIn(email.trim(), password.trim());
              Navigator.pushNamed(context, adminScreen.id);
            }catch(e) {
              modelHud.changeLoad(false);
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                    e.message
                ),
              )
              );
            }
          }
          else {
            modelHud.changeLoad(false);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                  "Something went wrong !"
              ),
            )
            );
          }
      }
      else {
        try {
          await _auth.signIn(email.trim(), password.trim());
          Navigator.pushNamed(context, HomePage.id);
        }catch(e) {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                e.message
              ),
          )
          );
        }
      }
    }
    modelHud.changeLoad(false);
  }
}
