// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, use_key_in_widget_constructors

import 'dart:io';

import 'package:cinephileproject/models/movies.dart';
import 'package:cinephileproject/screens/homeScreen.dart';
import 'package:cinephileproject/widgets/addMovie.dart';
import 'package:cinephileproject/widgets/mainRefactoring.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class addMovieScreen extends StatefulWidget {
  @override
  State<addMovieScreen> createState() => _addMovieScreenState();
}

class _addMovieScreenState extends State<addMovieScreen> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final yearController = TextEditingController();
  final languageController = TextEditingController();
  final timeController = TextEditingController();
  final directorController = TextEditingController();
  final ratingcontroller = TextEditingController();
  final genreController = TextEditingController();
  final reviewcontroller = TextEditingController();
  int? selectedYear;
  XFile? _selectedImage;

  int year = 0;

  late Box moviesBox;

  @override
  void initState() {
    super.initState();
    moviesBox = Hive.box('movies');
  }

  Future<XFile?> _pickImageFromCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return XFile(pickedImage.path);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final List<int> years = [];
    for (int i = 1950; i <= 2023; i++) {
      years.add(i);
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: maintitle(),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addMovieTitile('Thumbnail'),
                  Container(
                      height: 100,
                      width: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/add-image (1).png'),
                        ),
                        border: Border.all(width: 2, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          XFile? pickimage = await _pickImageFromCamera();
                          setState(() {
                            _selectedImage = pickimage;
                          });
                        },
                        child: _selectedImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(_selectedImage!.path),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : null,
                      )),
                  addMovieTitile('Movie Title'),
                  addMovieTextField(
                    'Enter title',
                    titleController,
                    'Title is needed',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addMovieTitile('Year'),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Theme(
                              data: ThemeData(
                                  inputDecorationTheme: InputDecorationTheme(
                                      border: InputBorder.none)),
                              child: DropdownButton<int>(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                dropdownColor: Colors.white,
                                value: selectedYear,
                                style: TextStyle(color: Colors.black),
                                items: years
                                    .map((year) => DropdownMenuItem(
                                        value: year,
                                        child: Text(year.toString())))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    year = value!;
                                    selectedYear = value;
                                  });
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addMovieTitile('Language'),
                          addMovieTextField(
                            'Enter language',
                            languageController,
                            'language is needed',
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addMovieTitile('Runtime'),
                          addMovieTextField(
                            'Enter runtime',
                            timeController,
                            'runtime is needed',
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addMovieTitile('Director'),
                          addMovieTextField(
                            'Enter director',
                            directorController,
                            'director is needed',
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addMovieTitile('Rating'),
                          addMovieTextField(
                            'Enter Rating',
                            ratingcontroller,
                            'rating is needed',
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addMovieTitile('Genre'),
                          addMovieTextField(
                            'Enter genre',
                            genreController,
                            'genre is needed',
                          )
                        ],
                      ),
                    ],
                  ),
                  addMovieTitile('Review'),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    controller: reviewcontroller,
                    maxLines: null,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field is needed';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Write review...',
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(30)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(30))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                fixedSize: Size(200, 40),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            onPressed: () {
                              addmovie();
                            },
                            child: Text(
                              'Submit',
                              style: GoogleFonts.ubuntu(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.black)),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  void addmovie() {
    final isValid = _formKey.currentState?.validate();
    if (isValid!) {
      if (_selectedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "You must select an image",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
        return;
      } else {
        moviesBox.add(movies(
            title: titleController.text,
            releaseyear: year,
            movielanguage: languageController.text,
            time: int.parse(timeController.text),
            moviedirector: directorController.text,
            movierating: double.parse(ratingcontroller.text),
            moviegenre: genreController.text,
            review: reviewcontroller.text,
            imageUrl: _selectedImage!.path));

        titleController.clear();
        yearController.clear();
        languageController.clear();
        timeController.clear();
        directorController.clear();
        ratingcontroller.clear();
        genreController.clear();
        reviewcontroller.clear();
        setState(() {
          year = 0;
          _selectedImage = null;
          selectedYear = null;
        });

        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }));
      }
    }
  }
}
