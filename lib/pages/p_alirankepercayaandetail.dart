import 'package:flutter/material.dart';
import 'package:kejaksaan/models/modelpengawasan.dart';
import 'package:google_fonts/google_fonts.dart';

class AliranKepercayaanDetail extends StatelessWidget {
   final Datum? data;

   const AliranKepercayaanDetail(this.data, {super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Color.fromRGBO(107, 140, 66, 1),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person),
                         Text(
                          data?.namapelapor ?? "",
                          style: GoogleFonts.firaSans(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ],
                ), 
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.phone),
                         Text(
                          data?.nohp ?? "",
                          style: GoogleFonts.firaSans(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ],
                ), 
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                         Text(
                          data?.ktp ?? "",
                          style: GoogleFonts.firaSans(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ],
                ), 
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  data?.laporan ?? "",
                  style: GoogleFonts.firaSans(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}