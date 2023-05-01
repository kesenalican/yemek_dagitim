import 'package:flutter/material.dart';

class PersonLocation extends StatefulWidget {
  const PersonLocation({super.key});

  @override
  State<PersonLocation> createState() => _PersonLocationState();
}

class _PersonLocationState extends State<PersonLocation> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('LOCATION'),
    );
  }
}
