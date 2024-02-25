import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Position? currentPosition;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      LocationPermission ask = await Geolocator.requestPermission();
      if (ask == LocationPermission.denied ||
          ask == LocationPermission.deniedForever) {
        // Handle the scenario where permission is denied or forever denied
        // You can show a dialog to inform the user about the importance of location
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    setState(() {
      currentPosition = position;
    });
  }

  final List<EmergencyButtonData> _buttons = [
    EmergencyButtonData(Icons.car_crash_outlined, 'Ambulance', Colors.red.shade400),
    EmergencyButtonData(Icons.local_police_outlined, 'Police', Colors.blue.shade400),
    EmergencyButtonData(Icons.fire_truck_outlined, 'Fire', Colors.orange.shade400),
    EmergencyButtonData(Icons.group, 'Abuse', Colors.green.shade400),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Emergency Help"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (currentPosition != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  'Latitude: ${currentPosition!.latitude}, Longitude: ${currentPosition!.longitude}',
                  textAlign: TextAlign.center,
                ),
              ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1, // Ensure equal width and height for square buttons
                crossAxisSpacing: 10, // Add horizontal spacing
                mainAxisSpacing: 10, // Add vertical spacing
                children: _buttons.map((buttonData) => buildEmergencyButton(buttonData)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEmergencyButton(EmergencyButtonData buttonData) {
    return InkWell(
      onTap: () {
        getCurrentLocation();
      },
      child: CircleAvatar(
        backgroundColor: buttonData.color,
        radius: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(buttonData.icon, size: 50, color: Colors.white),
            const SizedBox(height: 10),
            Text(buttonData.label, style: const TextStyle(fontSize: 18, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

class EmergencyButtonData {
  final IconData icon;
  final String label;
  final Color color;

  const EmergencyButtonData(this.icon, this.label, this.color);
}
