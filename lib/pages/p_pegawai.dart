import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:kejaksaan/pages/p_pegawailist.dart';
import 'package:kejaksaan/models/modelp_pegawaiadd.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class PengaduanPegawai extends StatefulWidget {
  const PengaduanPegawai({super.key});

  @override
  State<PengaduanPegawai> createState() => _PengaduanPegawaiState();
}

class _PengaduanPegawaiState extends State<PengaduanPegawai> {
  bool isNamapelaporValid = false;
  bool isNohpValid = false;

  TextEditingController txtNamapelapor = TextEditingController();
  TextEditingController txtNohp = TextEditingController();

  Uint8List? _ktpFileBytes;
  String? _ktpFileName;
  Uint8List? _laporanFileBytes;
  String? _laporanFileName;

  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  bool isLoading = false;

  Future<void> P_PegawaiAdd() async {
    try {
      setState(() {
        isLoading = true;
      });

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://172.22.0.42/kejaksaan_server/p_pegawaiPOST.php'),
      );
      request.fields['namapelapor'] = txtNamapelapor.text;
      request.fields['nohp'] = txtNohp.text;
      request.fields['status'] = 'pending';

      if (_ktpFileBytes != null && _ktpFileName != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'ktp',
          _ktpFileBytes!,
          filename: _ktpFileName!,
        ));
      }

      if (_laporanFileBytes != null && _laporanFileName != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'laporan',
          _laporanFileBytes!,
          filename: _laporanFileName!,
        ));
      }

      var res = await request.send();
      var resBody = await res.stream.bytesToString();

      ModelPPegawaiAdd data = ModelPPegawaiAddFromJson(resBody);
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${data.message}')));
        if (data.value == 1) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => PengaduanPegawaiList()),
            (route) => false,
          );
        }
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
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

  Future<void> _pickLaporanFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _laporanFileBytes = result.files.single.bytes;
        _laporanFileName = result.files.single.name;
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
                    "PENGADUAN PEGAWAI",
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
                        controller: txtNamapelapor,
                        onChanged: (value) {
                          setState(() {
                            isNamapelaporValid = value.isNotEmpty;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter your fullname',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: isNamapelaporValid
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
                      'Laporan',
                      style: GoogleFonts.openSans(
                        textStyle: Theme.of(context).textTheme.displayLarge,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(107, 140, 66, 1),
                      ),
                    ),
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: _pickLaporanFile,
                      child: Text(
                        'Upload Laporan',
                        style: GoogleFonts.openSans(
                          textStyle: Theme.of(context).textTheme.displayLarge,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(107, 140, 66, 1),
                        ),
                      ),
                    ),
                     if (_laporanFileName != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text('Selected file: $_laporanFileName'),
                            ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: ElevatedButton(
                  onPressed: () {
                    P_PegawaiAdd();
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
