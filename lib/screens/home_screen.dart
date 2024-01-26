import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_app/providers/providers.dart';
import 'package:qr_app/screens/screens.dart';
import 'package:qr_app/widgets/widgets.dart';

/// Home screen widget for managing the main page of our app.
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              Provider.of<ScanListProvider>(context, listen: false)
                  .deleteAllScans();
            },
          )
        ],
      ),
      body: _HomeScreenBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

/// Private widget for handling the body content of the home screen based on the selected menu option.
class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access the UI provider to get the selected menu option.
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    // Access the ScanListProvider to get scan data.
    final ScanListProvider scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    // Choose the appropriate screen based on the selected menu option.
    switch (currentIndex) {
      // For the first menu option, load and display scans of 'geo' type.
      case 0:
        scanListProvider.loadScansByType('geo');
        return MapasScreen();

      // For the second menu option, load and display scans of 'http' type.
      case 1:
        scanListProvider.loadScansByType('http');
        return DireccionsScreen();

      // Default case: load and display scans of 'geo' type if an invalid menu option is selected.
      default:
        scanListProvider.loadScansByType('geo');
        return MapasScreen();
    }
  }
}
