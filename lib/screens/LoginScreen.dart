
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prueba/screens/Cuenta_screen.dart';
import 'package:prueba/screens/Historial_screen.dart';

void main() {
  runApp(Loginn());
}

class Loginn extends StatelessWidget {
  const Loginn({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Body(context),
    );
  }
}

Widget Body(context) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMcwVcgp9rvsd8GnSa3ABiY-OkEfsOKGLfUw&s'),
        fit: BoxFit.cover,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Gmail(),
        Contrasenia(),
        BotonLogin(context),
      ],
    ),
  );
}

final TextEditingController _gmail = TextEditingController();
Widget Gmail() {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.all(20),
        child: TextField(
          controller: _gmail,
          decoration: InputDecoration(
            hintText: 'Ingrese su Gmail',
            hintStyle: TextStyle(color: Colors.white),
            filled: true,
            fillColor: Colors.black.withOpacity(0.5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          style: TextStyle(color: Colors.white),
        ),
      ),
    ],
  );
}

final TextEditingController _contrasenia = TextEditingController();
Widget Contrasenia() {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.all(20),
        child: TextField(
          controller: _contrasenia,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Ingrese Contraseña',
            hintStyle: TextStyle(color: Colors.white),
            filled: true,
            fillColor: Colors.black.withOpacity(0.5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          style: TextStyle(color: Colors.white),
        ),
      ),
    ],
  );
}

Widget BotonLogin(context) {
  return Container(
    padding: EdgeInsets.all(20),
    child: ElevatedButton(
      onPressed: () {
        login(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green, 
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        textStyle: TextStyle(fontSize: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text("Login"),
    ),
  );
}

Future<void> login(context) async {
  try {
    // ignore: unused_local_variable
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _gmail.text,
      password: _contrasenia.text,
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Inicio de sesión correcto"),
          content: Text("¡Bienvenido! Has iniciado sesión correctamente."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
              },
              child: Text("Aceptar"),
            ),
          ],
        );
      },
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}
