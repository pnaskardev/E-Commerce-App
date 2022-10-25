import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
class MainPage extends StatelessWidget 
{
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      body: StreamBuilder<User?>
      {
        stream:FirebaseAuth.instance.authStateChanges(),
        builder:(context,snapshot)
        {
          if(snapshot.hasData)
          {
            
          }
        }
      },
    );
  }
}