import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqfilt_app/Controller/Controller.dart';

var controller = Get.put(BudgetController());

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF89A4BE),
        leading: Icon(Icons.account_circle, color: Colors.white),
        centerTitle: true,
        title: const Text(
          'Budget Tracker ',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        height: 800,
        width: 400,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/image/bgsecond.jpeg'))),
        child: Obx(
          () => Column(
            children: [
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap:(){
                        controller.totalBalance(1);


                      },

                      child: Container(
                        height: 40,
                        width: 180,
                        decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey, width: 0.5)),
                        child: Center(
                          child: Row(
                            children: [
                              Text(
                                'Total Income:',
                                style: const TextStyle(
                                    color: Colors.greenAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              Text(
                                controller.totalIncome != 0.0.obs
                                    ? ' ${controller.totalIncome}'
                                    : '',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5,),
                    InkWell(
                      onTap: (){
                        controller.totalBalance(0);

                      },
                      child: Container(
                        height: 40,
                        width: 180,
                        decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey, width: 0.5)),
                        child: Center(
                          child: Row(
                            children: [
                              Text(
                                'Total Excpnce: ',
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 16),
                              ),
                              Text(
                                controller.totalExpense != 0.0.obs
                                    ? ' ${controller.totalExpense}'
                                    : '',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5,),
                    InkWell(
                      onTap: (){
                        controller.getRecords();
                      },
                      child: Container(
                        height: 40,
                        width: 180,
                        decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey, width: 0.5)),
                        child: Center(
                          child: Row(
                            children: [
                              Text(
                                'Total Balance: ',
                                style: const TextStyle(
                                    color: Colors.blue, fontSize: 16),
                              ),
                              Text('${controller.totalIncome.value + controller.totalExpense.value}',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => Card(
                    color: controller.data[index]['isIncome'] == 1
                        ? Colors.green.shade100
                        : Colors.red.shade100,
                    child: ListTile(
                      leading: Text(controller.data[index]['id'].toString()),
                      title: Text(controller.data[index]['amount'].toString()),
                      subtitle:
                          Text(controller.data[index]['category'].toString()),
                      trailing: IconButton(
                          onPressed: () {
                            controller.removeRecord(
                              int.parse(
                                controller.data[index]['id'].toString(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.delete)),
                    ),
                  ),
                  itemCount: controller.data.length,
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Add Record'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller.txtCategory,
                    decoration: InputDecoration(labelText: 'Category'),
                  ),
                  TextField(
                    controller: controller.txtAmount,
                    decoration: InputDecoration(labelText: 'Amount'),
                  ),
                  Obx(
                    () => SwitchListTile(
                      title: const Text('Income/Expense'),
                      value: controller.isIncome.value,
                      onChanged: (value) {
                        controller.setIncome(value);
                      },
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () {
                      double amount = double.parse(controller.txtAmount.text);
                      int isIncome = controller.isIncome.value ? 1 : 0;
                      String category = controller.txtCategory.text;
                      controller.insertRecord(amount, isIncome, category);

                      controller.txtAmount.clear();
                      controller.txtCategory.clear();
                      controller.setIncome(false);
                      Get.back();
                    },
                    child: const Text('Save'))
              ],
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
