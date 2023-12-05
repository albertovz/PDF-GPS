import 'package:flutter/material.dart';

showSelectImageDialogPost(
    BuildContext context,
    Function() pickImage,
    Function() takePhoto,
    Function() pickVideo,
    Function() pickAudio,
    Function() pickPDF) {
  return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: const Text('Selecciona una opción'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    pickImage();
                  },
                  child: const Text(
                    'Galería',
                    style: TextStyle(color: Colors.black),
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    takePhoto();
                  },
                  child: const Text(
                    'Cámara',
                    style: TextStyle(color: Colors.black),
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    pickVideo();
                  },
                  child: const Text(
                    'Vídeo',
                    style: TextStyle(color: Colors.black),
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    pickAudio();
                  },
                  child: const Text(
                    'Audio',
                    style: TextStyle(color: Colors.black),
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    pickPDF();
                  },
                  child: const Text(
                    'PDF',
                    style: TextStyle(color: Colors.black),
                  )),
            ],
          ));
}
