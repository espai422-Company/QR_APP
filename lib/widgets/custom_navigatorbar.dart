import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_app/providers/scan_list_provider.dart';
import 'package:qr_app/providers/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);

    return FutureBuilder(
      // Replace FutureFunction with your async logic if needed
      future: scanListProvider.getTotals(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Loading indicator
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final uiProvider = Provider.of<UiProvider>(context);

          return BottomNavigationBar(
            onTap: (int i) => uiProvider.selectedMenuOpt = i,
            elevation: 0,
            currentIndex: uiProvider.selectedMenuOpt,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: 'Mapa (${snapshot.data!['geo']})',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.compass_calibration),
                label: 'Direccions (${snapshot.data!['web']})',
              ),
            ],
          );
        }
      },
    );
  }
}
