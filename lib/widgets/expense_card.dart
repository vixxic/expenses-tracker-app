
import 'package:flutter/material.dart';

class ExpenseCard extends StatelessWidget {
  final Map<String, dynamic> expense;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ExpenseCard({
    super.key,
    required this.expense,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF232B54),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF171C33),
      ),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      expense['expense_name'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Row(
                      spacing: 5,
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF2B138),
                            shape: BoxShape.circle,
                          ),
                        ),

                        Text(
                          expense['category'],
                          style: const TextStyle(
                            color: Color(0xFFADB1C3),
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        expense['notes'] ?? '',
                        style: const TextStyle(
                          color: Color(0xFFADB1C3),
                        ),
                      ),
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Rp${expense['amount']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    Text(
                      '${expense['date']}',
                      style: const TextStyle(
                        color: Color(0xFFADB1C3),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Divider(
                color: Color(0xFF232B54),
                thickness: 1,
              ),
            ),

            Row(
              spacing: 25,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),

                  onPressed: () {
                    onEdit();
                  },

                  child: const Text(
                    "Edit",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),

                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),

                  onPressed: onDelete,

                  child: const Text(
                    "Delete",
                    style: TextStyle(
                      color: Color(0xFFEF6D7C),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
