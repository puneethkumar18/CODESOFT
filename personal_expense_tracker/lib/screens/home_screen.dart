import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/provider/transactions_provider.dart';
import 'package:personal_expense_tracker/provider/user_provider.dart';
import 'package:personal_expense_tracker/screens/add_transaction_screen.dart';
import 'package:personal_expense_tracker/utils/utils.dart';
import 'package:personal_expense_tracker/widgets/custom_text_field.dart';
import 'package:personal_expense_tracker/widgets/price_with_label.dart';
import 'package:personal_expense_tracker/widgets/transaction_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home-screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime time = DateTime.now();
  final TextEditingController updateIncomeController = TextEditingController();

  void onDateChange(String state) {
    if (state == 'increment') {
      time = DateTime(
        time.year,
        time.month,
        time.day + 1,
      );
    } else {
      time = DateTime(
        time.year,
        time.month,
        time.day - 1,
      );
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    updateIncomeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final transactionsProvider = Provider.of<TransactionsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'My Expenses',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black87,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {
                              onDateChange('decrement');
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${months[time.month - 1]},${time.year}',
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              onDateChange('increment');
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        PriceWithLabel(
                          label: 'EXPENSE',
                          price: transactionsProvider.totalExpence,
                        ),
                        PriceWithLabel(
                          label: 'INCOME',
                          price: userProvider.user.income,
                        ),
                        PriceWithLabel(
                          label: 'BALANCE',
                          price: userProvider.user.income -
                              transactionsProvider.totalExpence,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${months[time.month - 1]} ${time.day.toString()} ,${days[time.weekday - 1]}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 2,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              TransactionList(
                time: time,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Colors.black,
          size: 30,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                actionsOverflowAlignment: OverflowBarAlignment.center,
                contentPadding: const EdgeInsets.all(20),
                actionsAlignment: MainAxisAlignment.center,
                title: const Text('Choose the options'),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return BottomSheet(
                              onClosing: () {},
                              builder: (context) {
                                return SizedBox(
                                  height: 300,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Enter your Updated Income',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        CustomTextField(
                                          hinttext: "Enter Here",
                                          controller: updateIncomeController,
                                          isNum: true,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            ElevatedButton(
                                              style: const ButtonStyle(
                                                backgroundColor:
                                                    WidgetStatePropertyAll(
                                                  Colors.black,
                                                ),
                                              ),
                                              onPressed: () {
                                                var user = userProvider.user;

                                                var updatedUser = user.copyWith(
                                                  income: double.parse(
                                                    updateIncomeController.text
                                                        .trim(),
                                                  ),
                                                );

                                                updateIncomeController.text =
                                                    '';
                                                userProvider.setUserByModel(
                                                  updatedUser,
                                                );

                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                'Confirm',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.black),
                        minimumSize:
                            WidgetStatePropertyAll(Size.fromHeight(60)),
                      ),
                      child: const Text(
                        'Update Income',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(
                          context,
                          AddTransactionScreen.routeName,
                        );
                      },
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.black),
                        minimumSize:
                            WidgetStatePropertyAll(Size.fromHeight(60)),
                      ),
                      child: const Text(
                        'Add Transaction',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'close',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
