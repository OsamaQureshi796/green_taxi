import 'package:flutter/material.dart';
import 'package:green_taxi/utils/app_colors.dart';

Widget DecisionButton(String icon,String text,Function onPressed,double width,{double height = 50}){
  return InkWell(
    onTap: ()=> onPressed(),
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
       borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(

            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            spreadRadius: 1

          )
        ]
      ),
      child: Row(
        children: [
          Container(
            width: 65,
            height: height,
            decoration: BoxDecoration(
              color: AppColors.greenColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8),bottomLeft: Radius.circular(8)),

            ),
            child: Center(child: Image.asset(icon,width: 30,),),
          ),

          Expanded(child: Text(text,style: TextStyle(color: Colors.black),textAlign: TextAlign.center,)),





        ],
      ),
    ),
  );
}