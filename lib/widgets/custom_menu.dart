import 'package:flutter/material.dart';
class MyPopupMenuItem<T> extends PopupMenuItem<T>{
  final Widget child;
  final Function onClick;
  MyPopupMenuItem({@required this.child, @required this.onClick}) :
        super(child: child);
  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return MyPopMenuItemState();
  }
}
class MyPopMenuItemState<T,PopMenuItem> extends PopupMenuItemState<T,MyPopupMenuItem<T>>{

  @override
  void handleTap() {
    widget.onClick();
  }
}