# tips_app_from_scratch

A new Flutter project.




## ADD TIP APP FLUTTER

```dart
// home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tips_app_from_scratch/components/add_tip_dialog.dart';
import '../controller/item_provider.dart';

class AddTipScreen extends StatelessWidget {
  // Controlador para manejar la entrada de texto
  final TextEditingController _controller = TextEditingController();

  AddTipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenemos el proveedor de estado (ItemProvider) usando Provider
    final itemProvider = Provider.of<ItemProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Items'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input de texto
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Ingrese un texto',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // Botón para agregar el texto ingresado a la lista
            ElevatedButton(
              onPressed: () {
                // Llamamos al método addItem del proveedor para agregar el texto
                itemProvider.addItem(_controller.text);
                _controller.clear(); // Limpiamos el campo de texto después de agregar
              },
              child: const Text('Agregar'),
            ),
            const SizedBox(height: 20),
            // Muestra la lista de items
            Expanded(
              child: ListView.builder(
                itemCount: itemProvider.items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(itemProvider.items[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return const AddTipDialog();
            });
        },
        child: const Icon(
          color: Colors.white,
          Icons.add
        ),
      ),
    );
  }
}


//PROVIDER FILE


import 'package:flutter/material.dart';


// Modelo del proveedor para manejar la lista de items
class ItemProvider extends ChangeNotifier{
  
  // Lista donde se almacenaran los textos añadidos
  List<String> _items = [];
  
  // Getter para acceder a la lista de items
  List<String> get items => _items;
  
  // Método para agregar un item a la lista

  void addItem(String item) {
    if (item.isNotEmpty) {
      _items.add(item);
      notifyListeners(); // Notificar a los listeners.
    }
  }
}

```# tips_tracker
