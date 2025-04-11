import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TailorProfilePage extends StatefulWidget {
  final String name;
  final String image;

  const TailorProfilePage({super.key, required this.name, required this.image});

  @override
  State<TailorProfilePage> createState() => _TailorProfilePageState();
}

class _TailorProfilePageState extends State<TailorProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isFollowing = false; // Follow button state
  final Set<String> _likedImages = {}; // Liked images set

  final List<String> allImages = [
    'images/1.jpg',
    'images/2.jpg',
    'images/3.jpg',
    'images/4.jpg',
    'images/5.jpg',
    'images/6.jpg',
    'images/7.jpg',
    'images/8.jpg',
    'images/9.jpg',
    'images/10.jpg',
    'images/11.jpg',
    'images/12.jpg',
    'images/13.jpg',
    'images/14.jpg',
    'images/15.jpg',
  ];

  final List<Map<String, dynamic>> reviews = [
    {"name": "Sarah M.", "rating": 5, "comment": "Amazing work! Loved it."},
    {"name": "John D.", "rating": 4, "comment": "Great quality, just a bit late."},
    {"name": "Emma R.", "rating": 5, "comment": ""},
    {"name": "Ahmed K.", "rating": 3, "comment": "Good, but could be better."},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: 180,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/6.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 10,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Positioned(
                bottom: -40,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      widget.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          Text(widget.name,
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(
            "Skilled tailor creating custom clothing with a perfect fit and unique style.",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          _buildFollowButton(),
          const SizedBox(height: 20),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)],
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Color.fromARGB(255, 163, 119, 178),
              unselectedLabelColor: Colors.grey,
              indicatorColor: Color.fromARGB(255, 163, 119, 178),
              tabs: const [
                Tab(text: "Portfolio"),
                Tab(text: "Reviews"),
                Tab(text: "About"),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildPortfolioTab(),
                  _buildReviewsTab(),
                  _buildAboutTab(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFollowButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isFollowing = !isFollowing;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: isFollowing ? Colors.grey : const Color.fromARGB(255, 163, 119, 178),
        ),
        child: Text(
          isFollowing ? "Unfollow" : "Follow",
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildPortfolioTab() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: allImages.length,
        itemBuilder: (context, index) {
          final imagePath = allImages[index];
          return GestureDetector(
            onDoubleTap: () => setState(() => _likedImages.contains(imagePath)
                ? _likedImages.remove(imagePath)
                : _likedImages.add(imagePath)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(imagePath, fit: BoxFit.cover),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Icon(
                    _likedImages.contains(imagePath) ? Icons.favorite : Icons.favorite_border,
                    color: _likedImages.contains(imagePath) ? Colors.red : Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildReviewsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        return Column(
          children: [
            Row(
              children: [
                const Icon(Icons.account_circle, size: 40, color: Colors.grey),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(review["name"], style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                    Row(
                      children: List.generate(5, (i) => Icon(
                        i < review["rating"] ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                      )),
                    ),
                  ],
                ),
              ],
            ),
            if (review["comment"].isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 50, top: 5),
                child: Text(review["comment"], style: GoogleFonts.poppins(fontSize: 14)),
              ),
            const Divider(),
          ],
        );
      },
    );
  }
   Widget _buildAboutTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            const SizedBox(height: 10),
          _buildInfoRow(Icons.phone, "Phone: +213 555 123 456"),
            const SizedBox(height: 20),
          _buildInfoRow(Icons.location_on, "Wilaya: Algiers, Algeria"),
            const SizedBox(height: 20),
          _buildInfoRow(Icons.work, "Type: Independent"),
            const SizedBox(height: 20),
          _buildInfoRow(Icons.grid_view,
              "Categories: Traditional, Modern"),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Color.fromARGB(255, 163, 119, 178)),
        const SizedBox(width: 10),
        Text(text, style: GoogleFonts.poppins(fontSize: 14)),
      ],
    );
  }
}