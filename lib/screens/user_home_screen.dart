import 'package:flutter/material.dart';

// Definir la clase Carro con los campos que necesitas
class Carro {
  final String numero;
  final String nombre;
  final int winid;
  final String unidadNegocio;
  final String supervisor;
  final String placas;
  final String telefono;
  String estado; // Estado puede ser 'Entra' o 'Sale'

  Carro({
    required this.numero,
    required this.nombre,
    required this.winid,
    required this.unidadNegocio,
    required this.supervisor,
    required this.placas,
    required this.telefono,
    required this.estado,
  });
}

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  // Lista de carros registrados
  List<Carro> carros = [];

  // Controladores de texto para el formulario
  final _numeroController = TextEditingController();
  final _nombreController = TextEditingController();
  final _winidController = TextEditingController();
  final _unidadNegocioController = TextEditingController();
  final _supervisorController = TextEditingController();
  final _placasController = TextEditingController();
  final _telefonoController = TextEditingController();
  String _estado = 'Entra'; // Estado por defecto

  // Mostrar formulario para agregar un carro
void _mostrarFormulario() {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Agregar Automovil'),
        content: SingleChildScrollView(
          child: Container(
            width: 400, // Aquí puedes ajustar el ancho según lo necesites
            child: Column(
              children: [
                TextField(
                  controller: _numeroController,
                  decoration: const InputDecoration(labelText: 'Número (correlativo)'),
                ),
                TextField(
                  controller: _nombreController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                ),
                TextField(
                  controller: _winidController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'WINID'),
                ),
                TextField(
                  controller: _unidadNegocioController,
                  decoration: const InputDecoration(labelText: 'Unidad de Negocio'),
                ),
                TextField(
                  controller: _supervisorController,
                  decoration: const InputDecoration(labelText: 'Supervisor'),
                ),
                TextField(
                  controller: _placasController,
                  decoration: const InputDecoration(labelText: 'Placas de Vehículos'),
                ),
                TextField(
                  controller: _telefonoController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: 'Teléfono'),
                ),
                DropdownButton<String>(
                  value: _estado,
                  items: ['Entra', 'Sale'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _estado = newValue!;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                // Crear un nuevo carro y agregarlo a la lista
                carros.add(Carro(
                  numero: _numeroController.text,
                  nombre: _nombreController.text,
                  winid: int.parse(_winidController.text),
                  unidadNegocio: _unidadNegocioController.text,
                  supervisor: _supervisorController.text,
                  placas: _placasController.text,
                  telefono: _telefonoController.text,
                  estado: _estado,
                ));
                // Limpiar los controladores
                _numeroController.clear();
                _nombreController.clear();
                _winidController.clear();
                _unidadNegocioController.clear();
                _supervisorController.clear();
                _placasController.clear();
                _telefonoController.clear();
                _estado = 'Entra';
              });
              Navigator.pop(context);
            },
            child: const Text('Guardar'),
          ),
        ],
      );
    },
  );
}

  // Mostrar formulario para editar el estado
  void _editarEstado(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar Estado del Carro'),
          content: DropdownButton<String>(
            value: carros[index].estado,
            items: ['Entra', 'Sale'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                carros[index].estado = newValue!;
              });
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuario'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false, // Elimina la flecha de atrás
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'salir') {
                // Redirige al login cuando se seleccione "Salir"
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
            color: Colors.deepPurple,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(4),
            ),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'salir',
                  child: Row(
                    children: const [
                      Icon(Icons.exit_to_app, color: Colors.white),
                      SizedBox(width: 8),
                      Text('Salir', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            carros.isEmpty
                ? const Text('Aún no hay automovil registrados.')
                : Expanded(
                    child: SingleChildScrollView(
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Número')),
                          DataColumn(label: Text('Nombre')),
                          DataColumn(label: Text('Placas')),
                          DataColumn(label: Text('Estado')),
                          DataColumn(label: Text('Acciones')),
                        ],
                        rows: carros.map((carro) {
                          int index = carros.indexOf(carro);
                          return DataRow(cells: [
                            DataCell(Text(carro.numero)),
                            DataCell(Text(carro.nombre)),
                            DataCell(Text(carro.placas)),
                            DataCell(Text(carro.estado)),
                            DataCell(
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () => _editarEstado(index),
                              ),
                            ),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
            const SizedBox(height: 20),
            FloatingActionButton(
              onPressed: _mostrarFormulario,
              child: const Icon(
              Icons.add,
              color: Colors.white, 
            ),
              backgroundColor: Colors.deepPurple,
            ),
          ],
        ),
      ),
    );
  }
}
