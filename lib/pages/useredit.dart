import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kejaksaan/pages/user.dart';
import 'package:kejaksaan/utils/session_manager.dart';

class UserEdit extends StatefulWidget {
  const UserEdit({Key? key}) : super(key: key);

  @override
  State<UserEdit> createState() => _UserEditState();
}

class _UserEditState extends State<UserEdit> {
  late TextEditingController _namaController;
  late TextEditingController _phoneController;
  late TextEditingController _alamatController;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: sessionManager.nama ?? '');
    _phoneController = TextEditingController(text: sessionManager.phone ?? '');
    _alamatController = TextEditingController(text: sessionManager.alamat ?? '');
  }

  @override
  void dispose() {
    _namaController.dispose();
    _phoneController.dispose();
    _alamatController.dispose();
    super.dispose();
  }

  void _saveChanges() {
  // Ubah tipe data id sesuai dengan yang diharapkan oleh SessionManager
  int id = sessionManager.id ?? 0;
  sessionManager.nama = _namaController.text;
  sessionManager.phone = _phoneController.text;
  sessionManager.alamat = _alamatController.text;

  sessionManager.saveSession(
    1,
    id, // Gunakan id yang sudah diubah tipe datanya
    sessionManager.nama ?? '',
    sessionManager.email ?? '',
    sessionManager.phone ?? '',
    sessionManager.alamat ?? '',
    sessionManager.ktp ?? '',
    sessionManager.role ?? '',
  );

  Navigator.pop(context);
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => User()),
  );
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
                    "EDIT USER",
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
                      'Nama',
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
                        controller: _namaController,
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          hintText: 'Edit your name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
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
                        controller: _phoneController,
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          hintText: 'Edit your phone',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
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
                      'Alamat',
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
                        controller: _alamatController,
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          hintText: 'Edit your Address',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
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
                    _saveChanges();
                  },
                  child: Text(
                    'Update',
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
    );
  }
}
