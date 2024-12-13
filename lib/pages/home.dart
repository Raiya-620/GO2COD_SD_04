import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_generator/pages/password_generator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int passwordLength = 8;
  bool includeUpperCase = true;
  bool includeLowerCase = true;
  bool includeNumbers = true;
  bool includeSpecialCharacters = true;
  List<String> generatePasswords = [];

  void generatePassword() {
    try {
      if (passwordLength < 6) {
        throw Exception('Password length should be atleast 6 characters long');
      }
      if (!includeUpperCase &&
          !includeLowerCase &&
          !includeNumbers &&
          !includeSpecialCharacters) {
        throw Exception('Atleast one character type must be selected');
      }
      String password = randomPasswordGenerator(
          length: passwordLength,
          includeUpperCase: includeUpperCase,
          includeLowerCase: includeLowerCase,
          includeNumbers: includeNumbers,
          includeSpecialCharacters: includeSpecialCharacters);
      setState(() {
        generatePasswords.add(password);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Password Generator')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Input Password length',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  passwordLength = int.tryParse(value) ?? 8;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Select Options:'),
            const SizedBox(
              height: 20,
            ),
            CheckboxListTile(
              title: const Text('Include uppercase'),
              value: includeUpperCase,
              onChanged: (value) {
                setState(() {
                  includeUpperCase = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Include lowercase'),
              value: includeLowerCase,
              onChanged: (value) {
                setState(() {
                  includeLowerCase = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Include numbers'),
              value: includeNumbers,
              onChanged: (value) {
                setState(() {
                  includeNumbers = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Include special characters'),
              value: includeSpecialCharacters,
              onChanged: (value) {
                setState(() {
                  includeSpecialCharacters = value!;
                });
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  generatePassword();
                },
                child: const Text(
                  'Generate Password',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: generatePasswords.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(generatePasswords[index]),
                    trailing: IconButton(
                      onPressed: () {
                        Clipboard.setData(
                            ClipboardData(text: generatePasswords[index]));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Password Copied to Clipboard'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.copy),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
