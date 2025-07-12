import 'package:flutter/material.dart';

class CreatorProfileScreen extends StatefulWidget {
  const CreatorProfileScreen({super.key});

  @override
  State<CreatorProfileScreen> createState() => _CreatorProfileScreenState();
}

class _CreatorProfileScreenState extends State<CreatorProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isFollowing = false;
  bool isSubscribed = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  void _toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
    });
  }

  void _toggleSubscribe() {
    setState(() {
      isSubscribed = !isSubscribed;
    });
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('@reel_creator'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),

          // Profile Picture
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('assets/user.png'),
          ),
          const SizedBox(height: 10),

          // Counters Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _counterTile('Followers', '1.2K'),
                _counterTile('Following', '150'),
                _counterTile('Sent', '80'),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Bio
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Welcome guys 🙏\nYou may join the channel, but you should be 18+ 😁😁",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70),
            ),
          ),

          const SizedBox(height: 12),

          // Subscribe and Follow buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _toggleSubscribe,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSubscribed ? Colors.grey[800] : Colors.green,
                ),
                child: Text(isSubscribed ? 'Subscribed' : 'Subscribe'),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: _toggleFollow,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: isFollowing ? Colors.grey : Colors.green),
                ),
                child: Text(isFollowing ? 'Following' : 'Follow'),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Tab Bar
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Post'),
              Tab(text: 'Sub'),
              Tab(text: 'About'),
              Tab(text: 'Fans'),
            ],
            labelColor: Colors.green,
            unselectedLabelColor: Colors.white,
            indicatorColor: Colors.green,
          ),

          // TabBar View
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTabContent('Post Content'),
                _buildTabContent('Sub Content'),
                _buildTabContent('About Content'),
                _buildTabContent('Fans Content'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _counterTile(String label, String count) {
    return GestureDetector(
      onTap: () => _showSnack('$label tapped'),
      child: Column(
        children: [
          Text(
            count,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(label, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildTabContent(String content) {
    return Center(
      child: Text(content, style: const TextStyle(color: Colors.white70, fontSize: 18)),
    );
  }
}
