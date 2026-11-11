import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/expenses_data.dart';

class AddExpensePage extends StatefulWidget {
  final Map<String, dynamic>? expense;

  const AddExpensePage({
    super.key,
    this.expense,
  });

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  @override
  void initState() {
    super.initState();

    if (widget.expense != null) {
      nameController.text =
          widget.expense!['expense_name'] ?? '';

      amountController.text =
          widget.expense!['amount'].toString();

      dateController.text =
          widget.expense!['date'] ?? '';

      notesController.text =
          widget.expense!['notes'] ?? '';

      selectedCategory = categories.contains(
        widget.expense!['category'],
      )
          ? widget.expense!['category']
          : null;
    }
  }

  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController notesController = TextEditingController();


  String? selectedCategory;

  DateTime selectedDate = DateTime.now();

  List<String> categories = [
    'Food',
    'Transport',
    'Shopping',
    'Entertainment',
    'Others',
  ];

  @override
  void dispose() {
    dateController.dispose();
    amountController.dispose();
    nameController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0E1222),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            widget.expense == null ? "Add Expense" : "Edit Expense",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
        backgroundColor: Color(0xFF0E1222),
      ),

      body: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text(
                  "Expense name",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                SizedBox(height: 10),

                TextFormField(
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "Name cannot be empty";
                    }
                    return null;
                  },
                  controller: nameController,
                  style: TextStyle(
                      color: Colors.white
                  ),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFF1D2340),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),

                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFF2B138), width: 2),
                          borderRadius: BorderRadius.circular(12)
                      )
                  ),
                ),

                SizedBox(height: 25),

                // Category
                Text(
                  "Category",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                SizedBox(height: 10),

                DropdownButtonFormField<String>(
                  validator: (value) {
                    if (value == null) {
                      return "Please choose a category";
                    }

                    return null;
                  },
                  value: selectedCategory,
                  dropdownColor: const Color(0xFF1D2340),
                  style: const TextStyle(
                    color: Colors.white,
                  ),

                  hint: const Text(
                    'Choose category',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),

                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF1D2340),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFF2B138),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                  items: categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                ),

                SizedBox(height: 25),

                // Amount
                Text(
                  "Amount",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                SizedBox(height: 10),

                TextFormField(
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "Amount cannot be empty";
                    }
                    return null;
                  },
                  controller: amountController,
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: false
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: TextStyle(
                      color: Colors.white
                  ),

                  decoration: InputDecoration(
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 12, right: 8),
                        child: Center(
                          widthFactor: 1,
                          child: Text(
                            'Rp',
                            style: TextStyle(
                              color: Color(0xFF727A98),
                            ),
                          ),
                        ),
                      ),

                      filled: true,
                      fillColor: Color(0xFF1D2340),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),

                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFF2B138), width: 2),
                          borderRadius: BorderRadius.circular(12)
                      )
                  ),
                ),

                SizedBox(height: 25),

                // Date
                Text(
                  "Date",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                SizedBox(height: 10),

                TextFormField(
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "Pick a date";
                    }
                    return null;
                  },
                  readOnly: true,
                  controller: dateController,
                  style: TextStyle(
                      color: Colors.white
                  ),
                  decoration: InputDecoration(
                    hintText: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                    hintStyle: TextStyle(
                        color: Colors.white
                    ),
                    suffixIcon: Icon(
                      Icons.calendar_month,
                      color: Colors.white,
                    ),
                    filled: true,
                    fillColor: Color(0xFF1D2340),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),

                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF2B138), width: 2),
                        borderRadius: BorderRadius.circular(12)
                    ),
                  ),

                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030)
                    );

                    if(pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;

                        dateController.text =
                        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                      });
                    }
                  },
                ),

                SizedBox(height: 25),

                // Notes
                Text(
                  "Notes (optional)",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                SizedBox(height: 10),

                TextFormField(
                  controller: notesController,
                  style: TextStyle(
                      color: Colors.white
                  ),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFF1D2340),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),

                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFF2B138), width: 2),
                          borderRadius: BorderRadius.circular(12)
                      )
                  ),
                ),

                SizedBox(height: 40),

                // Save Expense Button
                Container(
                    width: double.infinity,
                    height: 60,
                    child: FloatingActionButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          Map<String, dynamic> updatedExpense = {
                            'expense_name': nameController.text.trim(),
                            'category': selectedCategory,
                            'amount': int.tryParse(amountController.text.trim()) ?? 0,
                            'date': dateController.text,
                            'notes': notesController.text.trim(),
                          };

                          Navigator.pop(context, updatedExpense);
                        }
                      },
                      backgroundColor: Color(0xFFF2B138),

                      child: Text(
                        widget.expense == null
                            ? "Save Expense"
                            : "Save Changes",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0E1222),
                        ),
                      ),
                    )
                ),

                SizedBox(height: 10),

                // Cancel Expense Button
                Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Color(0xFF333b63),
                            width: 2
                        )
                    ),
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      backgroundColor: Color(0xFF0E1222),
                      child: Text("Cancel", style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),),
                    )
                )
              ],
            ),
          )
      ),

    );
  }
}
