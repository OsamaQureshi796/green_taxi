import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';

class VehicalModelPage extends StatefulWidget {
  VehicalModelPage({Key? key,required this.onSelect,required this.selectedModel}) : super(key: key);

  final String selectedModel;
  final Function onSelect;

  @override
  State<VehicalModelPage> createState() => _VehicalModelPageState();
}

class _VehicalModelPageState extends State<VehicalModelPage> {


  List<String> vehicalModel = [
    'Amanti',
    'Borrego',
    'Cadenza',
    'Forte',
    'K900',
    'Niro',
    'Optima',
    'Rio',
    'Rondo',
    
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        Text('What model of vehicle is it ?',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black),),

        SizedBox(height: 10,),


        Expanded(child: ListView.builder(itemBuilder: (ctx,i){
          return ListTile(
            onTap: ()=> widget.onSelect(vehicalModel[i]),
            visualDensity: VisualDensity(vertical: -4),
            title: Text(vehicalModel[i]),
            trailing: widget.selectedModel == vehicalModel[i]?Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: AppColors.greenColor,
                child: Icon(Icons.check,color: Colors.white,size: 15,),
              ),
            ): SizedBox.shrink(),
          );
        },itemCount: vehicalModel.length,)),

      ],
    );
  }
}
