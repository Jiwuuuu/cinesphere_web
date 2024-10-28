import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ManageMoviesPage extends StatefulWidget {
  const ManageMoviesPage({super.key});

  @override
  _ManageMoviesPageState createState() => _ManageMoviesPageState();
}

class _ManageMoviesPageState extends State<ManageMoviesPage> {
  final supabase = Supabase.instance.client;

  List<dynamic> movies = [];
  String currentCategory = 'Now Showing';
  bool _isAddMoviePanelVisible = false; // State variable to control visibility

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  void _fetchMovies() async {
    final response = await supabase
        .from('movies')
        .select()
        .eq('status', currentCategory); // Fetch only movies in the current category

    if (response.isNotEmpty) {
      setState(() {
        movies = response;
      });
    }
  }

  void _addMovie(
    String title,
    String description,
    String genre,
    List<String> cast,
    String trailerLink,
    String posterUrl,
    String director,
    String status,
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
        'status': status,
      });

      if (response.error == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Movie added successfully')),
        );
        _fetchMovies(); // Refresh movie list after insertion
        setState(() {
          _isAddMoviePanelVisible = false; // Hide the add movie panel after successful addition
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add movie: \${response.error?.message}')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred while adding the movie: \$error')),
      );
    }
  }

  void _deleteMovie(String id) async {
    try {
      final response = await supabase.from('movies').delete().eq('id', id);

      if (response.error == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Movie deleted successfully')),
        );
        _fetchMovies(); // Refresh the list after deletion
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete movie: \${response.error?.message}')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred while deleting the movie: \$error')),
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
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final genreController = TextEditingController();
    final castController = TextEditingController();
    final trailerLinkController = TextEditingController();
    final posterUrlController = TextEditingController();
    final directorController = TextEditingController();
    final statusController = TextEditingController();

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
                child: SizedBox(
                  width: MediaQuery.of(context).size.width > 600
                      ? MediaQuery.of(context).size.width * 0.5
                      : MediaQuery.of(context).size.width * 0.9, // Set width based on screen size for responsiveness
                  child: ListView.builder(
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return Card(
                        color: Color(0xFF07130E),
                        elevation: 0,
                        margin: const EdgeInsets.symmetric(vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Color(0xFFE2F1EB).withOpacity(0.5), width: 2), // Add blurred stroke
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Container(
                          height: 200,
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Container(
                                width: 150, // Adjust width of the poster image
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                    image: NetworkImage(movie['poster_url']),
                                    fit: BoxFit.cover, // Ensures the image covers the entire container
                                  ),
                                ),
                              ),
                              SizedBox(width: 16), // Add space between the image and text
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      movie['title'],
                                      style: TextStyle(
                                        fontSize: 24, // Adjust the font size for the title
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFE2F1EB),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      movie['description'],
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 18, // Adjust the font size for the description
                                        color: Color(0xFFE2F1EB),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  _deleteMovie(movie['id']);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            if (_isAddMoviePanelVisible) // Display the add movie panel based on visibility
              Column(
                children: [
                  TextField(
                    controller: titleController,
                    style: TextStyle(color: Color(0xFFE2F1EB)),
                    decoration: InputDecoration(
                      labelText: 'Movie Title',
                      labelStyle: TextStyle(color: Color(0xFFE2F1EB)),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: descriptionController,
                    style: TextStyle(color: Color(0xFFE2F1EB)),
                    decoration: InputDecoration(
                      labelText: 'Movie Description',
                      labelStyle: TextStyle(color: Color(0xFFE2F1EB)),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: genreController,
                    style: TextStyle(color: Color(0xFFE2F1EB)),
                    decoration: InputDecoration(
                      labelText: 'Genre',
                      labelStyle: TextStyle(color: Color(0xFFE2F1EB)),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: castController,
                    style: TextStyle(color: Color(0xFFE2F1EB)),
                    decoration: InputDecoration(
                      labelText: 'Cast (comma-separated)',
                      labelStyle: TextStyle(color: Color(0xFFE2F1EB)),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: trailerLinkController,
                    style: TextStyle(color: Color(0xFFE2F1EB)),
                    decoration: InputDecoration(
                      labelText: 'Trailer Link',
                      labelStyle: TextStyle(color: Color(0xFFE2F1EB)),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: posterUrlController,
                    style: TextStyle(color: Color(0xFFE2F1EB)),
                    decoration: InputDecoration(
                      labelText: 'Poster URL',
                      labelStyle: TextStyle(color: Color(0xFFE2F1EB)),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: directorController,
                    style: TextStyle(color: Color(0xFFE2F1EB)),
                    decoration: InputDecoration(
                      labelText: 'Director',
                      labelStyle: TextStyle(color: Color(0xFFE2F1EB)),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: statusController,
                    style: TextStyle(color: Color(0xFFE2F1EB)),
                    decoration: InputDecoration(
                      labelText: 'Status (e.g., Now Showing, Advance Selling, Coming Soon)',
                      labelStyle: TextStyle(color: Color(0xFFE2F1EB)),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final title = titleController.text.trim();
                      final description = descriptionController.text.trim();
                      final genre = genreController.text.trim();
                      final cast = castController.text.trim().split(',').map((e) => e.trim()).toList();
                      final trailerLink = trailerLinkController.text.trim();
                      final posterUrl = posterUrlController.text.trim();
                      final director = directorController.text.trim();
                      final status = statusController.text.trim();

                      if (title.isNotEmpty &&
                          description.isNotEmpty &&
                          genre.isNotEmpty &&
                          trailerLink.isNotEmpty &&
                          posterUrl.isNotEmpty &&
                          director.isNotEmpty &&
                          status.isNotEmpty) {
                        _addMovie(title, description, genre, cast, trailerLink, posterUrl, director, status);
                        titleController.clear();
                        descriptionController.clear();
                        genreController.clear();
                        castController.clear();
                        trailerLinkController.clear();
                        posterUrlController.clear();
                        directorController.clear();
                        statusController.clear();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please fill in all fields')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFE2F1EB)),
                    child: Text('Add Movie', style: TextStyle(color: Color(0xFF07130E))),
                  ),
                  SizedBox(height: 16),
                ],
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isAddMoviePanelVisible = !_isAddMoviePanelVisible; // Toggle panel visibility
          });
        },
        backgroundColor: Color(0xFF8CDDBB),
        child: Icon(
          _isAddMoviePanelVisible ? Icons.close : Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
