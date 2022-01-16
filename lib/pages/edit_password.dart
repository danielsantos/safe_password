import 'package:flutter/material.dart';
import 'package:safe_password/models/pass.dart';
import '../db_util.dart';

class EditPasswordPage extends StatelessWidget {
  EditPasswordPage({Key? key}) : super(key: key);

  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerPass = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Pass pass = ModalRoute.of(context)!.settings.arguments as Pass;
    controllerTitle.text = pass.title;
    controllerPass.text = pass.pass;
    controllerDescription.text = pass.description;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Segura'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 160,
              margin: const EdgeInsets.only(top: 200.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controllerTitle,
                      decoration: const InputDecoration(hintText: 'Título'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controllerPass,
                      decoration: const InputDecoration(hintText: 'Senha'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controllerDescription,
                      decoration: const InputDecoration(hintText: 'Descrição'),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    DbUtil.insert('pass', {
                      'id': 1,
                      'title': controllerTitle.text,
                      'pass': controllerPass.text,
                      'description': controllerDescription.text
                    });
                    Navigator.of(context).pushReplacementNamed('/home');
                  },
                  child: const Text('SALVAR'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
