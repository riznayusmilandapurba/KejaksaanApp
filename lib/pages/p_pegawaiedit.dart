import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:kejaksaan/pages/p_alirankepercayaan.dart';
import 'package:kejaksaan/pages/p_alirankepercayaanlist.dart';
import 'package:kejaksaan/pages/p_pegawailist.dart';
import 'package:kejaksaan/models/modelpenyuluhanadd.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class PengaduanPegawaiEdit extends StatefulWidget {
  final String id;
  final String namapelapor;
  final String nohp;
  final String ktp;
  final String laporan;

  const PengaduanPegawaiEdit({
    required this.id,
    required this.namapelapor,
    required this.nohp,
    required this.ktp,
    required this.laporan,
    Key? key,
  }) : super(key: key);

  @override
  State<PengaduanPegawaiEdit> createState() => _PengaduanPegawaiEditState();
}

class _PengaduanPegawaiEditState extends State<PengaduanPegawaiEdit> {
  late TextEditingController _txtNamaPelapor;
  late TextEditingController _txtNoHP;
  late GlobalKey<FormState> _keyForm;
  late bool _isLoading;
  Uint8List? _ktpFileBytes;
  String? _ktpFileName;
  Uint8List? _laporanFileBytes;
  String? _laporanFileName;

  @override
  void initState() {
    super.initState();
    _txtNamaPelapor = TextEditingController(text: widget.namapelapor);
    _txtNoHP = TextEditingController(text: widget.nohp);
    _keyForm = GlobalKey<FormState>();
    _isLoading = false;
  }

  Future<void> _editPengaduanPegawai() async {
    if (!_keyForm.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final url = Uri.parse('http://192.168.0.102/kejaksaan_server/p_pegawaiUPDATE.php');
      final request = http.MultipartRequest('POST', url);

      request.fields.addAll({
        "id": widget.id,
        "namapelapor": _txtNamaPelapor.text,
        "nohp": _txtNoHP.text,
        "status": 'pending',
      });

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

      if (res.statusCode == 200) {
        ModelPenyuluhanAdd data = ModelPenyuluhanAddFromJson(resBody);
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${data.message}')));
        if (data.value == 1) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => AliranKepercayaanList()),
            (route) => false,
          );
        }
      } else {
        setState(() {
          _isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update data. Please try again.')),
          );
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  Future<void> _pickKtpFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpeg', 'jpg', 'png', 'pdf'],
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
      allowedExtensions: ['jpeg', 'jpg', 'png', 'pdf'],
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
          child: Form(
            key: _keyForm,
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
                      "EDIT PENGADUAN PEGAWAI",
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
                          textStyle: Theme.of(context).textTheme.headline6,
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
                        child: TextFormField(
                          controller: _txtNamaPelapor,
                          onChanged: (value) {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter your fullname',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: _txtNamaPelapor.text.isNotEmpty
                                ? Icon(Icons.check_circle_outline, color: Colors.grey)
                                : null,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nama Pelapor tidak boleh kosong';
                            }
                            return null;
                          },
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
                          textStyle: Theme.of(context).textTheme.headline6,
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
                        child: TextFormField(
                          controller: _txtNoHP,
                          onChanged: (value) {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter your phone',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: _txtNoHP.text.isNotEmpty
                                ? Icon(Icons.check_circle_outline, color: Colors.grey)
                                : null,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nomor Handphone tidak boleh kosong';
                            }
                            return null;
                          },
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
                          textStyle: Theme.of(context).textTheme.headline6,
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
                            textStyle: Theme.of(context).textTheme.headline6,
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
                          textStyle: Theme.of(context).textTheme.headline6,
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
                            textStyle: Theme.of(context).textTheme.headline6,
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
                      _editPengaduanPegawai();
                    },
                    child: Text(
                      'Submit',
                      style: GoogleFonts.openSans(
                        textStyle: Theme.of(context).textTheme.headline6,
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
      ),
    );
  }
}
