import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'models/app_state.dart';
import 'store/store.dart';
import 'actions/item_actions.dart';

void main() {
  final Store<AppState> store = createStore();
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  const MyApp({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Penggunaan Redux dalam sebuah list',
        home: ItemListPage(),
      ),
    );
  }
}

class ItemListPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Penggunaan Redux dalam sebuah list'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: 'Masukkan nama produk',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                    hintText: 'Masukkan harga ',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_nameController.text.isNotEmpty && _priceController.text.isNotEmpty) {
                StoreProvider.of<AppState>(context).dispatch(
                  AddItemAction(_nameController.text, double.parse(_priceController.text)),
                );
                _nameController.clear();
                _priceController.clear();
              }
            },
            child: const Text('Tambahkan'),
          ),
          Expanded(
            child: StoreConnector<AppState, List<Item>>(
              converter: (store) => store.state.items,
              builder: (context, items) {
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(items[index].name),
                      subtitle: Text('Harga: \Rp${items[index].price.toStringAsFixed(2)}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  TextEditingController editNameController =
                                      TextEditingController(text: items[index].name);
                                  TextEditingController editPriceController =
                                      TextEditingController(text: items[index].price.toString());
                                  return AlertDialog(
                                    title: const Text('Edit'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          controller: editNameController,
                                          decoration: const InputDecoration(
                                            hintText: 'Edit nama produk',
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        TextField(
                                          controller: editPriceController,
                                          decoration: const InputDecoration(
                                            hintText: 'Edit harga',
                                          ),
                                          keyboardType: TextInputType.number,
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          StoreProvider.of<AppState>(context).dispatch(
                                            UpdateItemAction(
                                              index,
                                              editNameController.text,
                                              double.parse(editPriceController.text),
                                            ),
                                          );
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Update'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              StoreProvider.of<AppState>(context).dispatch(DeleteItemAction(index));
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
