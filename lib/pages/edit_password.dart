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
    double width = MediaQuery.of(context).size.width;

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
                  if (!validFieldPass || !validFieldTitle)
                    const Text(
                      'Preencha os campos obrigatórios',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20.0,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      controller: controllerTitle,
                      onChanged: (text) {
                        if (text.isNotEmpty) {
                          validFieldTitle = true;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Título *',
                        labelStyle: TextStyle(
                          fontSize: 20.0,
                          color: validFieldTitle ? Colors.blueGrey : Colors.red,
                        ),
                        contentPadding: EdgeInsets.only(
                            left: width * 0.04,
                            top: width * 0.041,
                            bottom: width * 0.041,
                            right: width * 0.04),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.04),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.04),
                          borderSide: BorderSide(
                            color: validFieldTitle ? Colors.grey : Colors.red,
                            width: 2.0,
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
                        if (text.isNotEmpty) {
                          validFieldPass = true;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Senha *',
                        labelStyle: TextStyle(
                          fontSize: 20.0,
                          color: validFieldPass ? Colors.blueGrey : Colors.red,
                        ),
                        contentPadding: EdgeInsets.only(
                            left: width * 0.04,
                            top: width * 0.041,
                            bottom: width * 0.041,
                            right: width * 0.04),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.04),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.04),
                          borderSide: BorderSide(
                            color: validFieldPass ? Colors.grey : Colors.red,
                            width: 2.0,
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
                      decoration: InputDecoration(
                        labelText: 'Descrição',
                        labelStyle: TextStyle(
                          fontSize: 20.0,
                        ),
                        contentPadding: EdgeInsets.only(
                            left: width * 0.04,
                            top: width * 0.041,
                            bottom: width * 0.041,
                            right: width * 0.04),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.04),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.04),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2.0,
                          ),
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
                    setState(() {
                      if (pass != null) {
                        pass.title = controllerTitle.text;
                        pass.pass = controllerPass.text;
                        pass.description = controllerDescription.text;
                      }

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
                        Navigator.of(context).pop();
                      }
                    });
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
