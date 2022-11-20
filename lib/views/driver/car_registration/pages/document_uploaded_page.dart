import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DocumentUploadedPage extends StatefulWidget {
  const DocumentUploadedPage({Key? key}) : super(key: key);



  @override
  State<DocumentUploadedPage> createState() => _DocumentUploadedPageState();
}

class _DocumentUploadedPageState extends State<DocumentUploadedPage> {




  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        Text('Upload Documents',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black),),

        SizedBox(height: 30,),


        Container(
          width: Get.width,
          height: Get.height*0.1,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffE3E3E3).withOpacity(0.4),
              border: Border.all(color: Color(0xff2FB654).withOpacity(0.26),width: 1)
          ),
          child: Row(
            children: [
              Icon(Icons.cloud_upload,size: 40,color: Color(0xff7D7D7D),),

              const SizedBox(width: 10,),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start ,
                children: [

                  Text('Vehicle Registration',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black),),
                  Text('waiting For Approval',style: TextStyle(fontSize: 12,color: Color(0xff62B62F)),),


                ],
              ),
            ],
          ),
        ),


      ],
    );
  }
}
