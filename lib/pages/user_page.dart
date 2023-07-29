import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/model.dart';
import 'package:flutter_application_2/pages/my_home_page.dart';
import 'package:flutter_application_2/services/data_base.dart';
import 'package:flutter_application_2/widgets/textfromfield.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPage extends ConsumerStatefulWidget {
  const UserPage({super.key});

  @override
  ConsumerState<UserPage> createState() => _UserPageState();
}

final GlobalKey<FormState> fromkey = GlobalKey<FormState>();
final TextEditingController namecontroller = TextEditingController();
final TextEditingController addresscontroller = TextEditingController();
class _UserPageState extends ConsumerState<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("User Page"),
        centerTitle: true,
      ),
      body: Form(
        key: fromkey,
        child: Column(
          children: [
            TFromField(
              controller: namecontroller,
              hinttext: "Name",
              labelText: "Name",
              icon: const Icon(Icons.person),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter your valid address";
                } else {
                  return null;
                }
              },
            ),
            TFromField(
              controller: addresscontroller,
              hinttext: "Address",
              labelText: "Address",
              icon: const Icon(Icons.home),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter your valid Name";
                } else {
                  return null;
                }
              },
            ),
            ElevatedButton(
              onPressed: () async {
                if (fromkey.currentState!.validate() == true) {
                  await DataBaseHelper.instance.addUsers(Model(
                      name: namecontroller.text,
                      address: addresscontroller.text,));
                      
                  final refresh =ref.refresh(futureProviderData);
                  Navigator.pop(context);
                  print("data");
                } else {
                  log("Error");
                }
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
