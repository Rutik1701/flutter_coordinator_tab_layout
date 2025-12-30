import 'package:flutter/material.dart';

class CustomCoordinatorTabLayout extends StatefulWidget {
  final double maxHeaderHeight;
  final double minHeaderHeight;
  final Widget header;
  final List<String> tabs;
  final List<Widget> pages;

  const CustomCoordinatorTabLayout({
    super.key,
    required this.header,
    required this.tabs,
    required this.pages,
    this.maxHeaderHeight = 260,
    this.minHeaderHeight = 120,
  }) : assert(tabs.length == pages.length);

  @override
  State<CustomCoordinatorTabLayout> createState() =>
      _CustomCoordinatorTabLayoutState();
}

class _CustomCoordinatorTabLayoutState
    extends State<CustomCoordinatorTabLayout> {
  double _headerHeight = 0;
  int _tabIndex = 0;
  final ScrollController _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _headerHeight = widget.maxHeaderHeight;
    _scroll.addListener(_onScroll);
  }

  void _onScroll() {
    double h = widget.maxHeaderHeight - _scroll.offset;
    if (h < widget.minHeaderHeight) h = widget.minHeaderHeight;
    if (h > widget.maxHeaderHeight) h = widget.maxHeaderHeight;
    setState(() => _headerHeight = h);
  }

  void _selectTab(int i) {
    setState(() => _tabIndex = i);
    _scroll.jumpTo(0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// HEADER
        AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          height: _headerHeight,
          width: double.infinity,
          child: widget.header,
        ),

        /// TABS
        Container(
          height: 56,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 8)
            ],
          ),
          child: Row(
            children: List.generate(
              widget.tabs.length,
                  (i) => Expanded(
                child: GestureDetector(
                  onTap: () => _selectTab(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    decoration: BoxDecoration(
                      color: _tabIndex == i
                          ? Colors.blueAccent
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Text(
                        widget.tabs[i],
                        style: TextStyle(
                          color: _tabIndex == i
                              ? Colors.white
                              : Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        /// CONTENT
        Expanded(
          child: ListView(
            controller: _scroll,
            padding: const EdgeInsets.all(16),
            children: [widget.pages[_tabIndex]],
          ),
        ),
      ],
    );
  }
}


// import 'package:flutter/material.dart';
//
//
// class CoordinatorTabsDemo extends StatelessWidget {
//   const CoordinatorTabsDemo({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         body: NestedScrollView(
//           headerSliverBuilder: (context, innerBoxIsScrolled) {
//             return [
//               /// COLLAPSING APP BAR (Coordinator behavior)
//               SliverAppBar(
//                 expandedHeight: 260,
//                 pinned: true,
//                 floating: false,
//                 elevation: 0,
//                 backgroundColor: Colors.blueAccent,
//
//                 /// Title animation
//                 title: const Text("Coordinator Tabs"),
//                 centerTitle: true,
//
//                 /// EXPANDED HEADER
//                 flexibleSpace: FlexibleSpaceBar(
//                   collapseMode: CollapseMode.parallax,
//                   background: Container(
//                     decoration: const BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [Colors.blue, Colors.purple],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       ),
//                     ),
//                     child: const Center(
//                       child: Icon(
//                         Icons.layers,
//                         size: 90,
//                         color: Colors.white70,
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 /// STICKY TAB BAR
//                 bottom: const PreferredSize(
//                   preferredSize: Size.fromHeight(48),
//                   child: ColoredBox(
//                     color: Colors.white,
//                     child: TabBar(
//                       indicatorColor: Colors.deepOrange,
//                       indicatorWeight: 4,
//                       labelColor: Colors.black,
//                       unselectedLabelColor: Colors.grey,
//                       tabs: [
//                         Tab(text: "Home"),
//                         Tab(text: "Profile"),
//                         Tab(text: "Settings"),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ];
//           },
//
//           /// TAB CONTENT
//           body: const TabBarView(
//             children: [
//               _TabPage(title: "Home Page"),
//               _TabPage(title: "Profile Page"),
//               _TabPage(title: "Settings Page"),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// /// CUSTOM TAB PAGE
// class _TabPage extends StatelessWidget {
//   final String title;
//
//   const _TabPage({required this.title});
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: 25,
//       itemBuilder: (context, index) {
//         return Card(
//           elevation: 2,
//           margin: const EdgeInsets.only(bottom: 12),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: ListTile(
//             leading: const CircleAvatar(
//               backgroundColor: Colors.blueAccent,
//               child: Icon(Icons.star, color: Colors.white),
//             ),
//             title: Text("$title Item ${index + 1}"),
//             subtitle: const Text("Smooth coordinated scrolling"),
//           ),
//         );
//       },
//     );
//   }
// }
