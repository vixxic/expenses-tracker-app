
import 'package:flutter/material.dart';
import '../widgets/expense_card.dart';
import '../widgets/delete_confirmation.dart';
import 'add_expense.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Map<String, dynamic>> expenses = [];

  // ADD EXPENSE
  Future<void> openAddExpense() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => const AddExpensePage(),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        expenses.add(result);
      });
    }
  }

  // EDIT EXPENSE
  Future<void> openEditExpense(int index) async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => AddExpensePage(
          expense: expenses[index],
        ),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        expenses[index] = result;
      });
    }
  }

  // DELETE EXPENSE
  Future<void> deleteExpense(int index) async {
    final expense = expenses[index];

    final confirm = await showDeleteConfirmation(
      context,
      expense,
    );

    if (confirm == true && mounted) {
      setState(() {
        expenses.removeAt(index);
      });
    }
  }

  // CALCULATE TOTAL
  int calculateTotalExpenses() {
    int total = 0;

    for (int i = 0; i < expenses.length; i++) {
      total += (expenses[i]['amount'] as num).toInt();
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E1222),

      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "MyExpense",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
        backgroundColor: const Color(0xFF0E1222),
      ),

      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [

            // TOTAL EXPENSES CARD
            Container(
              width: double.infinity,
              height: 190,
              decoration: BoxDecoration(
                color: const Color(0xFF232B54),
                borderRadius: BorderRadius.circular(20),
              ),

              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    const Text(
                      "Total expenses",
                      style: TextStyle(
                        color: Color(0xFF9398AE),
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    Text(
                      "Rp ${calculateTotalExpenses()}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const LinearProgressIndicator(
                      value: 1,
                      backgroundColor: Color(0xFF0E1222),
                      color: Color(0xFFF2B138),
                      minHeight: 10,
                    ),

                    Text(
                      "${expenses.length} expenses",
                      style: const TextStyle(
                        color: Color(0xFF9398AE),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // EXPENSE LIST / EMPTY STATE
            Expanded(
              child: expenses.isEmpty

              // EMPTY STATE
                  ? const Center(
                child: Text(
                  "No expenses yet. Add your first expense!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF9398AE),
                    fontSize: 15,
                  ),
                ),
              )

              // EXPENSE LIST
                  : ListView.builder(
                padding: const EdgeInsets.only(top: 20),
                itemCount: expenses.length,

                itemBuilder: (context, index) {
                  final expense = expenses[index];

                  return ExpenseCard(
                    expense: expense,

                    // EDIT
                    onEdit: () {
                      openEditExpense(index);
                    },

                    // DELETE
                    onDelete: () {
                      deleteExpense(index);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // ADD EXPENSE BUTTON
      bottomNavigationBar: Container(
        height: 80,
        color: const Color(0xFF171C33),
        padding: const EdgeInsets.only(
          bottom: 25,
          left: 25,
          right: 25,
        ),

        child: FloatingActionButton(
          onPressed: openAddExpense,
          backgroundColor: const Color(0xFFF2B138),

          child: const Text(
            "Add Expense",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
