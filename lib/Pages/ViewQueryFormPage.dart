import 'dart:convert';
import 'dart:ffi';
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
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class ViewQueryFormPage extends StatefulWidget{
  const ViewQueryFormPage({super.key});

  @override
  State<ViewQueryFormPage> createState() => _ViewQueryFormPageState();
}

class _ViewQueryFormPageState extends State<ViewQueryFormPage> {
  bool _isLoading=false;
  Map<String,dynamic>visitorData={};
  List<dynamic>visitorDataList=[];
  final int _pageSize = 10;
  int _currentPage = 0;
  List<dynamic> _currentPageData = [];
  final _pageController=PageController();
  int totalPages=1;

  void _loadPage() {
    int startIndex = _currentPage * _pageSize;
    int endIndex = startIndex + _pageSize;
    totalPages = (visitorDataList.length / _pageSize).ceil();
    if (startIndex < visitorDataList.length) {
      _currentPageData = visitorDataList.sublist(
        startIndex,
        endIndex > visitorDataList.length ? visitorDataList.length : endIndex,
      );
    } else {
      _currentPageData = [];
    }

    setState(() {});
  }

  // Function to go to the next page
  void _nextPage() {
    if ((_currentPage + 1) * _pageSize < visitorDataList.length) {
      _currentPage++;
      setState(() {

      });
      _loadPage();

    }
  }
  // Function to go to the previous page
  void _previousPage() {
    if (_currentPage > 0) {
      _currentPage--;
      setState(() {

      });
      _loadPage();

    }
  }

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
            _loadPage();
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
         if(_isLoading)
           Container(
             height: double.infinity,
             width: double.infinity,
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
         Column(
           children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 ElevatedButton(
                   onPressed: _previousPage,
                   style:  ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(AppColors.primaryColor),
                        ),
                   child: Text('Previous',style: TextStyle(color: AppColors.textColorWhite),),
                 ),
                 SizedBox(width: 20),
                 ElevatedButton(
                   style:  ButtonStyle(
                 backgroundColor: WidgetStatePropertyAll<Color>(AppColors.primaryColor),
                          ),
                   onPressed: _nextPage,
                   child: Text('   Next  ',style: TextStyle(color: AppColors.textColorWhite),),
                 ),
               ],
             ),

             AnimatedSmoothIndicator(
               activeIndex:_currentPage ,
               count: totalPages,
               effect: SlideEffect(
                   // spacing:  8.0,
                   // radius:  4.0,
                   // dotWidth:  24.0,
                   // dotHeight:  16.0,
                   // paintStyle:  PaintingStyle.stroke,
                   // strokeWidth:  1.5,
                   // dotColor:  Colors.grey,
                   activeDotColor: AppColors.primaryColor
               ),
             ),

             Expanded(
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Scrollbar(
                   thumbVisibility: true,
                   child: ListView.builder(itemCount:_currentPageData.length ,
                    itemBuilder:(context,index){
                     return  CustomWidgets.customVisitorCard(
                         _currentPageData[index]['name'],_currentPageData[index]['email'],_currentPageData[index]['purpose'],
                         _currentPageData[index]['phone'].toString(),_currentPageData[index]['alternate_phone'].toString(),
                         _currentPageData[index]['contact_person'],_currentPageData[index]['address'],
                         _currentPageData[index]['current_date'],(){
                           Navigator.pushReplacement(context,
                               MaterialPageRoute(builder: (_)=>EditVisitorPage(
                                   visitorName: _currentPageData[index]['name'].toString(),
                                   email:_currentPageData[index]['email'].toString() ,
                                   phone: _currentPageData[index]['phone'].toString(),
                                   altPhone:_currentPageData[index]['alternate_phone'].toString() ,
                                   contactPerson:_currentPageData[index]['contact_person'].toString(),
                                   address: _currentPageData[index]['address'].toString(),
                                   id: _currentPageData[index]['id'].toString(), purpose:_currentPageData[index]['purpose'].toString() )));
                     });

                   }),
                 ),
               ),
             ),


           ],
         ),
       ],
     ),
   );
  }
}