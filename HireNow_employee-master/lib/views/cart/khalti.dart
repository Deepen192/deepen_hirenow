import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';


class KhaltiPaymentPage extends StatefulWidget {
  final String jobId;
  final Map<String, dynamic> jobData;
  final String userId;

  const KhaltiPaymentPage({super.key, required this.userId, required this.jobId, required this.jobData});

  @override
  State<KhaltiPaymentPage> createState() => _KhaltiPaymentPageState();
}

class _KhaltiPaymentPageState extends State<KhaltiPaymentPage> {
  TextEditingController amountController = TextEditingController();
  int totalPrice = 0;

  @override
  void initState() {
    super.initState();
    calculateTotalPrice();
  }

  void calculateTotalPrice() {
    setState(() {
      totalPrice = int.tryParse(widget.jobData['p_price'].toString()) ?? 0;
      amountController.text =  'Rs. $totalPrice'.toString(); // Update amountController with total price
    });
  }

  int getAmt() {
    return totalPrice * 100; // Converting to paisa
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFDAD3BE),
        title: const Text('Khalti Payment Integration'),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product: ${widget.jobData['p_name']}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    readOnly: true, 
                    decoration: const InputDecoration(
                      labelText: 'Amount to pay',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.red),
                      ),
                      height: 50,
                      color: const Color(0xFF56328c),
                      child: const Text(
                        'Pay With Khalti',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      onPressed: () {
                        if (totalPrice > 0) {
                          KhaltiScope.of(context).pay(
                            config: PaymentConfig(
                              amount: getAmt(),
                              productIdentity: widget.jobId,
                              productName: widget.jobData['p_name'],
                            ),
                            preferences: [
                              PaymentPreference.khalti,
                            ],
                            onSuccess: (su) {
                              const successSnackBar = SnackBar(
                                content: Text('Payment Successful'),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
                            },
                            onFailure: (fa) {
                              const failedSnackBar = SnackBar(
                                content: Text('Payment Failed'),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(failedSnackBar);
                            },
                            onCancel: () {
                              const cancelSnackBar = SnackBar(
                                content: Text('Payment Cancelled'),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(cancelSnackBar);
                            },
                          );
                        } else {
                          print('Invalid amount to pay');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
