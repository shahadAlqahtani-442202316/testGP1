import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  final int currentIndex;
  final Function(int) onIndexChanged;

  const BottomNav(
      {Key? key, required this.currentIndex, required this.onIndexChanged})
      : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      child: BottomNavigationBar(
        backgroundColor: Color(0xFF6EA67C),
        currentIndex: widget.currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors
            .white, // Set the color of the highlighted item's label to white
        unselectedItemColor: Colors
            .white70, // Set the color of the unselected items' labels to a lighter shade of white
        onTap: (int index) {
          widget.onIndexChanged(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Container(
              color: Color(0xFF6EA67C),
              child: Image.asset(
                'assets/gasStation2.png',
                width: 25,
                height: 25,
              ),
            ),
            label: 'Gas stations',
          ),
          BottomNavigationBarItem(
            icon: Container(
              color: Color(0xFF6EA67C),
              child: Image.asset(
                'assets/myCars2.png',
                width: 25,
                height: 25,
              ),
            ),
            label: 'My cars',
          ),
          BottomNavigationBarItem(
            icon: Container(
              color: Color(0xFF6EA67C),
              child: Image.asset(
                'assets/home222.png',
                width: 25,
                height: 25,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Container(
              color: Color(0xFF6EA67C),
              child: Image.asset(
                'assets/settings2.png',
                width: 25,
                height: 25,
              ),
            ),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Container(
              color: Color(0xFF6EA67C),
              child: Image.asset(
                'assets/account2.png',
                width: 25,
                height: 25,
              ),
            ),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
