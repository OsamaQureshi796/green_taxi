import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';

class VehicalMakePage extends StatefulWidget {
  VehicalMakePage({Key? key,required this.onSelect,required this.selectedVehical}) : super(key: key);

  final String selectedVehical;
  final Function onSelect;

  @override
  State<VehicalMakePage> createState() => _VehicalMakePageState();
}

class _VehicalMakePageState extends State<VehicalMakePage> {


  List<String> vehicalMake = [
    'Honda',
    'GMC',
    'Ford',
    'Kia',
    'Leusx',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        Text('What make of vehicle is it ?',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black),),

        SizedBox(height: 10,),

        Expanded(
          child: ListView.builder(itemBuilder: (ctx,i){
            return ListTile(
              onTap: ()=> widget.onSelect(vehicalMake[i]),
              visualDensity: VisualDensity(vertical: -4),
              title: Text(vehicalMake[i]),
              trailing: widget.selectedVehical == vehicalMake[i]?Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: AppColors.greenColor,
                  child: Icon(Icons.check,color: Colors.white,size: 15,),
                ),
              ): SizedBox.shrink(),
            );
          },itemCount: vehicalMake.length),
        ),

      ],
    );
  }
}
