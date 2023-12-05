import 'package:flutter/material.dart';

showSelectImageDialog (BuildContext context, Function() pickImage, Function() tatkePhoto) {

  return showDialog(
    context: context, builder: (BuildContext context) => AlertDialog(
      title: const Text('Selecciona una opción'),
      actions: [
        ElevatedButton(
          onPressed: () { 
            Navigator.pop(context);
            pickImage(); 
          },
          child: const Text (
            'Galería',
            style: TextStyle(
              color: Colors.black
            ),
          )
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            tatkePhoto(); 
          },
          child: const Text (
            'Cámara',
            style: TextStyle(
              color: Colors.black
            ),
          )
        ),
      ],
    )
  );

}