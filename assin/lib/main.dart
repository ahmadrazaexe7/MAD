import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // nice modern fonts

void main() {
  runApp(const TravelGuideApp());
}

class TravelGuideApp extends StatelessWidget {
  const TravelGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Guide',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const MainScaffold(),
    );
  }
}

/* ---------------- MAIN SCAFFOLD ---------------- */
class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    DestinationListScreen(),
    AboutScreen(),
  ];

  final List<String> _titles = ['Home', 'Destinations', 'About'];

  void _onSelectIndex(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.indigo.shade50,
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo, Colors.deepPurple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Travel Guide',
                  style: GoogleFonts.poppins(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            _drawerTile(Icons.home, 'Home', 0),
            _drawerTile(Icons.list_alt_rounded, 'Destinations', 1),
            _drawerTile(Icons.info_outline, 'About', 2),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text('Semester Project • Riphah',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        elevation: 5,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (i) => setState(() => _selectedIndex = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.list_alt), label: 'List'),
          NavigationDestination(icon: Icon(Icons.grid_view), label: 'About'),
        ],
      ),
    );
  }

  ListTile _drawerTile(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon, color: Colors.indigo),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      onTap: () => _onSelectIndex(index),
    );
  }
}

/* ---------------- HOME SCREEN ---------------- */
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg), behavior: SnackBarBehavior.floating));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            'assets/images/home_banner.jpg',
            height: 220,
            fit: BoxFit.cover,
            errorBuilder: (ctx, err, st) => Image.network(
              'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
              height: 220,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.indigo.shade50, Colors.indigo.shade100]),
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(16),
          child: const Text(
            'Welcome to your personal Travel Guide app! Discover breathtaking destinations and plan your next adventure.',
            style: TextStyle(fontSize: 16, height: 1.4),
          ),
        ),
        const SizedBox(height: 18),
        RichText(
          text: TextSpan(children: [
            TextSpan(
                text: 'Explore ',
                style: GoogleFonts.poppins(
                    color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500)),
            TextSpan(
                text: 'the World ',
                style: GoogleFonts.poppins(
                    color: Colors.indigo,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
            TextSpan(
                text: 'with Confidence',
                style: GoogleFonts.poppins(
                    color: Colors.deepOrange,
                    fontSize: 22,
                    fontWeight: FontWeight.w600)),
          ]),
        ),
        const SizedBox(height: 14),
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'Enter destination name',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.travel_explore),
              onPressed: () {
                final text = _controller.text.trim();
                text.isEmpty
                    ? _showSnack('Please enter a destination!')
                    : _showSnack('Searching for "$text"...');
              },
              label: const Text('Search'),
            ),
            const SizedBox(width: 12),
            OutlinedButton.icon(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _controller.clear();
                _showSnack('Cleared.');
              },
              label: const Text('Clear'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text('Popular Categories',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, fontSize: 17)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: const [
            Chip(label: Text('Beaches')),
            Chip(label: Text('Mountains')),
            Chip(label: Text('Cities')),
            Chip(label: Text('Historical')),
            Chip(label: Text('Nature')),
          ],
        ),
        const SizedBox(height: 20),
        Center(
          child: Text(
            '✨ Build memories. Travel smart with this app!',
            style: TextStyle(color: Colors.indigo.shade700),
          ),
        ),
      ],
    );
  }
}

/* ---------------- LIST SCREEN ---------------- */
class DestinationListScreen extends StatelessWidget {
  const DestinationListScreen({super.key});
  final List<Map<String, String>> destinations = const [
    {'name': 'Paris, France', 'desc': 'City of lights & love.'},
    {'name': 'Kyoto, Japan', 'desc': 'Temples, shrines & cherry blossoms.'},
    {'name': 'New York, USA', 'desc': 'Broadway, skyscrapers & parks.'},
    {'name': 'Rome, Italy', 'desc': 'Ancient ruins & vibrant cuisine.'},
    {'name': 'Cairo, Egypt', 'desc': 'Timeless pyramids of Giza.'},
    {'name': 'Sydney, Australia', 'desc': 'Beaches & Opera House.'},
    {'name': 'Cape Town, SA', 'desc': 'Table Mountain & beaches.'},
    {'name': 'Istanbul, Turkey', 'desc': 'Where East meets West.'},
    {'name': 'Reykjavik, Iceland', 'desc': 'Northern lights magic.'},
    {'name': 'Machu Picchu, Peru', 'desc': 'Ancient Incan wonder.'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: destinations.length,
      itemBuilder: (context, index) {
        final dest = destinations[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          elevation: 3,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.indigo.shade100,
              child: Text('${index + 1}',
                  style: const TextStyle(color: Colors.indigo)),
            ),
            title: Text(dest['name']!,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(dest['desc']!),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16))),
                  builder: (ctx) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(dest['name']!,
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(dest['desc']!),
                          const SizedBox(height: 12),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.favorite_border),
                            label: const Text('Add to Favourites'),
                            onPressed: () {
                              Navigator.pop(ctx);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          '${dest['name']} added to favourites!')));
                            },
                          )
                        ],
                      ),
                    );
                  });
            },
          ),
        );
      },
    );
  }
}

/* ---------------- ABOUT SCREEN ---------------- */
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  final List<Map<String, String>> attractions = const [
    {'image': 'assets/images/attraction1.jpg', 'title': 'Eiffel Tower'},
    {'image': 'assets/images/attraction2.jpg', 'title': 'Great Wall'},
    {'image': 'assets/images/attraction3.jpg', 'title': 'Statue of Liberty'},
    {'image': 'assets/images/attraction4.jpg', 'title': 'Taj Mahal'},
    {'image': 'assets/images/attraction5.jpg', 'title': 'Sydney Opera House'},
    {'image': 'assets/images/attraction6.jpg', 'title': 'Machu Picchu'},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: attractions.length,
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
          crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 3 / 4),
      itemBuilder: (context, index) {
        final a = attractions[index];
        return Hero(
          tag: a['title']!,
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: InkWell(
              onTap: () => _showPreview(context, a),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Image.asset(a['image']!,
                          fit: BoxFit.cover, width: double.infinity,
                          errorBuilder: (c, e, s) {
                            return Image.network(
                                'https://images.unsplash.com/photo-1508264165352-c7d0b9f6b6d5',
                                fit: BoxFit.cover);
                          })),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(a['title']!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8, bottom: 8),
                    child: Text('Famous Landmark',
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showPreview(BuildContext context, Map<String, String> a) {
    showDialog(
        context: context,
        builder: (ctx) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Hero(
              tag: a['title']!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image.asset(a['image']!,
                        fit: BoxFit.cover,
                        errorBuilder: (c, e, s) => Image.network(
                            'https://images.unsplash.com/photo-1508264165352-c7d0b9f6b6d5',
                            fit: BoxFit.cover)),
                    Container(
                      color: Colors.black54,
                      padding: const EdgeInsets.all(12),
                      child: Text(a['title']!,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
