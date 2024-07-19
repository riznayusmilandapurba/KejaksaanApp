import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  int? value;
  int? id;
  String? nama;
  String? email;
  String? phone;
  String? ktp;
  String? alamat;
  String? role;

  // Simpan sesi
  Future<void> saveSession(int value, int id, String nama, String email, String phone, String ktp, String alamat, String role) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt("value", value);
    await pref.setInt("id", id);
    await pref.setString("nama", nama);
    await pref.setString("email", email);
    await pref.setString("phone", phone);
    await pref.setString("ktp", ktp);
    await pref.setString("alamat", alamat);
    await pref.setString("role", role);
  }

  // Ambil sesi
  Future<void> getSession() async {
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

  // Hapus sesi -> logout
  Future<void> clearSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}

// Instance class biar dipanggil
SessionManager sessionManager = SessionManager();
