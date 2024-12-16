// view/add_digimon_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/digimon_controller.dart';
import '../model/digimon_model.dart';

class AddDigimonScreen extends StatefulWidget {
  @override
  _AddDigimonScreenState createState() => _AddDigimonScreenState();
}

class _AddDigimonScreenState extends State<AddDigimonScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _levelController = TextEditingController();
  final _imgController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _levelController.dispose();
    _imgController.dispose();
    super.dispose();
  }

  void _saveDigimon() {
    if (_formKey.currentState!.validate()) {
      final digimon = Digimon(
        name: _nameController.text.trim(),
        img: _imgController.text.trim(),
        level: _levelController.text.trim(),
      );

      Provider.of<DigimonController>(context, listen: false).addDigimon(digimon);
      Navigator.pop(context); // Regresar a la lista
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Digimon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key:_formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingresa un nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _levelController,
                decoration: InputDecoration(labelText: 'Nivel'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingresa un nivel';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imgController,
                decoration: InputDecoration(labelText: 'URL de la imagen'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveDigimon,
                child: Text('Guardar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
