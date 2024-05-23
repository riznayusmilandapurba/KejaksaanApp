import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:kejaksaan/models/modelpenyuluhanadd.dart';
import 'package:kejaksaan/pages/penyuluhanlist.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class PenyuluhanHukum extends StatefulWidget {
  const PenyuluhanHukum({super.key});

  @override
  State<PenyuluhanHukum> createState() => _PenyuluhanHukumState();
}

class _PenyuluhanHukumState extends State<PenyuluhanHukum> {
  bool isNamaValid = false;
  bool isNohpValid = false;

  TextEditingController txtNama = TextEditingController();
  TextEditingController txtNohp = TextEditingController();

  Uint8List? _ktpFileBytes;
  String? _ktpFileName;
  Uint8List? _permasalahanFileBytes;
  String? _permasalahanFileName;

  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  bool isLoading = false;

  Future<void> PenyuluhanAdd() async {
    try {
      setState(() {
        isLoading = true;
      });

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.0.102/kejaksaan_server/penyuluhanPOST.php'),
      );
      request.fields['nama'] = txtNama.text;
      request.fields['nohp'] = txtNohp.text;
      request.fields['status'] = 'pending';

      if (_ktpFileBytes != null && _ktpFileName != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'ktp',
          _ktpFileBytes!,
          filename: _ktpFileName!,
        ));
      }

      if (_permasalahanFileBytes != null && _permasalahanFileName != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'permasalahan',
          _permasalahanFileBytes!,
          filename: _permasalahanFileName!,
        ));
      }

      var res = await request.send();
      var resBody = await res.stream.bytesToString();

      // Verifikasi apakah JSON valid sebelum memprosesnya
      if (resBody.isNotEmpty) {
        try {
          ModelPenyuluhanAdd data = ModelPenyuluhanAddFromJson(resBody);
          setState(() {
            isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${data.message}')));
            if (data.value == 1) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => PenyuluhanList()),
                (route) => false,
              );
            }
          });
        } catch (e) {
          setState(() {
            isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid JSON response: $resBody')));
          });
        }
      } else {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Empty response from server')));
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  Future<void> _pickKtpFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _ktpFileBytes = result.files.single.bytes;
        _ktpFileName = result.files.single.name;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No file selected.')),
      );
    }
  }

  Future<void> _pickPermasalahanFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _permasalahanFileBytes = result.files.single.bytes;
        _permasalahanFileName = result.files.single.name;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No file selected.')),
      );
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
                    "PENYULUHAN HUKUM",
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
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PenyuluhanList()),
                    );
                  },
                  child: Text(
                    'Lihat Data',
                    style: GoogleFonts.openSans(
                      textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
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
                      'Nama Pelapor',
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
                        controller: txtNama,
                        onChanged: (value) {
                          setState(() {
                            isNamaValid = value.isNotEmpty;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter your fullname',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: isNamaValid
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
                      'Nomor Handphone',
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
                        controller: txtNohp,
                        onChanged: (value) {
                          setState(() {
                            isNohpValid = value.isNotEmpty;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter your phone',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: isNohpValid
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
                      'KTP',
                      style: GoogleFonts.openSans(
                        textStyle: Theme.of(context).textTheme.displayLarge,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(107, 140, 66, 1),
                      ),
                    ),
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: _pickKtpFile,
                      child: Text(
                        'Upload KTP',
                        style: GoogleFonts.openSans(
                          textStyle: Theme.of(context).textTheme.displayLarge,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(107, 140, 66, 1),
                        ),
                      ),
                    ),
                    if (_ktpFileName != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text('Selected file: $_ktpFileName'),
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
                      'Permasalahan',
                      style: GoogleFonts.openSans(
                        textStyle: Theme.of(context).textTheme.displayLarge,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(107, 140, 66, 1),
                      ),
                    ),
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: _pickPermasalahanFile,
                      child: Text(
                        'Upload Permasalahan',
                        style: GoogleFonts.openSans(
                          textStyle: Theme.of(context).textTheme.displayLarge,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(107, 140, 66, 1),
                        ),
                      ),
                    ),
                    if (_permasalahanFileName != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text('Selected file: $_permasalahanFileName'),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: ElevatedButton(
                  onPressed: (){
                    PenyuluhanAdd();
                  },
                  child: Text(
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
