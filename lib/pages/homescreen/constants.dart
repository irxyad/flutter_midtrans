part of 'home.dart';

class GenerateTextC {
  final String name;
  final TextEditingController controller;

  GenerateTextC({required this.name, required this.controller});
}

final GenerateTextC _amountController = GenerateTextC(
  name: 'Amount',
  controller: TextEditingController(text: '10000'),
);

final GenerateTextC _firstNameController = GenerateTextC(
  name: 'First Name',
  controller: TextEditingController(text: 'John'),
);

final GenerateTextC _emailController = GenerateTextC(
  name: 'Email',
  // For testing, you can use a fake email at https://inboxes.com
  controller: TextEditingController(text: 'napige5242@tafmail.com'),
);

final GenerateTextC _phoneController = GenerateTextC(
  name: 'Phone',
  controller: TextEditingController(text: '08xxxxxxxxx'),
);
