import 'package:reine_tech_shopping/provider/modelHud.dart';
import 'package:reine_tech_shopping/screens/loginScreen.dart';
import 'package:reine_tech_shopping/services/auth.dart';
import 'package:reine_tech_shopping/widgets/customIcon.dart';
import 'package:reine_tech_shopping/widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../const.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reine_tech_shopping/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:reine_tech_shopping/screens/HomePageScreen.dart';
class SignUp extends StatelessWidget {
  final GlobalKey <FormState> _globalKey=GlobalKey<FormState>();
  static String id = "SignupScreen";
  final _auth = Auth();
  String email,password;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: mainColor,
      body: ModalProgressHUD(
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
                onClick: (value){

                },
                hint: "User name",icon: Icons.person, check: false,
              ),
              SizedBox(
                height: h*0.01,
              ),
              CustomText(
                onClick: (value){
                  email=value;
                },
                hint: "Email",icon: Icons.email, check: false,),
              SizedBox(
                height: h*0.01,
              ),
              CustomText(
                onClick: (value){
                  password=value;
                },
                icon: Icons.lock, hint: "Password", check: true,
              ),
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
                    onPressed: () async{
                      final modelhud=Provider.of<ModelHud>(context,listen: false);
                      modelhud.changeLoad(true);
                      if(_globalKey.currentState.validate()){
                        _globalKey.currentState.save();
                        try {
                          //  print(email);
                          //  print(password);
                          final authResult = await _auth.addUser(email.trim(), password.trim());
                          modelhud.changeLoad(false);
                          Navigator.pushNamed(context,HomePage.id);
                        }catch(e){
                          modelhud.changeLoad(false);
                          Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.message),
                              )
                          );
                        }
                      }

                      modelhud.changeLoad(false);
                    },
                    color: Colors.black,
                    child:Text("Sign up",style: TextStyle(color: Colors.white),),
                  ),
                ),
              ),
              SizedBox(
                height: h*0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Have an account ? ",style:TextStyle(fontSize:16),),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context,LoginScreen.id);
                    },
                    child:Text("Sign in",style:TextStyle(color: Colors.blueAccent,fontSize: 16),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}