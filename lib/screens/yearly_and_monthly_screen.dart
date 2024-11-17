import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tips_app_from_scratch/styles/theme.dart';
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

    // Filter tips by current year
    final yearlyTips = tipProvider.items.where((tip) {
      final tipDate = DateFormat('yyyy-MM-dd').parse(tip.date);
      return tipDate.year == _currentYear.year;
    }).toList();

    // Calculate monthly totals for Euros and Dollars
    final monthlyTotalEuro = monthlyTips
        .where((tip) => tip.currency) // Euros
        .fold(0.0, (sum, tip) => sum + tip.amount);
    final monthlyTotalDollar = monthlyTips
        .where((tip) => !tip.currency) // Dollars
        .fold(0.0, (sum, tip) => sum + tip.amount);

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
              child: monthlyTips.isNotEmpty
                  ? ListView.builder(
                      itemCount: monthlyTips.length,
                      itemBuilder: (context, index) {
                        final tip = monthlyTips[index];
                        return Card(
                          color: Colors.teal,
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            textColor: Colors.white,
                            title: Text(DateFormat('MMMM d').format(
                                DateFormat('yyyy-MM-dd').parse(tip.date))),
                            trailing: Text(
                              "${tip.currency ? '€' : '\$'}${tip.amount.toStringAsFixed(2)}",
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
