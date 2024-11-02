// File: screens/home/logout_screen.dart

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../auth/login_screen.dart';
import '../widget/SlidePageRoute.dart';

class LogoutScreen extends StatefulWidget {
  @override
  _LogoutScreenState createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen>
    with TickerProviderStateMixin {
  final List<IconData> _ikon = [
    Icons.star,
    Icons.favorite,
    Icons.music_note,
    Icons.local_cafe,
    Icons.flight,
    Icons.pets,
    Icons.beach_access,
    Icons.camera,
  ];
  late List<IconData> _ubin;
  late List<bool> _terbuka;
  late List<bool> _terpecahkan;
  int _langkah = 0;
  int? _terakhirDibuka;
  bool _dapatMembalik = true;
  late AnimationController _kontrolerGetar;
  late Animation<double> _animasiGetar;

  @override
  void initState() {
    super.initState();
    _mulaiPermainanBaru();
    _kontrolerGetar = AnimationController(
      duration: const Duration(milliseconds: 50),
      vsync: this,
    );
    _animasiGetar = Tween<double>(begin: -3.0, end: 3.0).animate(
      CurvedAnimation(parent: _kontrolerGetar, curve: Curves.easeInOut),
    );
    _kontrolerGetar.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _kontrolerGetar.reverse();
      }
    });
  }

  void _mulaiPermainanBaru() {
    _ubin = [..._ikon, ..._ikon];
    _ubin.shuffle(Random());
    _terbuka = List.generate(16, (_) => false);
    _terpecahkan = List.generate(16, (_) => false);
    _langkah = 0;
    _terakhirDibuka = null;
    _dapatMembalik = true;
  }

  void _balikUbin(int indeks) {
    if (!_dapatMembalik || _terbuka[indeks] || _terpecahkan[indeks]) return;

    setState(() {
      _terbuka[indeks] = true;
      _langkah++;
    });

    if (_terakhirDibuka == null) {
      _terakhirDibuka = indeks;
    } else {
      _dapatMembalik = false;
      Timer(Duration(milliseconds: 500), () {
        if (_ubin[_terakhirDibuka!] == _ubin[indeks]) {
          _terpecahkan[_terakhirDibuka!] = true;
          _terpecahkan[indeks] = true;
          if (_terpecahkan.every((solved) => solved)) {
            _tampilkanDialogMenang();
          }
        } else {
          _terbuka[_terakhirDibuka!] = false;
          _terbuka[indeks] = false;
          _kontrolerGetar.forward(from: 0.0);
        }
        _terakhirDibuka = null;
        _dapatMembalik = true;
        setState(() {});
      });
    }
  }

  void _tampilkanDialogMenang() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Selamat!',
              style: TextStyle(fontFamily: 'Roboto', color: Colors.black)),
          content: Text(
              'Anda telah menyelesaikan permainan dalam $_langkah langkah. Anda sekarang dapat keluar.',
              style: TextStyle(
                  fontFamily: 'Roboto', color: Colors.black, fontSize: 16)),
          actions: <Widget>[
            TextButton(
              child: Text('Keluar',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Color(0xFF4285F4),
                      fontSize: 18)),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  SlidePageRoute(page: LoginScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Permainan Memori',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 42, 41, 41),
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    elevation: 4,
                    color: Color(0xFF5F93CF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'Cocokkan ikon untuk Logout',
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 18,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Langkah: $_langkah',
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: AnimatedBuilder(
                          animation: _animasiGetar,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(_animasiGetar.value, 0),
                              child: child,
                            );
                          },
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              double itemSize = (constraints.maxWidth - 30) / 4;
                              return GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  childAspectRatio: 1.0,
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10.0,
                                ),
                                itemCount: 16,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () => _balikUbin(index),
                                    child: KartuMembalik(
                                      ikon: _ubin[index],
                                      terbuka: _terbuka[index],
                                      terpecahkan: _terpecahkan[index],
                                      ukuran: itemSize,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text('Mulai Ulang',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.white,
                            fontSize: 20)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4285F4),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    onPressed: () {
                      setState(() {
                        _mulaiPermainanBaru();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _kontrolerGetar.dispose();
    super.dispose();
  }
}

class KartuMembalik extends StatelessWidget {
  final IconData ikon;
  final bool terbuka;
  final bool terpecahkan;
  final double ukuran;

  KartuMembalik(
      {required this.ikon,
      required this.terbuka,
      required this.terpecahkan,
      required this.ukuran});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.002)
        ..rotateY(terbuka ? pi : 0),
      transformAlignment: Alignment.center,
      decoration: BoxDecoration(
        color: terbuka || terpecahkan ? Color(0xFF4285F4) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFF4285F4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Center(
        child: terbuka || terpecahkan
            ? Icon(ikon, color: Colors.white, size: ukuran * 0.6)
            : Icon(Icons.question_mark,
                color: Color(0xFF4285F4), size: ukuran * 0.6),
      ),
    );
  }
}
