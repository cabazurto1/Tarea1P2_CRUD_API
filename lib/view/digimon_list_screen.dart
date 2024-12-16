import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart'; // Importa Google Fonts
import '../controller/digimon_controller.dart';
import '../model/digimon_model.dart';
import 'digimon_detail_screen.dart';
import 'add_digimon_screen.dart';
import 'edit_digimon_screen.dart';

class DigimonListScreen extends StatefulWidget {
  @override
  _DigimonListScreenState createState() => _DigimonListScreenState();
}

class _DigimonListScreenState extends State<DigimonListScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Digimon> _filteredDigimons = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DigimonController>(context, listen: false).loadDigimons();
    });
    _searchController.addListener(_filterDigimons);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterDigimons() {
    final controller = Provider.of<DigimonController>(context, listen: false);
    setState(() {
      _filteredDigimons = controller.digimons
          .where((digimon) =>
          digimon.name.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<DigimonController>(context);
    final digimons = _searchController.text.isEmpty ? controller.digimons : _filteredDigimons;

    return Scaffold(
      body: Stack(
        children: [
          // Fondo degradado
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2c1001), Color(0xFFe8591c), Color(0xFF2c1001)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Contenido principal
          Column(
            children: [
              AppBar(
                title: Text(
                  'Lista de Digimons',
                  style: GoogleFonts.pixelifySans(color: Colors.white),
                ),
                backgroundColor: Color(0xFF151101),
                iconTheme: IconThemeData(color: Color(0xFF4A403D)),
              ),
              // Barra de búsqueda
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Buscar Digimon...',
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              // Imagen centrada
              SizedBox(height: 50),
              Expanded(
                child: digimons.isEmpty
                    ? Center(
                  child: CircularProgressIndicator(color: Color(0xFFEA804C)),
                )
                    : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: digimons.length,
                    itemBuilder: (context, index) {
                      final digimon = digimons[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DigimonDetailScreen(index: index),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 3),
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFeaa353),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: digimon.img.isNotEmpty
                                    ? ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10),
                                  ),
                                  child: Image.network(
                                    digimon.img,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(
                                        Icons.error,
                                        color: Color(0xFFEA804C),
                                        size: 50,
                                      );
                                    },
                                  ),
                                )
                                    : Icon(Icons.image, color: Color(0xFFA69A90)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      digimon.name,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.pixelifySans(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Level: ${digimon.level}',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.pixelifySans(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit, color: Color(0xFF031c30)),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => EditDigimonScreen(index: index),
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete, color: Color(0xFFb5485f)),
                                      onPressed: () {
                                        controller.deleteDigimon(index);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          // Botón centrado debajo de la AppBar
          Positioned(
            top: 168, // Ajusta la posición para que esté debajo de la AppBar
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFEA804C),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AddDigimonScreen()),
                  );
                },
                child: Text(
                  'Agregar Nuevo Digimon',
                  style: GoogleFonts.pixelifySans(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
