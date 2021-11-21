import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({ Key? key ,required this.title, required this.selected , this.onTap}) : super(key: key,);
  final String title;
  final bool selected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/30
        ,vertical: MediaQuery.of(context).size.height/130
        ),
        decoration: BoxDecoration(
    
        color: selected? const Color(0xffFFC200):Colors.transparent,
        borderRadius: BorderRadius.circular(16)
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(
           horizontal: MediaQuery.of(context).size.width/20
          ),
          child: Center(child: Text(
            title,
             style:  TextStyle(
               fontWeight: FontWeight.w600,
                fontSize: 17 , 
                fontFamily: "Arial",
                 color: selected?const Color(0xffffffff):const Color(0xff707070)),)),
        ),
      ),
    );
  }
}