import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:kejaksaan/models/modeljms.dart';
import 'package:kejaksaan/pages/home.dart';
import 'package:kejaksaan/pages/jms.dart';
import 'package:kejaksaan/pages/login.dart';
import 'package:kejaksaan/pages/rating.dart';
import 'package:url_launcher/url_launcher.dart';

class JMSList extends StatefulWidget {
  final bool isAdmin; // Parameter untuk role

  const JMSList({Key? key, required this.isAdmin}) : super(key: key);

  @override
  State<JMSList> createState() => _JMSListState();
}

class _JMSListState extends State<JMSList> {
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
      http.Response res = await http.get(Uri.parse('http://192.168.0.102/kejaksaan_server/JaksaMasukSekolah_GET.php'));
      if (res.statusCode == 200) {
        List<Datum> p_pegawaiList = ModelJMSFromJson(res.body).data ?? [];
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
          p_pegawai.namasekolah.toLowerCase().contains(keyword)
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
    if (!widget.isAdmin && (p_pegawai.status != 'approve' && p_pegawai.status != 'reject')) {
      try {
        http.Response res = await http.post(
          Uri.parse('http://192.168.0.102/kejaksaan_server/JaksaMasukSekolah_DEL.php'),
          body: {'id': p_pegawai.id.toString()},
        );
        if (res.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Data berhasil dihapus')),
          );
          _getPengaduanpegawai();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal menghapus data')),
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

  void _approvePengaduan(int index, String action) async {
    Datum p_pegawai = _filteredPengaduanpegawai[index];
    try {
      http.Response res = await http.post(
        Uri.parse('http://192.168.0.102/kejaksaan_server/JaksaMasukSekolah_UPDATE.php'),
        body: {
          'id': p_pegawai.id.toString(),
          'action': action,
        },
      );
      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data berhasil di-$action')),
        );
        _getPengaduanpegawai();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal $action data')),
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
                  DataColumn(
                    label: Text(
                      'No',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Nama Pelapor',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Nama Sekolah',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Status',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Menu',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                rows: _filteredPengaduanpegawai.asMap().entries.map((entry) {
                  int index = entry.key;
                  Datum data = entry.value;
                  return DataRow(
                    cells: [
                      DataCell(Text('${index + 1}')),
                      DataCell(Text(data.namapemohon)),
                      DataCell(Text(data.namasekolah)),
                      DataCell(Text(data.status)),
                      DataCell(
                        widget.isAdmin
                            ? Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.check),
                                    onPressed: () {
                                      _approvePengaduan(index, 'approve');
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.clear),
                                    onPressed: () {
                                      _approvePengaduan(index, 'reject');
                                    },
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  data.status != 'approve' && data.status != 'reject'
                                      ? IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () {
                                            // Tambahkan logika untuk edit
                                          },
                                          color: Colors.blue,
                                        )
                                      : SizedBox(),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      if (data.status == 'approve' || data.status == 'reject') {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Tidak dapat menghapus data dengan status "approve" atau "reject"')),
                                        );
                                      } else {
                                        _deletePengaduan(index);
                                      }
                                    },
                                    color: data.status == 'approve' || data.status == 'reject'
                                        ? Colors.grey
                                        : Colors.red,
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
      floatingActionButton: widget.isAdmin
          ? null
          : FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JMS()),
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
                MaterialPageRoute(builder: (context) => Home()),
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
