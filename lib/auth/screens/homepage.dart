import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glass_login/auth/auth_gate.dart';
import 'package:glass_login/auth/screens/lokasi.dart';
import 'package:glass_login/auth/screens/maps.dart';
import 'package:glass_login/auth/screens/sensors.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            color: Colors.white,
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => AuthGate()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(user?.displayName ?? ''), // Ganti dengan nama pengguna yang sesuai
              accountEmail: Text(user?.email ?? ''),
               // Ganti dengan email pengguna yang sesuai
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://kuninganmass.com/wp-content/uploads/2023/08/WhatsApp-Image-2023-08-01-at-17.55.48.jpg'),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://dorangadget.com/wp-content/uploads/2023/05/Karakter-One-Piece-63.jpg'),
                    fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.gps_fixed),
              title: const Text('GPS', style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Location())
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.map),
              title: const Text('Maps', style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapPage())
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.sensor_window),
              title: const Text('Sensor', style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SensorPage())
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.light),
              title: Text('lokasi', style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Location())
                  );
              },
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                "Welcome  \n"  +  user.email!,
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Image(
                image: NetworkImage('https://assets.pinshape.com/uploads/image/file/531093/container_luffy.png'),
              )
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.deepPurple,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  // Handle navigation to home page
                },
                color: Colors.white,
              ),
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  // Handle navigation to settings page
                },
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
