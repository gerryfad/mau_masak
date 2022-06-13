import 'package:flutter/material.dart';

class AddresepView extends StatelessWidget {
  const AddresepView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {}),
      body: const Center(
        child: Text("Add Resep"),
      ),
    );
  }
}
