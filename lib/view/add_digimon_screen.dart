import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/digimon_controller.dart';
import '../model/digimon_model.dart';
import 'package:google_fonts/google_fonts.dart';

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
      // Fondo degradado
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2c1001), Color(0xFFe8591c)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // AppBar personalizada
            AppBar(
              title: Text(
                'Agregar Digimon',
                style: GoogleFonts.pixelifySans(
                  textStyle: TextStyle(color: Colors.white),
                ),
              ),
              backgroundColor: Color(0xFF151101),
              iconTheme: IconThemeData(color: Color(0xFF4A403D)),
            ),
            // Formulario para agregar Digimon
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Nombre del Digimon
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Color(0xFF4A403D), width: 4),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(8),
                          child: TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Nombre',
                              labelStyle: GoogleFonts.pixelifySans(
                                textStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingresa un nombre';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        // Nivel del Digimon
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Color(0xFF4A403D), width: 4),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(8),
                          child: TextFormField(
                            controller: _levelController,
                            decoration: InputDecoration(
                              labelText: 'Nivel',
                              labelStyle: GoogleFonts.pixelifySans(
                                textStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingresa un nivel';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        // URL de la imagen del Digimon
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Color(0xFF4A403D), width: 4),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(8),
                          child: TextFormField(
                            controller: _imgController,
                            decoration: InputDecoration(
                              labelText: 'URL de la imagen',
                              labelStyle: GoogleFonts.pixelifySans(
                                textStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        // Botón para guardar cambios
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFEA804C),
                            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: _saveDigimon,
                          child: Text(
                            'Guardar',
                            style: GoogleFonts.pixelifySans(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFACF7D),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
