import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kejaksaan/models/modellogin.dart';
import 'package:kejaksaan/pages/home.dart';
import 'package:kejaksaan/pages/register.dart';
import 'package:kejaksaan/utils/session_manager.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> loginAccount() async {
    try {
      setState(() {
        isLoading = true;
      });
      http.Response res = await http.post(
        Uri.parse('http://192.168.0.102/kejaksaan_server/login.php'),
        body: {
          "email": txtEmail.text,
          "password": txtPassword.text,
        },
      );

      Modellogin data = modelloginFromJson(res.body.trim());
      if (data.value == 1) {
        sessionManager.saveSession(
          data.value ?? 0,
          data.id ?? 0,
          data.nama ?? "",
          data.email ?? "",
          data.phone ?? "",
          data.ktp ?? "",
          data.alamat ?? "",
          data.role ?? "",
        );
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${data.message}')));

        if (data.role == 1 || data.role == 2) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Home()),
            (route) => false,
          );
        }
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_circle_left),
                          color: Colors.white,
                          iconSize: 30,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Sign In',
                          style: GoogleFonts.openSans(
                            textStyle: Theme.of(context).textTheme.displayLarge,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    margin: EdgeInsets.only(bottom: 180),
                    elevation: 5,
                    child: Container(
                      height: 470,
                      color: Color.fromRGBO(107, 140, 66, 1),
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: keyForm,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.person_outline),
                                    SizedBox(width: 10),
                                    Text(
                                      'Username or email',
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
                                  child: TextFormField(
                                    controller: txtEmail,
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Enter your username',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide.none,
                                      ),
                                      suffixIcon: txtEmail.text.isNotEmpty
                                          ? Icon(Icons.check_circle_outline,
                                              color: Colors.blue)
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
                                    Icon(Icons.lock_clock_outlined),
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
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextFormField(
                                    controller: txtPassword,
                                    obscureText: true,
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Enter your password',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide.none,
                                      ),
                                      suffixIcon: txtPassword.text.isNotEmpty
                                          ? Icon(Icons.check_circle_outline,
                                              color: Colors.blue)
                                          : null,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                if (keyForm.currentState!.validate()) {
                                  loginAccount();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Please enter both email and password'),
                                    ),
                                  );
                                }
                              },
                              child: isLoading
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      'Sign In',
                                      style: GoogleFonts.openSans(
                                        textStyle: Theme.of(context).textTheme.displayLarge,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(107, 140, 66, 1),
                                      ),
                                    ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Register()),
                                );
                              },
                              child: Text(
                                'Dont you have account? Sign Up',
                                style: GoogleFonts.openSans(
                                  textStyle: Theme.of(context).textTheme.displayLarge,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
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
