import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gan/pages/GroupChat.dart';
import 'package:gan/pages/Home.dart';
import 'package:gan/pages/TakePicture.dart';
import 'package:gan/pages/UserProfile.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/services/NavigatorService.dart';
import 'package:gan/widgets/NavigationButton.dart';
import 'package:intl/intl.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}


class _MyNavigationBarState extends State<MyNavigationBar> {


  Future<void> showCreateVoucherDialog() async{
    final _formKey = GlobalKey<FormState>();
    final _titleController = TextEditingController();
    final _discountController = TextEditingController();
    final _capController = TextEditingController();
    final _pointsController = TextEditingController();
    DateTime? expiryDate;

    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Create Voucher'),
              content: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(labelText: 'Shop Name'),
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                      ),
                      GestureDetector(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: expiryDate ?? DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 365)),
                          );
                          if (picked != null) {
                            setState(() => expiryDate = picked);
                          }
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Expiry Date',
                              hintText: expiryDate == null
                                  ? 'Select date'
                                  : DateFormat('dd/MM/yyyy').format(expiryDate!),
                            ),
                            validator: (_) =>
                            expiryDate == null ? 'Pick a date' : null,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _discountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'Discount (%)'),
                        validator: (value) {
                          final n = double.tryParse(value ?? '');
                          if (n == null || n < 0 || n > 100) {
                            return 'Enter 0-100';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _capController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'Cap Limit (RM)'),
                        validator: (value) =>
                        double.tryParse(value ?? '') == null
                            ? 'Invalid number'
                            : null,
                      ),
                      TextFormField(
                        controller: _pointsController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'Points Required'),
                        validator: (value) =>
                        int.tryParse(value ?? '') == null
                            ? 'Invalid number'
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async{
                    if (_formKey.currentState?.validate() == true &&
                        expiryDate != null) {
                      final data = {
                        'title': _titleController.text.trim(),
                        'expiryTimestamp': Timestamp.fromDate(expiryDate!).millisecondsSinceEpoch,
                        'discountPercentage':
                        double.parse(_discountController.text.trim()),
                        'discountCap': double.parse(_capController.text.trim()),
                        'requiredPoints':
                        int.parse(_pointsController.text.trim()),
                      };
                      
                      final ref=await AuthService.db.collection('vouchers').add(data);
                      ref.update({"id":ref.id});


                      Navigator.of(context).pop(data);
                      Fluttertoast.showToast(msg: "Voucher created successfully!");
                    }
                  },
                  child: Text('Create'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> showVouchers() async {
    final vouchersRef = FirebaseFirestore.instance.collection('vouchers');

    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Manage Vouchers'),
              content: FutureBuilder<QuerySnapshot>(
                future: vouchersRef.get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(height: 100, child: Center(child: CircularProgressIndicator()));
                  }

                  if (snapshot.hasError) {
                    return Text('Error loading vouchers');
                  }

                  final docs = snapshot.data?.docs ?? [];

                  if (docs.isEmpty) {
                    return Text('No vouchers found.');
                  }

                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: docs.map((doc) {
                        final data = doc.data() as Map<String, dynamic>;
                        final expiry = Timestamp.fromMillisecondsSinceEpoch(data['expiryTimestamp']).toDate();
                        final formattedDate = DateFormat('yyyy-MM-dd').format(expiry);

                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(data['title'] ?? 'No title'),
                          subtitle: Text('Expires: $formattedDate\nPoints: ${data['requiredPoints']}'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              await vouchersRef.doc(doc.id).delete();
                              setState(() {}); // Refresh UI
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        height: 55,
        width: MediaQuery
            .sizeOf(context)
            .width,
        clipBehavior: Clip.none,
        decoration: ShapeDecoration(
          color: const Color(0xFFE0FBFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NavigationButton(
              label: 'Home',
              icon: Icons.home,
              onTap: () {
                NavigatorService.openPage(Home(), false);
              },
            ),
            NavigationButton(
              label: 'Chats',
              icon: Icons.chat,
              onTap: () {
                NavigatorService.openPage(GroupChat(), false);
              },
            ),

            NavigationButton(
              label: 'Scan',
              icon: Icons.camera_alt,
              onTap: () {
                NavigatorService.openPage(TakePicture(doPopAfterDone: false), false);
              },
            ),
            NavigationButton(
              label: 'Test',
              icon: Icons.new_releases,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Test functions'),
                      actions: [
                        ElevatedButton(
                          onPressed: ()async{await showCreateVoucherDialog();},
                          child: Text('Create vouchers'),
                        ),
                        ElevatedButton(
                          onPressed: ()async{await showVouchers();},
                          child: Text('Manage vouchers'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            NavigationButton(
              label: 'Profile',
              icon: Icons.account_circle,
              onTap: () {
                NavigatorService.openPage(
                  UserProfile(viewingUID: AuthService.uid),
                  true,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
