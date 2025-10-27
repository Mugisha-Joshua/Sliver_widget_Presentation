import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SliverGrid Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const SliverGridDemo(),
    );
  }
}

class SliverGridDemo extends StatelessWidget {
  const SliverGridDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        // CustomScrollView is REQUIRED for slivers - it coordinates multiple scrollable areas
        slivers: <Widget>[
          // 1. APP BAR SLIVER - Collapsible app bar
          SliverAppBar(
            title: const Text('SliverGrid Demo'),
            floating: true, // App bar appears when scrolling up
            snap: true, // Smooth animation when appearing
            expandedHeight: 200.0, // Height when fully expanded
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://picsum.photos/1200/800',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 2. HEADER SECTION - Simple text header
          SliverToBoxAdapter(
            // Converts regular widgets to slivers
            child: Container(
              color: Colors.blue[50],
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Featured Products',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // 3. FIRST SLIVERGRID - Fixed number of columns (3)
          SliverGrid(
            // This delegate controls the grid layout
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Always 3 columns regardless of screen size
              crossAxisSpacing: 8.0, // Space between columns
              mainAxisSpacing: 8.0, // Space between rows
              childAspectRatio: 0.8, // Width/Height ratio (0.8 = wider than tall)
            ),
            // This delegate builds the grid items
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                // This builder is called only for visible items (performance!)
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.amber[100 * ((index % 9) + 1)],
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_bag,
                        size: 40,
                        color: Colors.blue[700],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Product ${index + 1}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('\$${(index + 1) * 10}'),
                    ],
                  ),
                );
              },
              childCount: 6, // Build 6 items for this grid
            ),
          ),

          // 4. ANOTHER HEADER
          SliverToBoxAdapter(
            child: Container(
              color: Colors.green[50],
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Recommended Items',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // 5. SECOND SLIVERGRID - Maximum tile width (adaptive columns)
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0, // Each item max width = 200px
              // The grid automatically calculates how many columns fit
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 1.0, // Square items (1:1 ratio)
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final colors = [
                  Colors.red[100],
                  Colors.green[100],
                  Colors.purple[100],
                  Colors.orange[100],
                  Colors.teal[100],
                ];
                
                return Card(
                  elevation: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: colors[index % colors.length],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Item ${index + 7}', // Continue numbering from first grid
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              childCount: 8, // Build 8 items for this grid
            ),
          ),

          // 6. REGULAR LIST SECTION - Showing SliverList integration
          SliverToBoxAdapter(
            child: Container(
              color: Colors.purple[50],
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Customer Reviews',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // 7. SLIVERLIST - Demonstrating mixing different sliver types
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('U${index + 1}'),
                  ),
                  title: Text('User ${index + 1}'),
                  subtitle: Text('Great product! Love item ${index + 1}'),
                  trailing: const Icon(Icons.star, color: Colors.amber),
                );
              },
              childCount: 5, // 5 list items
            ),
          ),

          // 8. FOOTER
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'End of content',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}