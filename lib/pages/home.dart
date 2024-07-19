import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kejaksaan/pages/jms.dart';
import 'package:kejaksaan/pages/jmslist.dart';
import 'package:kejaksaan/pages/p_alirankepercayaan.dart';
import 'package:kejaksaan/pages/p_alirankepercayaanlist.dart';
import 'package:kejaksaan/pages/p_pegawai.dart';
import 'package:kejaksaan/pages/p_pegawailist.dart';
import 'package:kejaksaan/pages/p_pegawailist_admin.dart';
import 'package:kejaksaan/pages/p_tindakkorupsi.dart';
import 'package:kejaksaan/pages/p_tindakkorupsilist.dart';
import 'package:kejaksaan/pages/penyuluhanhukum.dart';
import 'package:kejaksaan/pages/penyuluhanlist.dart';
import 'package:kejaksaan/pages/poskopilkada.dart';
import 'package:kejaksaan/pages/poskopilkadalist.dart';
import 'package:kejaksaan/pages/user.dart';

class Home extends StatefulWidget {
  final bool isAdmin; // Pass the admin status through constructor

  const Home({Key? key, required this.isAdmin}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.black),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => User()), 
                );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 10),
                      Text(
                        "",
                        style: GoogleFonts.openSans(
                          textStyle: Theme.of(context).textTheme.headline6,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(107, 140, 66, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'images/a.png',
                        width: 480,
                        height: 250,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                            "PUSAT INFORMASI KEJAKSAAN TINGGI SUMATERA BARAT",
                            style: GoogleFonts.prozaLibre(
                              textStyle: Theme.of(context).textTheme.headline6,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                    ],
                    
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => widget.isAdmin
                        ? PengaduanPegawaiListAdmin() // Admin view
                        : PengaduanPegawaiList(), // User view
                  ),
                );
              },
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'images/c.png',
                            fit: BoxFit.cover, 
                            
                          ),
                          SizedBox(width: 4.0), 
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 8.0),
                                  Text(
                                    "Pengaduan Pegawai",
                                    style: GoogleFonts.openSans(
                                      textStyle: Theme.of(context).textTheme.displayLarge,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TindakKorupsiList()), 
                );
              },
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'images/c.png',
                            fit: BoxFit.cover, 
                            
                          ),
                          SizedBox(width: 4.0), 
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 8.0),
                                  Text(
                                    "Pengaduan Tindak Pindana Korupsi",
                                    style: GoogleFonts.openSans(
                                      textStyle: Theme.of(context).textTheme.displayLarge,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JMSList(isAdmin: widget.isAdmin)), 
                );
              },
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'images/c.png',
                            fit: BoxFit.cover, 
                            
                          ),
                          SizedBox(width: 4.0), 
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 8.0),
                                  Text(
                                    "JMS (Jaksa Masuk Sekolah)",
                                    style: GoogleFonts.openSans(
                                      textStyle: Theme.of(context).textTheme.displayLarge,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PenyuluhanList()), 
                );
              },
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'images/c.png',
                            fit: BoxFit.cover, 
                            
                          ),
                          SizedBox(width: 4.0), 
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 8.0),
                                  Text(
                                    "Penyuluhan Hukum",
                                    style: GoogleFonts.openSans(
                                      textStyle: Theme.of(context).textTheme.displayLarge,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AliranKepercayaanList()), 
                );
              },
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'images/c.png',
                            fit: BoxFit.cover, 
                            
                          ),
                          SizedBox(width: 4.0), 
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 8.0),
                                  Text(
                                    "Pengawasan Aliran dan Kepercayaan",
                                    style: GoogleFonts.openSans(
                                      textStyle: Theme.of(context).textTheme.displayLarge,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
             SizedBox(height: 8.0),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PoskoPilkadaList()), 
                );
              },
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'images/c.png',
                            fit: BoxFit.cover, 
                            
                          ),
                          SizedBox(width: 4.0), 
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 8.0),
                                  Text(
                                    "Posko Pilkada",
                                    style: GoogleFonts.openSans(
                                      textStyle: Theme.of(context).textTheme.displayLarge,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
