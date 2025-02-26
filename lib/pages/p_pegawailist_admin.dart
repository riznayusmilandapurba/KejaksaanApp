import 'package:flutter/material.dart';
import 'package:kejaksaan/models/modelp_pegawai.dart';
import 'package:http/http.dart' as http;
import 'package:kejaksaan/pages/home.dart';
import 'package:kejaksaan/pages/login.dart';
import 'package:kejaksaan/pages/p_pegawai.dart';
import 'package:kejaksaan/pages/p_pegawaidetail.dart';
import 'package:kejaksaan/pages/p_pegawaiedit.dart';
import 'package:kejaksaan/pages/rating.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class PengaduanPegawaiListAdmin extends StatefulWidget {
  const PengaduanPegawaiListAdmin({Key? key}) : super(key: key);

  @override
  State<PengaduanPegawaiListAdmin> createState() => _PengaduanPegawaiListAdminState();
}

class _PengaduanPegawaiListAdminState extends State<PengaduanPegawaiListAdmin> {
  late List<Datum> _p_pegawaiList;
  late List<Datum> _filteredPengaduanpegawai;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _p_pegawaiList = [];
    _filteredPengaduanpegawai = [];
    _searchController = TextEditingController();
    _getPengaduanpegawai();
  }

  Future<void> _getPengaduanpegawai() async {
    try {
      http.Response res = await http.get(Uri.parse('http://172.22.0.42/kejaksaan_server/p_pegawaiGET.php'));
      if (res.statusCode == 200) {
        List<Datum> p_pegawaiList = ModelPPegawaiFromJson(res.body).data ?? [];
        setState(() {
          _p_pegawaiList = p_pegawaiList;
          _filteredPengaduanpegawai = p_pegawaiList;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  void _filtersejarah(String keyword) {
    keyword = keyword.toLowerCase();
    setState(() {
      _filteredPengaduanpegawai = _p_pegawaiList.where((p_pegawai) =>
          p_pegawai.laporan.toLowerCase().contains(keyword)
      ).toList();
    });
  }

  void _launchPDF(String pdfUrl) async {
    if (await canLaunch(pdfUrl)) {
      await launch(pdfUrl);
    } else {
      throw 'Could not launch $pdfUrl';
    }
  }

  void _deletePengaduan(int index) async {
    Datum p_pegawai = _filteredPengaduanpegawai[index];
    if (p_pegawai.status != 'approve' && p_pegawai.status != 'reject') {
      try {
        http.Response res = await http.post(
          Uri.parse('http://192.168.0.102/kejaksaan_server/p_pegawaiDEL.php'),
          body: {'id': p_pegawai.id.toString()},
        );
        if (res.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Data Pegawai berhasil dihapus')),
          );
          _getPengaduanpegawai();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal menghapus Data Pegawai')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tidak dapat menghapus data dengan status "approve" atau "reject"')),
      );
    }
  }

  void _updateStatus(int index, String status) async {
    Datum p_pegawai = _filteredPengaduanpegawai[index];
    try {
      http.Response res = await http.post(
        Uri.parse('http://192.168.0.102/kejaksaan_server/p_pegawaiUPDATE.php'),
        body: {'id': p_pegawai.id.toString(), 'status': status},
      );
      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Status berhasil diperbarui')),
        );
        _getPengaduanpegawai();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memperbarui status')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(107, 140, 66, 1),
        toolbarHeight: 105,
        title: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 34,
                child: TextField(
                  controller: _searchController,
                  onChanged: _filtersejarah,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    hintText: 'Search laporan...',
                    hintStyle: GoogleFonts.lato(
                      fontSize: 16,
                      color: Color.fromRGBO(107, 140, 66, 1),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                dataRowHeight: 60,
                headingRowHeight: 80,
                columnSpacing: 20,
                columns: [
                  DataColumn(label: Text('No', textAlign: TextAlign.center)),
                  DataColumn(label: Text('Nama Pelapor', textAlign: TextAlign.center)),
                  DataColumn(label: Text('No. HP', textAlign: TextAlign.center)),
                  DataColumn(label: Text('Status', textAlign: TextAlign.center)),
                  DataColumn(label: Text('Menu', textAlign: TextAlign.center)),
                ],
                rows: _filteredPengaduanpegawai.asMap().entries.map((entry) {
                  int index = entry.key;
                  int displayIndex = index + 1;
                  Datum data = entry.value;
                  return DataRow(
                    cells: [
                      DataCell(Text('$displayIndex')),
                      DataCell(Text(data.namapelapor)),
                      DataCell(Text(data.nohp)),
                      DataCell(Text(data.status)),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.check, color: Colors.green),
                              onPressed: data.status == 'pending'
                                  ? () {
                                      _updateStatus(index, 'approve');
                                    }
                                  : null,
                            ),
                            IconButton(
                              icon: Icon(Icons.clear, color: Colors.red),
                              onPressed: data.status == 'pending'
                                  ? () {
                                      _updateStatus(index, 'reject');
                                    }
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PengaduanPegawai()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(107, 140, 66, 1),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Kategori',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Rating',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Log Out',
          ),
        ],
        backgroundColor: Color.fromRGBO(107, 140, 66, 1),
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home(isAdmin: true)),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Rating()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
              break;
          }
        },
      ),
    );
  }
}
