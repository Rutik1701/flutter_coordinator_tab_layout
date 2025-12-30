import 'package:flutter/material.dart';



/// DEMO SCREEN
class DemoScreen extends StatelessWidget {
  const DemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F5F8),
      body: SafeArea(
        child: CustomCoordinatorTabLayout(
          tabs: const ["Info", "Reviews", "Related"],
          header: _HeaderWidget(),
          pages: [
            _InfoPage(),
            _ReviewsPage(),
            _RelatedPage(),
          ],
        ),
      ),
    );
  }
}

/// CUSTOM COORDINATOR TAB LAYOUT

class CustomCoordinatorTabLayout extends StatefulWidget {
  final Widget header;
  final List<String> tabs;
  final List<Widget> pages;
  final double maxHeaderHeight;
  final double minHeaderHeight;

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
  final ScrollController _scrollController = ScrollController();

  double _headerHeight = 0;
  int _currentTab = 0;

  @override
  void initState() {
    super.initState();
    _headerHeight = widget.maxHeaderHeight;
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    double height =
        widget.maxHeaderHeight - _scrollController.offset;

    if (height < widget.minHeaderHeight) {
      height = widget.minHeaderHeight;
    } else if (height > widget.maxHeaderHeight) {
      height = widget.maxHeaderHeight;
    }

    setState(() => _headerHeight = height);
  }

  void _onTabChange(int index) {
    setState(() => _currentTab = index);
    _scrollController.jumpTo(0); // reset scroll
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// HEADER (COLLAPSING)
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
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
              ),
            ],
          ),
          child: Row(
            children: List.generate(
              widget.tabs.length,
                  (index) => Expanded(
                child: GestureDetector(
                  onTap: () => _onTabChange(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    decoration: BoxDecoration(
                      color: _currentTab == index
                          ? Colors.blueAccent
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Text(
                        widget.tabs[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _currentTab == index
                              ? Colors.white
                              : Colors.black54,
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
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            children: [
              widget.pages[_currentTab],
            ],
          ),
        ),
      ],
    );
  }
}


/// HEADER WIDGET

class _HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff2193b0), Color(0xff6dd5ed)],
        ),
      ),
      child: const Center(
        child: Text(
          "Custom Coordinator Tab Layout",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

/// TAB PAGES
class _InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      "INFO TAB\n\n"
          "This screen demonstrates a fully custom CoordinatorTabLayout "
          "implemented without TabBar, SliverAppBar, or PageView.\n\n"
          "The header collapses on scroll, tabs remain sticky, "
          "and content changes dynamically.",
      style: TextStyle(fontSize: 16, height: 1.6),
    );
  }
}

class _ReviewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        5,
            (index) => Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: const Icon(Icons.star, color: Colors.orange),
            title: Text("User ${index + 1}"),
            subtitle: const Text("Excellent experience"),
          ),
        ),
      ),
    );
  }
}

class _RelatedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        6,
            (index) => ListTile(
          leading: const Icon(Icons.link),
          title: Text("Related Item ${index + 1}"),
        ),
      ),
    );
  }
}
