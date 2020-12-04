import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/page/address_page.dart';
import 'package:qr_scan/page/maps_page.dart';
import 'package:qr_scan/providers/db_provider.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';
import 'package:qr_scan/providers/ui_provider.dart';
import 'package:qr_scan/widgets/custom_navigator.dart';
import 'package:qr_scan/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {},
          ),
        ],
      ),
      body: _HomePageBody(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomNavigator(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedOption;

    switch (currentIndex) {
      case 0:
        return MapsPage();
        break;
      case 1:
        return AddressPage();
        break;
      default:
        return MapsPage();
    }
  }
}
