import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tips_tracker/styles/theme.dart';
import '../controller/tip_provider.dart';

class MonthlyAndYearlyTipsScreen extends StatefulWidget {
  const MonthlyAndYearlyTipsScreen({super.key});

  @override
  State<MonthlyAndYearlyTipsScreen> createState() =>
      _MonthlyAndYearlyTipsScreenState();
}

class _MonthlyAndYearlyTipsScreenState
    extends State<MonthlyAndYearlyTipsScreen> {
  DateTime _currentMonth = DateTime.now();
  DateTime _currentYear = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final tipProvider = Provider.of<TipProvider>(context);

    // Filter tips by current month
    final monthlyTips = tipProvider.items.where((tip) {
      final tipDate = DateFormat('yyyy-MM-dd').parse(tip.date);
      return tipDate.year == _currentMonth.year &&
          tipDate.month == _currentMonth.month;
    }).toList();

    // Agrupar tips por fecha
    final groupedTips = <String, Map<String, double>>{};
    for (var tip in monthlyTips) {
      final tipDate = DateFormat('yyyy-MM-dd').parse(tip.date);
      final formattedDate = DateFormat('MMMM d').format(tipDate);

      // Inicializar si no existe
      groupedTips[formattedDate] ??= {'euro': 0.0, 'dollar': 0.0};

      // Sumar montos según la moneda
      if (tip.currency) {
        groupedTips[formattedDate]!['euro'] =
            (groupedTips[formattedDate]!['euro'] ?? 0) + tip.amount;
      } else {
        groupedTips[formattedDate]!['dollar'] =
            (groupedTips[formattedDate]!['dollar'] ?? 0) + tip.amount;
      }
    }

    // Lista de fechas con sus totales combinados
    final groupedTipsList = groupedTips.entries
        .map((entry) => {
              'date': entry.key,
              'euro': entry.value['euro']!,
              'dollar': entry.value['dollar']!,
            })
        .toList();

    // Calcular totales mensuales para resumen
    final monthlyTotalEuro = groupedTipsList.fold(
        0.0, (sum, entry) => sum + (entry['euro'] as double));
    final monthlyTotalDollar = groupedTipsList.fold(
        0.0, (sum, entry) => sum + (entry['dollar'] as double));



    // Filter tips by current year
    final yearlyTips = tipProvider.items.where((tip) {
      final tipDate = DateFormat('yyyy-MM-dd').parse(tip.date);
      return tipDate.year == _currentYear.year;
    }).toList();



    // Calculate yearly totals for Euros and Dollars
    final yearlyTotalEuro = yearlyTips
        .where((tip) => tip.currency) // Euros
        .fold(0.0, (sum, tip) => sum + tip.amount);
    final yearlyTotalDollar = yearlyTips
        .where((tip) => !tip.currency) // Dollars
        .fold(0.0, (sum, tip) => sum + tip.amount);
        
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Summary'),
        backgroundColor: Colors.teal,
        titleTextStyle: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Monthly Summary
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _currentMonth =
                          DateTime(_currentMonth.year, _currentMonth.month - 1);
                    });
                  },
                  icon: const Icon(Icons.arrow_back),color: Colors.grey
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('MMMM yyyy').format(_currentMonth),
                      style: AppTextStyles.mainTitleSecondary,
                    ),
                    Text(
                      "Total: €${monthlyTotalEuro.toStringAsFixed(2)} / \$${monthlyTotalDollar.toStringAsFixed(2)}",
                      style: AppTextStyles.subtitle,
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _currentMonth =
                          DateTime(_currentMonth.year, _currentMonth.month + 1);
                    });
                  },
                  icon: const Icon(Icons.arrow_forward),color: Colors.grey
                ),
              ],
            ),
            const SizedBox(height: 8),


Expanded(
  child: groupedTipsList.isNotEmpty
      ? ListView.builder(
          itemCount: groupedTipsList.length,
          itemBuilder: (context, index) {
            final tipData = groupedTipsList[index];
            final euro = tipData['euro'] as double;
            final dollar = tipData['dollar'] as double;

            return Card(
              color: Colors.teal,
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: ListTile(
                textColor: Colors.white,
                title: Text(tipData['date'] as String),
                trailing: Text(
                  "${euro > 0 ? '€${euro.toStringAsFixed(2)}' : ''} ${dollar > 0 ? '/ \$${dollar.toStringAsFixed(2)}' : ''}".trim(),
                  style: AppTextStyles.cardPriceText,
                ),
              ),
            );
          },
        )
      : const Center(
          child: Text(
            "No tips for this month yet!",
            style: AppTextStyles.mainNotFoundTitle,
          ),
        ),
),

            
            
            const Divider(),
            // Yearly Summary
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _currentYear = DateTime(_currentYear.year - 1);
                    });
                  },
                  icon: const Icon(Icons.arrow_back),color: Colors.grey,
                ),
                Text(DateFormat('yyyy').format(_currentYear),
                    style: AppTextStyles.mainTitleSecondary),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _currentYear = DateTime(_currentYear.year + 1);
                    });
                  },
                  icon: const Icon(Icons.arrow_forward),color: Colors.grey
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Display yearly totals in two cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  // color: Colors.white,
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        //  const Text(
                        //   "Total (€)",
                        //   style: TextStyle(
                        //     color: Colors.teal,
                        //     fontSize: 18,
                        //     fontWeight: FontWeight.bold
                        //   ),
                        // ),
                        const SizedBox(height: 4),
                        Text(
                          "€ ${yearlyTotalEuro.toStringAsFixed(2)}",
                          style: AppTextStyles.mainTitleSecondary,
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // const Text(
                        //   "Total (\$)",
                        //   style: TextStyle(
                        //       color: Colors.teal,
                        //       fontSize: 18,
                        //       fontWeight: FontWeight.bold),
                        // ),
                        const SizedBox(height: 4),
                        Text(
                          "\$ ${yearlyTotalDollar.toStringAsFixed(2)}",
                          style: AppTextStyles.mainTitleSecondary,
                        ),
                      ],
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
