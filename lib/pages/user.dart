import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';



class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 241, 241),
      appBar: AppBar(
        title: Text(
          '12:23',
          style: GoogleFonts.alata(
            textStyle: Theme.of(context).textTheme.headline6,
            fontSize: 15,
            fontStyle: FontStyle.normal,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            // Action untuk kembali
          },
        ),
        actions: [
          Icon(Icons.signal_cellular_4_bar_sharp),
          Icon(Icons.wifi),
          Icon(Icons.battery_full),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Akun Saya",
                style: GoogleFonts.montserrat(
                  textStyle: Theme.of(context).textTheme.headline6,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 8.0),
              Container(
                color: const Color.fromARGB(255, 241, 241, 241),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 30.0), // Atur jarak kanan antara gambar dan teks
                              child: Image.asset(
                                'images/d.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 8.0),
                                    Text(
                                      "Keira Herlambang",
                                      style: GoogleFonts.poppins(
                                        textStyle: Theme.of(context).textTheme.headline6,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  "ilpengding@gmail.com",
                                  style: GoogleFonts.portLligatSans(
                                    textStyle: Theme.of(context).textTheme.headline6,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  "088123146555",
                                  style: GoogleFonts.openSans(
                                    textStyle: Theme.of(context).textTheme.headline6,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                ),
              ),
               SizedBox(height: 20),
                Column(
                  children: [
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                                        
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, 
                        ),
                        child: Text("Ubah Profil",
                        style: GoogleFonts.pavanam(
                            textStyle: Theme.of(context).textTheme.displayLarge,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 20),
             Container(
              margin: EdgeInsets.symmetric(horizontal: 20), 
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Alamat",
                    style: GoogleFonts.poppins(
                      textStyle: Theme.of(context).textTheme.headline6,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Jl. HR. Rasuna Said",
                    style: GoogleFonts.openSans(
                      textStyle: Theme.of(context).textTheme.headline6,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                    height: 1,
                    thickness: 1,
                  ),
                ],
              ),
            ),


            ],
          ),
        ),
      
    );
  }
}