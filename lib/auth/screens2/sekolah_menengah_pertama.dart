import 'package:flutter/material.dart';


class SekolahMenengahPertama extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submenu with AppBar'),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text('Submenu 1'),
                  value: 'submenu1',
                ),
                PopupMenuItem(
                  child: Text('Submenu 2'),
                  value: 'submenu2',
                ),
              ];
            },
            onSelected: (value) {
              // Tindakan yang sesuai untuk setiap submenu yang dipilih
              switch (value) {
                case 'submenu1':
                  // Lakukan sesuatu untuk submenu 1
                  break;
                case 'submenu2':
                  // Lakukan sesuatu untuk submenu 2
                  break;
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Isi halaman dengan submenu di AppBar'),
      ),
    );
  }
}
