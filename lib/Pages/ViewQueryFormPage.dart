import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hiet_official_project/API/Api.dart';
import 'package:hiet_official_project/Pages/EditVisitorPage.dart';
import 'package:hiet_official_project/Utils/AppColors.dart';
import 'package:hiet_official_project/Utils/CustomWidgets.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:lottie/lottie.dart';
class ViewQueryFormPage extends StatefulWidget{
  const ViewQueryFormPage({super.key});

  @override
  State<ViewQueryFormPage> createState() => _ViewQueryFormPageState();
}

class _ViewQueryFormPageState extends State<ViewQueryFormPage> {
  bool _isLoading=false;
  Map<String,dynamic>visitorData={};
  List<dynamic>visitorDataList=[];

  Future getVisitorList() async{

    setState(() {
      _isLoading=true;
    });
    const  timeoutDuration= Duration(seconds: 10);
    try{

      String uri = Api.visitorList;
      print(uri);
    final visitorListRequest =  http.get(
      Uri.parse(uri),);

    final response= await Future.any([visitorListRequest,Future.delayed(timeoutDuration)]);

      if(response!=null){
        if(response.statusCode==200){
          setState(() {

            visitorData = jsonDecode(response.body);
            print(visitorData);
            visitorDataList=visitorData['data'];
          });
        }
      }
      else{
        CustomWidgets.showQuickAlert('Data Fetch Error', 'error',context);

      }

    }
    catch(e){
      print("catch is running  $e");
      // showQuickAlert('Some Exception Occurred $e','error');
      // showSuccesAlert("Some Exception Running");
      CustomWidgets.showQuickAlert('Error', 'error',context);
    }
    setState(() {
      _isLoading=false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVisitorList();
  }


  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: CustomWidgets.customAppBAr('Query Forms'),
     body: Stack(
       children: [
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Scrollbar(
             thumbVisibility: true,
             child: ListView.builder(itemCount:visitorDataList.length ,
                 itemBuilder:(context,index){
                  return  CustomWidgets.customVisitorCard(
                      visitorDataList[index]['name'],visitorDataList[index]['email'],visitorDataList[index]['purpose'],
                      visitorDataList[index]['phone'].toString(),visitorDataList[index]['alternate_phone'].toString(),
                      visitorDataList[index]['contact_person'],visitorDataList[index]['address'],
                      visitorDataList[index]['current_date'],(){
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_)=>EditVisitorPage(
                                visitorName: visitorDataList[index]['name'].toString(),
                                email:visitorDataList[index]['email'].toString() ,
                                phone: visitorDataList[index]['phone'].toString(),
                                altPhone:visitorDataList[index]['alternate_phone'].toString() ,
                                contactPerson:visitorDataList[index]['contact_person'].toString(),
                                address: visitorDataList[index]['address'].toString(),
                                id: visitorDataList[index]['id'].toString(), purpose:visitorDataList[index]['purpose'].toString() )));
                  });

                }),
           ),
         ),
         if(_isLoading)
           Container(
             height: 700,
             width: 500,
             color: Colors.blue.withOpacity(0.2),
             child: Center(
               // child: CircularProgressIndicator(
               //   color: AppColors.primaryColor,
               // ),
               child: Lottie.asset('assets/animations/Loader.json',
                  width: 150,
                  height: 150),
             ),
           ),
       ],
     ),
   );
  }
}