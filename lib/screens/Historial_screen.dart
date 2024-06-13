import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cuenta y Transacciones',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/account',
      routes: {
        '/account': (context) => AccountScreen(),
        '/transactions': (context) => TransactionHistoryScreen(),
      },
      home: AccountScreen(),
    );
  }
}

class Transaction {
  final String type;
  final int amount;
  final int balance;

  Transaction({required this.type, required this.amount, required this.balance});
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
              Navigator.pushNamed(context, '/transactions');
            },
            tooltip: 'Ver transacciones',
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
            Navigator.pushNamed(context, '/account');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/transactions');
          }
        },
      ),
    );
  }
}

class TransactionHistoryScreen extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(type: 'Retiro', amount: 30, balance: 450),
    Transaction(type: 'Impuestos', amount: 0, balance: 450),
    Transaction(type: 'Compra', amount: 100, balance: 350),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial de Transacciones'),
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Text('${transactions[index].type}'),
              subtitle: Text(
                'Monto: \$${transactions[index].amount} | Saldo: \$${transactions[index].balance}',
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
            Navigator.pushNamed(context, '/account');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/transactions');
          }
        },
      ),
    );
  }
}
