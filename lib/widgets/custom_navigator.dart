import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/providers/ui_provider.dart';

class CustomNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UiProvider uiProvider = Provider.of<UiProvider>(context);
    return BottomNavigationBar(
      elevation: 0,
      currentIndex: uiProvider.selectedOption,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Mapa',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.compass_calibration),
          label: 'Direcciones',
        ),
      ],
      onTap: (selectedIndex) => uiProvider.selectedOption = selectedIndex,
    );
  }
}
