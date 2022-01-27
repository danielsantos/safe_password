import 'package:flutter/material.dart';
import '../db_util.dart';

class CreatePasswordPage extends StatefulWidget {
  CreatePasswordPage({Key? key}) : super(key: key);

  @override
  State<CreatePasswordPage> createState() => _CreatePasswordPageState();
}

class _CreatePasswordPageState extends State<CreatePasswordPage> {
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerPass = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();

  bool validFieldTitle = true;
  bool validFieldPass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gravar Nova Senha'),
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
                      onChanged: (text) {
                        setState(() {
                          if (text.isNotEmpty) {
                            validFieldTitle = true;
                          }
                        });
                      },
                      controller: controllerTitle,
                      decoration: InputDecoration(
                        hintText: 'Título *',
                        hintStyle: TextStyle(
                          fontSize: 20.0,
                          color: validFieldTitle ? Colors.blueGrey : Colors.red,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: validFieldTitle ? Colors.grey : Colors.red,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (text) {
                        setState(() {
                          if (text.isNotEmpty) {
                            validFieldPass = true;
                          }
                        });
                      },
                      controller: controllerPass,
                      decoration: InputDecoration(
                        hintText: 'Senha *',
                        hintStyle: TextStyle(
                          fontSize: 20.0,
                          color: validFieldPass ? Colors.blueGrey : Colors.red,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: validFieldPass ? Colors.grey : Colors.red,
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
                    setState(() {
                      validFieldTitle = controllerTitle.text != '';
                      validFieldPass = controllerPass.text != '';

                      if (validFieldTitle && validFieldPass) {
                        DbUtil.insert('pass', {
                          'title': controllerTitle.text,
                          'pass': controllerPass.text,
                          'description': controllerDescription.text
                        });
                        Navigator.of(context).pushReplacementNamed('/home');
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
