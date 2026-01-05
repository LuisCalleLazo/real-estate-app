import 'package:flutter/widgets.dart';

class PropertyMapScreen extends StatefulWidget {
  const PropertyMapScreen({super.key});

  @override
  State<PropertyMapScreen> createState() => _PropertyMapScreenState();
}

class _PropertyMapScreenState extends State<PropertyMapScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Screen de propiedad"));
  }
}
