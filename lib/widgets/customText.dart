import 'package:flutter/material.dart';

import '../const.dart';
class CustomText extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onClick;
  final bool check;
  CustomText({@required this.icon,@required this.hint,@required this.check,@required this.onClick});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child:TextFormField(
        validator:(value){
          if(value.isEmpty){
            return "The $hint is empty!";
          }
          if(value.length<8 && check) return "The Password length must be at least 8";
        },
        onSaved:onClick,
        cursorColor: Colors.blue,
        obscureText: check,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon,color: Colors.blue,),
          filled: true,
          fillColor: textColor,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.white,
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.white,
              )
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.white,
              )
          ),
        ),
      ),
    );
  }
}