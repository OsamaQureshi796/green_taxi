import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VehicalColorPage extends StatefulWidget {
  const VehicalColorPage({Key? key,required this.onColorSelected}) : super(key: key);

   final Function onColorSelected;

  @override
  State<VehicalColorPage> createState() => _VehicalColorPageState();
}

class _VehicalColorPageState extends State<VehicalColorPage> {



  String dropdownvalue = 'Pick a color';

  List<String> colors = [
    'Pick a color',
    'White',
    "Red",
    "Black"
  ];

  buildDropDown(
      ) {
    return Container(
      width: Get.width,
      margin: EdgeInsets.symmetric(horizontal: 2),
      padding: EdgeInsets.symmetric(horizontal: 10),
      // height: 50,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 2,
                blurRadius: 1)
          ],
          borderRadius: BorderRadius.circular(8)),
      child: DropdownButton(

        // Initial Value
        value: dropdownvalue,

        isExpanded: true,
        underline: Container(),

        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),

        // Array list of items
        items: colors.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (String? newValue) {
          setState(() {
            dropdownvalue = newValue!;
          });
          widget.onColorSelected(newValue!);
        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        Text('What color of vehicle is it ?',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black),),

        SizedBox(height: 30,),

        buildDropDown(),



      ],
    );
  }
}
