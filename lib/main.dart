import 'package:flutter/material.dart';
import 'add_data_screen.dart';
import 'database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ExpenseApp());
}

class ExpenseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final db = DatabaseHelper();
  int income = 0;
  int expense = 0;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    income = await db.getTotalByType('Income');
    expense = await db.getTotalByType('Expense');
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    int saving = income - expense;

    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Income & Expense"),
        centerTitle: true,
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  Card(
                    child: ListTile(
                      title: Text("Total Income"),
                      trailing: Text("৳ \$income"),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text("Total Expense"),
                      trailing: Text("৳ \$expense"),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text("Savings"),
                      trailing: Text("৳ \$saving"),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        icon: Icon(Icons.arrow_downward),
                        label: Text("Add Income"),
                        onPressed: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => AddDataScreen(type: "Income")));
                          loadData();
                        },
                      ),
                      ElevatedButton.icon(
                        icon: Icon(Icons.arrow_upward),
                        label: Text("Add Expense"),
                        onPressed: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => AddDataScreen(type: "Expense")));
                          loadData();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: FutureBuilder(
                      future: db.getAll(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return Center(child: Text("No records"));
                        final rows = snapshot.data as List<Map<String, dynamic>>;
                        if (rows.isEmpty) return Center(child: Text("No records"));
                        return ListView.builder(
                          itemCount: rows.length,
                          itemBuilder: (context, i) {
                            final r = rows[i];
                            return ListTile(
                              leading: Text(r['type'][0]),
                              title: Text(r['note'] ?? ''),
                              subtitle: Text(r['date']),
                              trailing: Text("৳ ${r['amount']}"),
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
