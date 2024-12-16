import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/digimon_controller.dart';
import 'edit_digimon_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class DigimonDetailScreen extends StatelessWidget {
  final int index; // índice del digimon en la lista
  DigimonDetailScreen({required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<DigimonController>(context);
    final digimon = controller.digimons[index];

    return Scaffold(
      // Fondo con la imagen
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/fondo.jpg'), // Ruta de la imagen de fondo
            fit: BoxFit.cover, // Asegura que la imagen cubra toda la pantalla
          ),
        ),
        child: Column(
          children: [
            // AppBar personalizada
            AppBar(
              title: Text(
                digimon.name,
                style: GoogleFonts.pixelifySans(
                  textStyle: TextStyle(color: Colors.white),
                ),
              ),
              backgroundColor: Color(0xFF151101),
              iconTheme: IconThemeData(color: Color(0xFF4A403D)),
              actions: [
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.white),
                  onPressed: () {
                    controller.deleteDigimon(index);
                    Navigator.pop(context); // Regresar a la lista
                  },
                ),
              ],
            ),
            // Contenedor para simular la carta
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Imagen del Digimon
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Color(0xFF4A403D), width: 4),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(8),
                        child: digimon.img.isNotEmpty
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            digimon.img,
                            height: 250,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.error, color: Colors.red, size: 100);
                            },
                          ),
                        )
                            : Icon(Icons.image, size: 100, color: Colors.grey),
                      ),
                      SizedBox(height: 20),
                      // Detalles del Digimon dentro de la carta
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Color(0xFF4A403D), width: 4),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Nombre del Digimon
                            Text(
                              'Nombre: ${digimon.name}',
                              style: GoogleFonts.pixelifySans(
                                textStyle: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 10),
                            // Nivel del Digimon
                            Text(
                              'Nivel: ${digimon.level}',
                              style: GoogleFonts.pixelifySans(
                                textStyle: TextStyle(fontSize: 18, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 90),
                      // Botón para editar
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFEA804C),
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          // Navegar a la pantalla de edición
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => EditDigimonScreen(index: index)),
                          );
                        },
                        child: Text(
                          'Editar',
                          style: GoogleFonts.pixelifySans(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
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
