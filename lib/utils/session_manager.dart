import 'package:shared_preferences/shared_preferences.dart';

class SessionManager{
  int? value;
  int? id;
  String? nama;
  String? email;
  String? phone;
  String? ktp;
  String? alamat;
  String? role;

  

  //simpan sesi
  Future<void> saveSession(int val, int id, String nama,  String email, String phone, String ktp, String alamat, String role  ) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("value", val);
    pref.setInt("id", id);
    pref.setString("nama", nama);
    pref.setString("email", email);
    pref.setString("phone", phone);
    pref.setString("ktp", ktp);
    pref.setString("alamat", alamat);
    pref.setString("role", role);
    
  }

  Future getSession() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    value = pref.getInt("value");
    id = pref.getInt("id");
    nama = pref.getString("nama");
    email = pref.getString("email");
    phone = pref.getString("phone");
    ktp = pref.getString("ktp");
    alamat = pref.getString("alamat");
    role = pref.getString("role");
    
  }
  //remove --> logout
  Future clearSession() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }

}

//instance class biar d panggil
SessionManager sessionManager = SessionManager();