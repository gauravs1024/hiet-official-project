import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'AdmQueryForm.dart';
import 'AppDrawerMenuScreen.dart';
import 'ViewQueryFormPage.dart';
class HomePage extends StatefulWidget{
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _controller=PageController();
  Widget CustomCard(String imagePath){
    return Card(
      margin: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 10,

    );
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     drawer: AppDrawerMenuScreen(),
     appBar:AppBar(
       centerTitle: true,
       backgroundColor: Color.fromRGBO(21, 90, 105, 1),
       title: Text(
         'Admission Query Page',
         style: TextStyle(color: Colors.white),
       ),
     ),
     body:Container(
       // decoration: BoxDecoration(
       //   gradient: LinearGradient(colors: [Color(0xFF0057B8), Color(0xFF1B6A78)],
       //     begin: Alignment.topLeft,
       //     end: Alignment.bottomRight,)
       // ),
       child: Stack(
         children: [
           Center(
             child: Container(
               width: 150,
               height: 150,
               child: Opacity(
                 opacity: 0.2,
                 child: Image.asset('assets/images/hiet-logo-clear-background.png',
                   fit: BoxFit.fill,
                 ),
               ),
             ),
           ),
           Column(
             children: [
               SizedBox(height: 20,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>const AdmissionQueryPage()));
                            //
                          },
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                              color: Colors.blue[300],),
                            height: 100,
                            width: 100,
                            child:Image.asset('assets/images/exam.png') ,
                          ),
                        ),
                        Text('Admission Query Form')
                      ],
                   ),
                   GestureDetector(
                     onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>const ViewQueryFormPage()));
                     },
                     child: Column(
                       children: [
                         Container(
                           padding: EdgeInsets.all(15),
                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                             color: Colors.green[300],),
                           height: 100,
                           width: 100,
                           child:Image.asset('assets/images/graduation.png') ,
                         ),
                         Text('View Query Form')
                       ],
                     ),
                   ),
                 ],
               ),
               // Container(
               //   height: 400,
               //   child: PageView(scrollDirection: Axis.horizontal,
               //     controller: _controller,
               //     children: [
               //       CustomCard('assets/images/calendar.png'),
               //       CustomCard('assets/images/calendar.png'),
               //       CustomCard('assets/images/calendar.png'),
               //     ],
               //   ),
               // ),
               // SmoothPageIndicator(
               //     controller: _controller,  // PageController
               //     count:3,
               //     effect: ExpandingDotsEffect(),  // your preferred effect
               //
               // )
             ],
           ),
         ],
       ),
     ),
   );
  }
}