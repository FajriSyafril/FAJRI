import 'package:flutter/material.dart';


class SekolahDasarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Jumlah tab
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 132, 66, 247),
          centerTitle: true,
          title: Text('Sekolah Dasar'),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.school_outlined),
                text: 'Gambar Sekolah Dasar',
              ),
              Tab(
                icon: Icon(Icons.person),
                text: 'Profil Sekolah ',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Image.asset('assets/images/download.jpg', 
              alignment: Alignment.bottomCenter),
            ),
            Center(
              child: Text('Isi dari Tab 2'),
            ),
          ],
        ),
      ),
    );
  }
}