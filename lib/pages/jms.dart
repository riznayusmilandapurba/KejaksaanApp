import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kejaksaan/pages/jmslist.dart';
import 'package:http/http.dart' as http;

class JMS extends StatefulWidget {

  const JMS({Key? key}) : super(key: key);

  @override
  State<JMS> createState() => _JMSState();
}

class _JMSState extends State<JMS> {
  bool isNamaSekolahValid = false;
  bool isNamaPemohonValid = false;

  final TextEditingController txtNamaSekolah = TextEditingController();
  final TextEditingController txtNamaPemohon = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  bool isLoading = false;
  final bool isAdmin = true;

  Future<void> JMSAdd() async {
    try {
      setState(() {
        isLoading = true;
      });

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://172.22.0.42/kejaksaan_server/JaksaMasukSekolah_POST.php'),
      );

      request.fields['namasekolah'] = txtNamaSekolah.text;
      request.fields['namapemohon'] = txtNamaPemohon.text;
      request.fields['status'] = 'pending';

      var response = await request.send();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Berhasil Tambah Data')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => JMSList(isAdmin: isAdmin)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal Tambah Data')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(107, 140, 66, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    "JMS (JAKSA MASUK SEKOLAH)",
                    style: GoogleFonts.prozaLibre(
                      textStyle: Theme.of(context).textTheme.headline6,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sekolah yang dituju',
                      style: GoogleFonts.openSans(
                        textStyle: Theme.of(context).textTheme.displayLarge,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(107, 140, 66, 1),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.05),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: txtNamaSekolah,
                        onChanged: (value) {
                          setState(() {
                            isNamaSekolahValid = value.isNotEmpty;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter your school',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: isNamaSekolahValid
                              ? Icon(Icons.check_circle_outline, color: Colors.grey)
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nama Pemohon',
                      style: GoogleFonts.openSans(
                        textStyle: Theme.of(context).textTheme.displayLarge,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(107, 140, 66, 1),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.05),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: txtNamaPemohon,
                        onChanged: (value) {
                          setState(() {
                            isNamaPemohonValid = value.isNotEmpty;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter your fullname',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: isNamaPemohonValid
                              ? Icon(Icons.check_circle_outline, color: Colors.blue)
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (isNamaSekolahValid && isNamaPemohonValid) {
                      JMSAdd();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Harap isi semua field')),
                      );
                    }
                  },
                  child: isLoading
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Text(
                          'Submit',
                          style: GoogleFonts.openSans(
                            textStyle: Theme.of(context).textTheme.displayLarge,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(107, 140, 66, 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
