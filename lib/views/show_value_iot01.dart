// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ShowValueIoT01 extends StatefulWidget {
  const ShowValueIoT01({super.key});

  @override
  State<ShowValueIoT01> createState() => _ShowValueIoT01State();
}

class _ShowValueIoT01State extends State<ShowValueIoT01> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 134, 13, 5),
        title: Text(
          'ข้อมูลแอร์ทั้งหมด',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
