import 'package:flutter/material.dart';

class Information extends StatelessWidget {
  const Information({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Information'),
      ),
      body: Center(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Work in Progress....',
              style: TextStyle(
                color: Colors.grey.shade500,
                fontWeight: FontWeight.bold,
              )
              ),
              Icon(Icons.handyman_outlined, color: Colors.grey.shade500,)
            ],
          ),
      )
    );
  }
}