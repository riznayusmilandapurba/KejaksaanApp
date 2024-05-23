import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kejaksaan/pages/login.dart';
import 'package:kejaksaan/models/modelregister.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isUsernameValid = false;
  bool isPhoneNumberValid = false;
  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isPasswordVisible = false;

  TextEditingController txtNama = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtAlamat = TextEditingController();

  Uint8List? _ktpFileBytes;
  String? _ktpFileName;

  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  bool isLoading = false;

  Future<void> registerAccount() async {
    try {
      setState(() {
        isLoading = true;
      });
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.0.102/kejaksaan_server/register.php'),
      );
      request.fields['nama'] = txtNama.text;
      request.fields['email'] = txtEmail.text;
      request.fields['phone'] = txtPhone.text;
      request.fields['password'] = txtPassword.text;
      request.fields['alamat'] = txtAlamat.text;
      if (_ktpFileBytes != null && _ktpFileName != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'ktp',
          _ktpFileBytes!,
          filename: _ktpFileName!,
        ));
      }

      var res = await request.send();
      var resBody = await res.stream.bytesToString();

      ModelRegister data = modelRegisterFromJson(resBody);
      if (data.value == 1) {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Login()),
            (route) => false,
          );
        });
      } else if (data.value == 2) {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));
        });
      } else {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));
        });
      }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(107, 140, 66, 1),
              Color.fromRGBO(107, 140, 66, 1),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                top: 20,
                left: 15,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_circle_left),
                  color: Colors.white,
                  iconSize: 30,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60), // Adjusted to give space from the top
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.openSans(
                        textStyle: Theme.of(context).textTheme.displayLarge,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    margin: EdgeInsets.only(bottom: 180),
                    elevation: 5,
                    child: Container( 
                      color: Color.fromRGBO(107, 140, 66, 1),
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.person_2_outlined),
                                  SizedBox(width: 10),
                                  Text(
                                    'Full Name',
                                    style: GoogleFonts.openSans(
                                      textStyle: Theme.of(context).textTheme.displayLarge,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: TextField(
                                  controller: txtNama,
                                  onChanged: (value) {
                                    setState(() {
                                      isUsernameValid = value.isNotEmpty;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Enter your full name',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none,
                                    ),
                                    suffixIcon: isUsernameValid
                                        ? Icon(Icons.check_circle_outline, color: Colors.blue)
                                        : null,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.email_outlined),
                                  SizedBox(width: 10),
                                  Text(
                                    'Email Address',
                                    style: GoogleFonts.openSans(
                                      textStyle: Theme.of(context).textTheme.displayLarge,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: TextField(
                                  controller: txtEmail,
                                  onChanged: (value) {
                                    setState(() {
                                      isEmailValid = value.isNotEmpty;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Enter your email address',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none,
                                    ),
                                    suffixIcon: isEmailValid
                                        ? Icon(Icons.check_circle_outline, color: Colors.blue)
                                        : null,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.phone_callback_outlined),
                                  SizedBox(width: 10),
                                  Text(
                                    'Phone Number',
                                    style: GoogleFonts.openSans(
                                      textStyle: Theme.of(context).textTheme.displayLarge,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: TextField(
                                  controller: txtPhone,
                                  onChanged: (value) {
                                    setState(() {
                                      isPhoneNumberValid = value.isNotEmpty;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Enter your phone number',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none,
                                    ),
                                    suffixIcon: isPhoneNumberValid
                                        ? Icon(Icons.check_circle_outline, color: Colors.blue)
                                        : null,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.lock_outline),
                                  SizedBox(width: 10),
                                  Text(
                                    'Password',
                                    style: GoogleFonts.openSans(
                                      textStyle: Theme.of(context).textTheme.displayLarge,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: TextField(
                                  controller: txtPassword,
                                  obscureText: !isPasswordVisible,
                                  onChanged: (value) {
                                    setState(() {
                                      isPasswordValid = value.isNotEmpty;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Enter your password',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        isPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isPasswordVisible = !isPasswordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                           SizedBox(height: 20),
                          ElevatedButton.icon(
                            onPressed: _pickKtpFile,
                            icon: Icon(Icons.file_upload,
                            color: Color.fromRGBO(107, 140, 66, 1),
                            ),
                            label: Text('Upload KTP',
                            style: GoogleFonts.openSans(
                                      textStyle: Theme.of(context).textTheme.displayLarge,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(107, 140, 66, 1),
                                    ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          if (_ktpFileName != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text('Selected file: $_ktpFileName'),
                            ),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.home_work_outlined),
                                  SizedBox(width: 10),
                                  Text(
                                    'Alamat',
                                    style: GoogleFonts.openSans(
                                      textStyle: Theme.of(context).textTheme.displayLarge,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: TextField(
                                  controller: txtAlamat,
                                  decoration: InputDecoration(
                                    hintText: 'Enter your address',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                         
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: registerAccount,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(107, 140, 66, 1),
                              
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: isLoading
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    'Sign Up',
                                    style: GoogleFonts.openSans(
                                      textStyle: Theme.of(context).textTheme.displayLarge,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
