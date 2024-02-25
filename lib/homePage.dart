import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        child: Padding(
          padding: const EdgeInsets.only(top: 200),
          child: Center(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1, // Ensure equal width and height for square buttons
              crossAxisSpacing: 10, // Add horizontal spacing
              mainAxisSpacing: 10, // Add vertical spacing
              children: _buttons.map((buttonData) => buildEmergencyButton(buttonData)).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEmergencyButton(EmergencyButtonData buttonData) {
    return InkWell(
      onTap: () {

      }, // Replace with your on-tap action
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
