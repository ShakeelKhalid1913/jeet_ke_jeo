import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:jeet_ke_jeo/src/screens/history/index.dart';
import 'package:jeet_ke_jeo/src/screens/home/widgets/lottery.widget.dart';
import 'package:jeet_ke_jeo/src/screens/tutorial/index.dart';
import 'package:jeet_ke_jeo/src/services/firebase/auth.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  int _index = 1;

  void _logout() async {
    await _auth.logout();
    Navigator.pushNamed(context, '/login');
  }

  Widget _getCurrentScreen() {
    switch (_index) {
      case 0:
        return const PlayTutorialScreen();
      case 1:
        return const Lottery();
      case 2:
        return const HistoryScreen();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: 'Jeet Ke Jeo'.text.make(),
        actions: [
          IconButton(
              onPressed: _logout,
              icon: const Icon(
                Icons.logout,
                size: 30,
              )),
        ],
      ),
      body: _getCurrentScreen()
          .scrollVertical()
          .hFull(context)
          .wFull(context)
          .color(Colors.black87)
          .box
          .make(),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.black,
        activeColor: const Color(0xFFDDA74F),
        style: TabStyle.reactCircle,
        items: const [
          TabItem(icon: Icons.trolley, title: 'Tutorial'),
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.draw, title: 'History'),
        ],
        initialActiveIndex: _index,
        onTap: (int i) => setState(() {
          _index = i;
        }),
      ),
    );
  }
}
