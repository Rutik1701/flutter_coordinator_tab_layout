# Custom Coordinator Tab Layout (Flutter)

A **fully custom, dependency-free Flutter layout** inspired by Android’s  
**CoordinatorLayout + TabLayout**, built completely **from scratch**.

This widget manually coordinates:
- Collapsing header
- Sticky custom tabs
- Scroll-driven UI behavior

Perfect for **advanced UI designs**, **product pages**, and **custom layouts**
where default `TabBar` or `SliverAppBar` are too limiting.

---

## ✨ Features

📉 Collapsing header (min ↔ max height)  
📌 Sticky custom tab bar  
🎯 Manual scroll ↔ header coordination  
🔄 Scroll reset on tab change  
🎨 Fully customizable UI  
🧩 Reusable widget API  
⚡ Lightweight & clean architecture  

---

## ✨ Preview



https://github.com/user-attachments/assets/5d891698-d895-418a-9e0c-b577aa915784


---

## ✨ Installation
Add this to your package's pubspec.yaml file:
```
dependencies:
  coordinator_tab_layout:
    path: ../coordinator_tab_layout
```
▶️ From GitHub
```
dependencies:
  coordinator_tab_layout:
    git:
      url: https://github.com/yourusername/coordinator_tab_layout.git
```
Then Run:
```
flutter pub get
```
## 📁 Folder Structure
```
coordinator_tab_layout/
│
├── lib/
│   ├── coordinator_tab_layout.dart
│   │
│   └── src/
│       └── custom_coordinator_tab_layout.dart
│
├── example/
│   └── main.dart
│
└── README.md

  ```
## 📦 custom Code

Copy this file into your project (for example:  
`lib/src/custom_coordinator_tab_layout.dart`)

```
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
              BoxShadow(color: Colors.black12, blurRadius: 8),
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

```
## 🚀 Usage Example

```
CustomCoordinatorTabLayout(
  header: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue, Colors.purple],
      ),
    ),
    child: const Center(
      child: Text(
        "Custom Header",
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
  tabs: const ["Info", "Reviews", "Related"],
  pages: const [
    Text("Info Content"),
    Text("Reviews Content"),
    Text("Related Content"),
  ],
)
```
## 📜 License
MIT License
```
Copyright (c) 2025 Excelsior Technologies

Permission is hereby granted, free of charge, to any person obtaining a copy  
of this software and associated documentation files (the "Software"), to deal  
in the Software without restriction, including without limitation the rights  
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell  
copies of the Software, and to permit persons to whom the Software is  
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all  
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED **"AS IS"**, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,  
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
```
