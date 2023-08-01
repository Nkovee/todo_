// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/model.dart';
import 'package:flutter_application_2/pages/my_home_page.dart';
import 'package:flutter_application_2/services/data_base.dart';
import 'package:flutter_application_2/widgets/textfromfield.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditPage extends ConsumerStatefulWidget {
  final Model model;
  const EditPage(this.model, {super.key});

  @override
  ConsumerState<EditPage> createState() => _EditPageState();
}

final GlobalKey<FormState> fromkey = GlobalKey<FormState>();
final TextEditingController namecontroller = TextEditingController();
final TextEditingController addresscontroller = TextEditingController();

class _EditPageState extends ConsumerState<EditPage> {
  @override
  void initState() {
    super.initState();
    namecontroller.text = widget.model.name ?? "";
    addresscontroller.text = widget.model.address ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Edit Page"),
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
                  final Model model = Model(
                    id: widget.model.id,
                    name: namecontroller.text,
                    address: addresscontroller.text,
                  );
                  await DataBaseHelper.instance.upDateUser(model);
                  final refresh = ref.refresh(futureProviderData);
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
