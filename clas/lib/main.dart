import 'package:flutter/material.dart';

void main() {
  runApp(TravelGuideApp());
}

class TravelGuideApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Guide',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScaffold(),
    );
  }
}

class MainScaffold extends StatefulWidget {
  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    ListScreen(),
    AboutScreen(),
  ];

  final List<String> _titles = ['Travel Guide', 'Destinations', 'About'];

  void _onSelectIndex(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.of(context).pop(); // close drawer if open
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.indigo,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Travel Guide',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () => _onSelectIndex(0),
              ),
              ListTile(
                leading: Icon(Icons.place),
                title: Text('List'),
                onTap: () => _onSelectIndex(1),
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About'),
                onTap: () => _onSelectIndex(2),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.all(12),
                child: Text('Semester Project • Riphah',
                    style: TextStyle(color: Colors.grey[700])),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(child: _screens[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_on), label: 'About'),
        ],
      ),
    );
  }
}

/* ---------------- HOME SCREEN ---------------- */
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _destinationController = TextEditingController();

  void _showSimpleSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // tries to load asset; fallback to network image if not found
  Widget _buildHeaderImage() {
    return Container(
      height: 220,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          'assets/images/home_banner.jpg',
          fit: BoxFit.cover,
          errorBuilder: (ctx, err, st) {
            // fallback network image
            return Image.network(
              'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=1200&q=60',
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderImage(),
          SizedBox(height: 14),

          // Welcome container with background
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.indigo.shade100),
            ),
            padding: EdgeInsets.all(12),
            child: Text(
              'Welcome! Plan your next trip and discover amazing places around the world. Enter a destination below to get started.',
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 12),

          // RichText slogan
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: 'Explore ',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400)),
                TextSpan(
                    text: 'the World ',
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold)),
                TextSpan(
                    text: 'with Us',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          SizedBox(height: 12),

          // TextField
          TextField(
            controller: _destinationController,
            decoration: InputDecoration(
              labelText: 'Enter destination name',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
          ),
          SizedBox(height: 10),

          // Buttons: Elevated + TextButton
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  final text = _destinationController.text.trim();
                  if (text.isEmpty) {
                    _showSimpleSnackbar('Please enter a destination name first.');
                  } else {
                    _showSimpleSnackbar('Searching for "$text" ... (demo)');
                  }
                },
                child: Text('Search'),
              ),
              SizedBox(width: 12),
              TextButton(
                onPressed: () {
                  _destinationController.clear();
                  _showSimpleSnackbar('Input cleared.');
                },
                child: Text('Clear'),
              )
            ],
          ),

          SizedBox(height: 20),

          // Quick features or cards
          Text('Popular categories', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: [
              Chip(label: Text('Beaches')),
              Chip(label: Text('Mountains')),
              Chip(label: Text('Cities')),
              Chip(label: Text('Historical')),
              Chip(label: Text('Nature')),
            ],
          ),

          SizedBox(height: 30),

          // Small footer / CTA
          Row(
            children: [
              Icon(Icons.travel_explore, size: 28, color: Colors.indigo),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Build travel memories. Use this app as your quick guide!',
                  style: TextStyle(fontSize: 14),
                ),
              )
            ],
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}

/* ---------------- LIST SCREEN ---------------- */
class ListScreen extends StatelessWidget {
  final List<Map<String, String>> destinations = [
    {'name': 'Paris, France', 'desc': 'City of lights, Eiffel Tower, cafes.'},
    {'name': 'Kyoto, Japan', 'desc': 'Temples, shrines, and cherry blossoms.'},
    {'name': 'New York, USA', 'desc': 'Skyscrapers, Broadway and Central Park.'},
    {'name': 'Rome, Italy', 'desc': 'Historical ruins and amazing cuisine.'},
    {'name': 'Cairo, Egypt', 'desc': 'Pyramids and ancient history.'},
    {'name': 'Sydney, Australia', 'desc': 'Harbour, opera house and beaches.'},
    {'name': 'Cape Town, South Africa', 'desc': 'Table Mountain & coastal beauty.'},
    {'name': 'Istanbul, Turkey', 'desc': 'Mosques, bazaars, and flavors.'},
    {'name': 'Reykjavik, Iceland', 'desc': 'Northern lights & geothermal wonders.'},
    {'name': 'Machu Picchu, Peru', 'desc': 'Ancient Incan citadel in the clouds.'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(12),
      itemCount: destinations.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) {
        final dest = destinations[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.indigo.shade100,
            child: Text('${index + 1}'),
          ),
          title: Text(dest['name']!),
          subtitle: Text(dest['desc']!),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            // show brief details bottom sheet
            showModalBottomSheet(
              context: context,
              builder: (ctx) {
                return Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(dest['name']!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text(dest['desc']!),
                      SizedBox(height: 12),
                      ElevatedButton(
                        child: Text('Add to Itinerary (demo)'),
                        onPressed: () {
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${dest['name']} added to itinerary (demo).')));
                        },
                      )
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

/* ---------------- ABOUT SCREEN (Grid of 6 attractions) ---------------- */
class AboutScreen extends StatelessWidget {
  final List<Map<String, String>> attractions = [
    {
      'image': 'assets/images/attraction1.jpg',
      'title': 'Eiffel Tower'
    },
    {
      'image': 'assets/images/attraction2.jpg',
      'title': 'Great Wall'
    },
    {
      'image': 'assets/images/attraction3.jpg',
      'title': 'Statue of Liberty'
    },
    {
      'image': 'assets/images/attraction4.jpg',
      'title': 'Taj Mahal'
    },
    {
      'image': 'assets/images/attraction5.jpg',
      'title': 'Sydney Opera House'
    },
    {
      'image': 'assets/images/attraction6.jpg',
      'title': 'Machu Picchu'
    },
  ];

  Widget _buildImage(String assetPath, String fallbackUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        assetPath,
        fit: BoxFit.cover,
        errorBuilder: (ctx, err, st) {
          // fallback to image.unsplash
          return Image.network(fallbackUrl, fit: BoxFit.cover);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: GridView.builder(
        itemCount: attractions.length,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 3/4),
        itemBuilder: (context, index) {
          final a = attractions[index];
          final fallback = 'https://images.unsplash.com/photo-1508264165352-c7d0b9f6b6d5?auto=format&fit=crop&w=800&q=60';
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: _buildImage(a['image']!, fallback),
                ),
              ),
              SizedBox(height: 6),
              Text(a['title']!, style: TextStyle(fontWeight: FontWeight.w600)),
              SizedBox(height: 2),
              Text('Famous landmark', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
            ],
          );
        },
      ),
    );
  }
}
