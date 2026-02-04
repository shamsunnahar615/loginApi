import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:Colors.cyan,
        body:Padding(
          padding:EdgeInsets.symmetric(vertical:20.w),
          child: Column(
            children: [
              IconButton(onPressed:(){Navigator.pop(context);}, icon:Icon(Icons.arrow_back,color:Colors.white))
            ],
          ),
        ),
      ),
    );
  }
}
