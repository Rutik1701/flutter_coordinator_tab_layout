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



