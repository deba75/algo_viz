import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:Text("Algo Vizualizer"),
      backgroundColor: Colors.blue),
      body: GridView.count(
        crossAxisCount: 3,
      padding: EdgeInsets.all(16),
      
        children: [
          _buildCard(context, "Bubble Sort", Colors.red, '/bubble'),
          _buildCard(context, "Quick Sort", Colors.blue, '/quick'),

        ]
      
      ),

    );
  }


  Widget _buildCard(BuildContext context, String title, Color color, String route){
    return Card(
      color: color,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),

        child: Center(
          child: Text(title, style: TextStyle(color:Colors.white, fontSize:18, fontWeight: FontWeight.bold),
          )
        )
      )
    );
  }
}