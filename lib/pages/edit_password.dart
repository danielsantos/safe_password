import 'package:flutter/material.dart';
import 'package:safe_password/models/pass.dart';
import '../db_util.dart';

class EditPasswordPage extends StatefulWidget {
  EditPasswordPage({Key? key}) : super(key: key);

  @override
  State<EditPasswordPage> createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> {
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerPass = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();

  bool validFieldTitle = true;
  bool validFieldPass = true;

  @override
  Widget build(BuildContext context) {
    Pass pass = ModalRoute.of(context)!.settings.arguments as Pass;
    if (pass != null) {
      controllerTitle.text = pass.title;
      controllerPass.text = pass.pass;
      controllerDescription.text = pass.description;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(pass == null ? 'Cadastrar Senha' : 'Editar Senha'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 350,
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).viewInsets.bottom == 0.0
                    ? 140.0
                    : 14.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      controller: controllerTitle,
                      onChanged: (text) {
                        setState(() {
                          if (text.isNotEmpty) {
                            validFieldTitle = true;
                          }
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Título',
                        hintStyle: TextStyle(
                          fontSize: 20.0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controllerPass,
                      onChanged: (text) {
                        setState(() {
                          if (text.isNotEmpty) {
                            validFieldPass = true;
                          }
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Senha',
                        hintStyle: TextStyle(
                          fontSize: 20.0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      maxLines: 5,
                      controller: controllerDescription,
                      decoration: const InputDecoration(
                        hintText: 'Descrição',
                        hintStyle: TextStyle(
                          fontSize: 20.0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
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
                    validFieldTitle = controllerTitle.text != '';
                    validFieldPass = controllerPass.text != '';

                    if (validFieldTitle && validFieldPass) {
                      if (pass == null) {
                        DbUtil.insert('pass', {
                          'title': controllerTitle.text,
                          'pass': controllerPass.text,
                          'description': controllerDescription.text
                        });
                      } else {
                        DbUtil.insert('pass', {
                          'id': pass.id,
                          'title': controllerTitle.text,
                          'pass': controllerPass.text,
                          'description': controllerDescription.text
                        });
                      }
                      Navigator.of(context).pushReplacementNamed('/home');
                    }
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
