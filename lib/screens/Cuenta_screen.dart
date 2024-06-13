import 'package:flutter/material.dart';

void main() => runApp(MiAplicacion());

class MiAplicacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cuenta y Transacciones',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/cuenta',
      routes: {
        '/cuenta': (context) => AccountScreen(),
        '/transacciones': (context) => TransactionHistoryScreen(),
      },
      home: AccountScreen(),
    );
  }
}

class Transaccion {
  final String tipo;
  final int monto;
  final int saldo;

  Transaccion({required this.tipo, required this.monto, required this.saldo});
}

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cuenta'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.description),
            onPressed: () {
              Navigator.pushNamed(context, '/transacciones');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage('lib/assets/ima.jpg'),
              radius: 50,
            ),
            SizedBox(height: 20),
            Text(
              'Número de cuenta: 123456789',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Valor total de la cuenta: \$1000.00',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: 'Cuenta',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historial',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/cuenta');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/transacciones');
          }
        },
      ),
    );
  }
}

class TransactionHistoryScreen extends StatelessWidget {
  final List<Transaccion> transacciones = [
    Transaccion(tipo: 'Retiro', monto: 30, saldo: 450),
    Transaccion(tipo: 'Impuestos', monto: 0, saldo: 450),
    Transaccion(tipo: 'Compra', monto: 100, saldo: 350),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial de Transacciones'),
      ),
      body: ListView.builder(
        itemCount: transacciones.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Text('${transacciones[index].tipo}'),
              subtitle: Text(
                'Monto: \$${transacciones[index].monto} | Saldo: \$${transacciones[index].saldo}',
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: 'Cuenta',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historial',
          ),
        ],
        currentIndex: 1,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/cuenta');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/transacciones');
          }
        },
      ),
    );
  }
}
