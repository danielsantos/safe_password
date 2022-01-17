import 'package:flutter/material.dart';
import 'package:safe_password/models/pass.dart';

import '../db_util.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controllerSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    _listFuture = updateAndGetList();
  }

  Future<List<Pass>> updateAndGetList({String title = ''}) async {
    if (title == '') {
      return await DbUtil.getData('pass');
    } else {
      return await DbUtil.getPassByTitle(title);
    }
  }

  void refreshList(String title) {
    setState(() {
      _listFuture = updateAndGetList(title: title);
    });
  }

  late Future<List<Pass>> _listFuture;

  showAlertDialog(int id, BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Cancelar"),
      onPressed: () {
        setState(() {
          Navigator.of(context).pop();
        });
      },
    );
    Widget confirmButton = TextButton(
      child: const Text("Confirmar"),
      onPressed: () {
        setState(() {
          DbUtil.delete(id);
          refreshList('');
          Navigator.of(context).pop();
        });
      },
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Atenção"),
      content: const Text("Tem certeza que deseja apagar?"),
      actions: [
        confirmButton,
        cancelButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Senha Segura'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (text) {
                  refreshList(text);
                },
                controller: controllerSearch,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "Pesquisar",
                  fillColor: Colors.white70,
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List>(
              future: _listFuture,
              //initialData: "Aguardando os dados...",
              builder: (context, snapshot) {
                if (snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            final Pass pass = await DbUtil.getPassById(
                                snapshot.data![index].id);

                            Navigator.of(context)
                                .pushNamed('/edit', arguments: pass);
                          },
                          child: Card(
                            color: Colors.grey[200],
                            child: ListTile(
                              title: Text(snapshot.data![index].title),
                              trailing: IconButton(
                                onPressed: () async {
                                  showAlertDialog(
                                    snapshot.data![index].id,
                                    context,
                                  );
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                      child: Text(
                    'Cadastre sua primeira senha!',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 25,
                    ),
                  ));
                }
              },
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
                  Navigator.of(context).pushNamed('/create');
                },
                child: const Text('ADICIONAR'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
