import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:file_picker/file_picker.dart';

class ManageMoviesPage extends StatefulWidget {
  const ManageMoviesPage({super.key});

  @override
  _ManageMoviesPageState createState() => _ManageMoviesPageState();
}

class _ManageMoviesPageState extends State<ManageMoviesPage> {
  final supabase = Supabase.instance.client;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final genreController = TextEditingController();
  final castController = TextEditingController();
  final trailerLinkController = TextEditingController();
  final directorController = TextEditingController();
  final posterUrlController = TextEditingController();  // For manual URL entry
  
  List<dynamic> movies = [];
  String currentCategory = 'Now Showing';
  bool _isAddMoviePanelVisible = false;
  String? selectedStatus;
  String? selectedImageName;
  Uint8List? selectedImageBytes;
  bool useUrlForPoster = false;  // Toggle between upload and URL input

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    genreController.dispose();
    castController.dispose();
    trailerLinkController.dispose();
    directorController.dispose();
    posterUrlController.dispose();
    super.dispose();
  }

  void _fetchMovies() async {
    final response = await supabase
        .from('movies')
        .select()
        .eq('status', currentCategory);

    setState(() {
      movies = response ?? [];
    });
  }

  Future<void> _addMovie(
    String title,
    String description,
    String genre,
    List<String> cast,
    String trailerLink,
    String director,
    String posterUrl,
  ) async {
    try {
      final response = await supabase.from('movies').insert({
        'title': title,
        'description': description,
        'genre': genre,
        'cast': cast,
        'trailer_link': trailerLink,
        'poster_url': posterUrl,
        'director': director,
        'status': selectedStatus,
      }).select();

      if (response.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Movie added successfully')),
        );
        _fetchMovies();
        setState(() {
          _isAddMoviePanelVisible = false;
        });
        // Clear input fields
        titleController.clear();
        descriptionController.clear();
        genreController.clear();
        castController.clear();
        trailerLinkController.clear();
        directorController.clear();
        posterUrlController.clear();
        selectedStatus = null;
        selectedImageBytes = null;
        selectedImageName = null;
        useUrlForPoster = false;
      } else {
        throw Exception('Failed to add movie.');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Movie added successfully')),
      );
    }
  }

  Future<String> _uploadImageToSupabase(Uint8List imageBytes, String status, String fileName) async {
    try {
      String folderName = '';
      switch (status) {
        case 'Now Showing':
          folderName = 'Now Showing';
          break;
        case 'Advance Selling':
          folderName = 'Advance Selling';
          break;
        case 'Coming Soon':
          folderName = 'Coming Soon';
          break;
      }

      final response = await supabase.storage
          .from('posters')
          .uploadBinary('$folderName/$fileName', imageBytes);

      if (response.isEmpty) {
        final String publicUrl = supabase.storage
            .from('posters')
            .getPublicUrl('$folderName/$fileName');
        return publicUrl;
      } else {
        throw Exception('Image upload failed');
      }
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        selectedImageBytes = result.files.first.bytes;
        selectedImageName = result.files.first.name;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Poster selected: $selectedImageName')),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No poster selected')),
      );
    }
  }

  void _deleteMovie(String id) async {
    try {
      final response = await supabase.from('movies').delete().eq('id', id).select();

      if (response.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Movie deleted successfully')),
        );
        _fetchMovies();
      } else {
        throw Exception('Failed to delete movie.');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $error')),
      );
    }
  }

  void _setCategory(String category) {
    setState(() {
      currentCategory = category;
    });
    _fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF07130E),
        title: Text(
          'Manage Movies',
          style: GoogleFonts.lexend(color: Color(0xFFE2F1EB)),
        ),
      ),
      backgroundColor: Color(0xFF07130E),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Movies List - $currentCategory',
              style: GoogleFonts.lexend(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE2F1EB),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _setCategory('Now Showing'),
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFE2F1EB)),
                  child: Text('Now Showing', style: TextStyle(color: Color(0xFF07130E))),
                ),
                ElevatedButton(
                  onPressed: () => _setCategory('Advance Selling'),
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFE2F1EB)),
                  child: Text('Advance Selling', style: TextStyle(color: Color(0xFF07130E))),
                ),
                ElevatedButton(
                  onPressed: () => _setCategory('Coming Soon'),
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFE2F1EB)),
                  child: Text('Coming Soon', style: TextStyle(color: Color(0xFF07130E))),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: Center(
                child: ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return Card(
                      color: Color(0xFF07130E),
                      elevation: 0,
                      margin: const EdgeInsets.symmetric(vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xFFE2F1EB).withOpacity(0.5), width: 2),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: ListTile(
                        title: Text(movie['title'], style: TextStyle(color: Color(0xFFE2F1EB))),
                        subtitle: Text(movie['description'], maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: Color(0xFFE2F1EB))),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteMovie(movie['id']),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            if (_isAddMoviePanelVisible)
              Column(
                children: [
                  TextField(controller: titleController, style: TextStyle(color: Color(0xFF8CDDBB)), decoration: InputDecoration(labelText: 'Title', labelStyle: TextStyle(color: Color(0xFFE2F1EB)))),
                  TextField(controller: descriptionController, style: TextStyle(color: Color(0xFF8CDDBB)), decoration: InputDecoration(labelText: 'Description', labelStyle: TextStyle(color: Color(0xFFE2F1EB)))),
                  TextField(controller: genreController, style: TextStyle(color: Color(0xFF8CDDBB)), decoration: InputDecoration(labelText: 'Genre', labelStyle: TextStyle(color: Color(0xFFE2F1EB)))),
                  TextField(controller: castController, style: TextStyle(color: Color(0xFF8CDDBB)), decoration: InputDecoration(labelText: 'Cast', labelStyle: TextStyle(color: Color(0xFFE2F1EB)))),
                  TextField(controller: trailerLinkController, style: TextStyle(color: Color(0xFF8CDDBB)), decoration: InputDecoration(labelText: 'Trailer Link', labelStyle: TextStyle(color: Color(0xFFE2F1EB)))),
                  TextField(controller: directorController, style: TextStyle(color: Color(0xFF8CDDBB)), decoration: InputDecoration(labelText: 'Director', labelStyle: TextStyle(color: Color(0xFFE2F1EB)))),
                  DropdownButtonFormField<String>(
                    value: selectedStatus,
                    onChanged: (value) => setState(() => selectedStatus = value),
                    items: ['Now Showing', 'Advance Selling', 'Coming Soon'].map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category, style: TextStyle(color: Color(0xFF8CDDBB))),
                      );
                    }).toList(),
                    dropdownColor: Color(0xFF07130E),
                    decoration: InputDecoration(labelText: 'Status', labelStyle: TextStyle(color: Color(0xFFE2F1EB))),
                  ),
                  SwitchListTile(
                    title: Text("Use URL for Poster", style: TextStyle(color: Color(0xFFE2F1EB))),
                    value: useUrlForPoster,
                    onChanged: (value) => setState(() => useUrlForPoster = value),
                  ),
                  useUrlForPoster
                      ? TextField(controller: posterUrlController, style: TextStyle(color: Color(0xFF8CDDBB)), decoration: InputDecoration(labelText: 'Poster URL', labelStyle: TextStyle(color: Color(0xFFE2F1EB))))
                      : ElevatedButton(onPressed: _pickImage, child: Text('Upload Poster')),
                  if (!useUrlForPoster && selectedImageName != null)
                    Text('Selected Poster: $selectedImageName', style: TextStyle(color: Color(0xFFE2F1EB))),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      final title = titleController.text.trim();
                      final description = descriptionController.text.trim();
                      final genre = genreController.text.trim();
                      final cast = castController.text.trim().split(',').map((e) => e.trim()).toList();
                      final trailerLink = trailerLinkController.text.trim();
                      final director = directorController.text.trim();
                      final posterUrl = useUrlForPoster ? posterUrlController.text.trim() : '';

                      if (title.isNotEmpty && description.isNotEmpty && genre.isNotEmpty && trailerLink.isNotEmpty && director.isNotEmpty && selectedStatus != null && ((useUrlForPoster && posterUrl.isNotEmpty) || (!useUrlForPoster && selectedImageBytes != null))) {
                        if (!useUrlForPoster && selectedImageBytes != null) {
                          final uploadedUrl = await _uploadImageToSupabase(selectedImageBytes!, selectedStatus!, selectedImageName!);
                          _addMovie(title, description, genre, cast, trailerLink, director, uploadedUrl);
                        } else {
                          _addMovie(title, description, genre, cast, trailerLink, director, posterUrl);
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill in all fields')));
                      }
                    },
                    child: Text('Add Movie'),
                  ),
                ],
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _isAddMoviePanelVisible = !_isAddMoviePanelVisible),
        child: Icon(_isAddMoviePanelVisible ? Icons.close : Icons.add),
      ),
    );
  }
}
