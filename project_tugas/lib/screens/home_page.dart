// lib/screens/home_page.dart
import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'food_page.dart';
import 'drink_page.dart';
import 'login.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _title = 'Dashboard';

  static const List<String> _titles = [
    'Dashboard',
    'Makanan',
    'Minuman',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.restaurant_menu,
                      size: 40,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              selected: _selectedIndex == 0,
              selectedTileColor: Colors.blue.withOpacity(0.1),
              selectedColor: Colors.blue,
              onTap: () {
                _selectDrawerItem(0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.restaurant),
              title: const Text('Makanan'),
              selected: _selectedIndex == 1,
              selectedTileColor: Colors.blue.withOpacity(0.1),
              selectedColor: Colors.blue,
              onTap: () {
                _selectDrawerItem(1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_drink),
              title: const Text('Minuman'),
              selected: _selectedIndex == 2,
              selectedTileColor: Colors.blue.withOpacity(0.1),
              selectedColor: Colors.blue,
              onTap: () {
                _selectDrawerItem(2);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                _confirmLogout(context);
              },
            ),
          ],
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return const DashboardPage();
      case 1:
        return const FoodPage();
      case 2:
        return const DrinkPage();
      default:
        return const DashboardPage();
    }
  }

  void _selectDrawerItem(int index) {
    setState(() {
      _selectedIndex = index;
      _title = _titles[index];
    });
    Navigator.pop(context);
  }

  // Function to show logout confirmation dialog
  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Logout'),
          content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Batal', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _logout(context); // Perform logout
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child:
                  const Text('Logout', style: TextStyle(color: Colors.white)),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        );
      },
    );
  }

  // Function to handle logout
  void _logout(BuildContext context) {
    // Here you can add any logout logic like clearing session data, etc.

    // Navigate to login screen and remove all previous routes
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (Route<dynamic> route) => false,
    );

    // Show a snackbar notification
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Berhasil logout'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
