part of '/common.dart';

class ViewHome extends StatefulWidget {
  const ViewHome({Key? key}) : super(key: key);

  @override
  _ViewHomeState createState() => _ViewHomeState();
}

class _ViewHomeState extends State<ViewHome> {
  int selectedIndex = 1;

  final List<Widget> bottomNavigationButton = [
    // ViewHome(),
    ViewLotto(),
    ViewConvertText(),
  ];
  //
  void bottomNavigationButtonTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('horoli'),
      ),
      body: SafeArea(
        child: bottomNavigationButton.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          // BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'lotto'),
          BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'convert'),
        ],
        currentIndex: selectedIndex,
        onTap: bottomNavigationButtonTap,
      ),
    );
  }
}
