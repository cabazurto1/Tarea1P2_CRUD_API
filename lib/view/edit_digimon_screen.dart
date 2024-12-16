// view/edit_digimon_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/digimon_controller.dart';
import '../model/digimon_model.dart';

class EditDigimonScreen extends StatefulWidget {
  final int index;
  EditDigimonScreen({required this.index});

  @override
  _EditDigimonScreenState createState() => _EditDigimonScreenState();
}

class _EditDigimonScreenState extends State<EditDigimonScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _levelController = TextEditingController();
  final _imgController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final controller = Provider.of<DigimonController>(context, listen: false);
    final digimon = controller.digimons[widget.index];
    _nameController.text = digimon.name;
    _levelController.text = digimon.level;
    _imgController.text = digimon.img;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _levelController.dispose();
    _imgController.dispose();
    super.dispose();
  }

  void _updateDigimon() {
    if (_formKey.currentState!.validate()) {
      final updatedDigimon = Digimon(
        name: _nameController.text.trim(),
        img: _imgController.text.trim(),
        level: _levelController.text.trim(),
      );
      Provider.of<DigimonController>(context, listen: false).updateDigimon(widget.index, updatedDigimon);
      Navigator.pop(context); // Regresar a los detalles o a la lista
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Digimon'),
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
                onPressed: _updateDigimon,
                child: Text('Guardar cambios'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
