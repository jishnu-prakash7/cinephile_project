// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, unnecessary_null_comparison

import 'dart:io';

import 'package:cinephileproject/models/movies.dart';
import 'package:cinephileproject/screens/adminModule.dart';
import 'package:cinephileproject/widgets/addAndEditMovie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class EditAndDeleteScreen extends StatefulWidget {
  final movies movie;
  final int index;
  const EditAndDeleteScreen(
      {super.key, required this.movie, required this.index});

  @override
  State<EditAndDeleteScreen> createState() => _EditAndDeleteScreenState();
}

class _EditAndDeleteScreenState extends State<EditAndDeleteScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController languageController;
  late TextEditingController timeController;
  late TextEditingController directorController;
  late TextEditingController ratingcontroller;
  late TextEditingController genreController;
  late TextEditingController reviewcontroller;
  int? selectedYear;
  XFile? _selectedImage;

  int year = 0;

  late Box moviesBox;

  @override
  void initState() {
    moviesBox = Hive.box('movies');
    titleController = TextEditingController(text: widget.movie.title);
    languageController =
        TextEditingController(text: widget.movie.movielanguage);
    timeController = TextEditingController(text: widget.movie.time.toString());
    directorController =
        TextEditingController(text: widget.movie.moviedirector);
    ratingcontroller =
        TextEditingController(text: widget.movie.movierating.toString());
    genreController = TextEditingController(text: widget.movie.moviegenre);
    reviewcontroller = TextEditingController(text: widget.movie.review);
    _selectedImage = XFile(widget.movie.imageUrl);
    year = widget.movie.releaseyear;
    super.initState();
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
        leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return AdminModule();
              }));
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          'Edit Movie',
          style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                  color: Colors.green)),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addAndEditMovieTitile('Thumbnail'),
                  Container(
                      height: 230,
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                        border: Border.all(width: .7, color: Colors.grey),
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
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(widget.movie.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                      )),
                  addAndEditMovieTitile('Movie Title'),
                  addAndEditMovieTextField(
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
                          addAndEditMovieTitile('Year'),
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
                                value: selectedYear ?? widget.movie.releaseyear,
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
                          addAndEditMovieTitile('Language'),
                          addAndEditMovieTextField(
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
                          addAndEditMovieTitile('Runtime'),
                          addAndEditMovieTextField(
                            'Enter runtime',
                            timeController,
                            'runtime is needed',
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addAndEditMovieTitile('Director'),
                          addAndEditMovieTextField(
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
                          addAndEditMovieTitile('Rating'),
                          addAndEditMovieTextField(
                            'Enter Rating',
                            ratingcontroller,
                            'rating is needed',
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addAndEditMovieTitile('Genre'),
                          addAndEditMovieTextField(
                            'eg:Action,Comedy',
                            genreController,
                            'genre is needed',
                          )
                        ],
                      ),
                    ],
                  ),
                  addAndEditMovieTitile('Review'),
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
                                backgroundColor: Colors.green,
                                fixedSize: Size(150, 40),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            onPressed: () {
                              updateMovie();
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

  void updateMovie() {
    final isValid = _formKey.currentState?.validate();
    if (isValid!) {
      if (_selectedImage == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('you must select an Image')));
      } else if (year == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('you must select an Year')));
        return;
      } else {
        final value = movies(
            title: titleController.text,
            releaseyear: year,
            movielanguage: languageController.text,
            time: int.parse(timeController.text),
            moviedirector: directorController.text,
            movierating: ratingcontroller.text,
            moviegenre: genreController.text,
            review: reviewcontroller.text,
            imageUrl: _selectedImage!.path);

        moviesBox.putAt(widget.index, value);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Movie updated successfully')),
        );
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return AdminModule();
        }));
      }
    }
  }
}
