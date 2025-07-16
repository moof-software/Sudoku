# Sudoku App

A modern, native iOS Sudoku app built with Swift.

## Features

- Clean and intuitive user interface
- Responsive layout for all iPhone screen sizes
- Multiple difficulty levels
- Pencil mark support
- Intelligent hint system
- Error checking and highlighting
- Light and dark mode support
- Game timer and stats

## Technologies Used

- Swift
- SwiftUI
- Combine
- Core Data (for puzzle persistence)
- XCTest (for unit and UI testing)

## Installation

1. Clone the repository:
```bash
git clone https://github.com/your-username/sudoku-app.git
```

2. Open the project in Xcode:
```bash
open Sudoku.xcodeproj
```

3. Select your target device or simulator and run the app.

## Folder Structure

```graphql
Sudoku/
├── Sudoku/                    # Main app source
│   ├── Assets.xcassets/       # App icons and color assets
│   ├── GameHomeView.swift     # Main Game UI content
│   ├── Item.swift             # Model or component file
│   ├── SudokuApp.swift        # App entry point
│   └── Documentation.docc/    # Developer documentation
│       └── Documentation.md
├── Sudoku.xcodeproj/          # Xcode project files
├── SudokuTests/               # Unit tests
│   └── SudokuTests.swift
├── SudokuUITests/             # UI tests
│   ├── SudokuUITests.swift
│   └── SudokuUITestsLaunchTests.swift
├── README.md                  # Project readme
├── LICENSE                    # License file
├── build/                     # Xcode build artifacts (can be ignored in VCS)
└── .xcworkspace/              # Xcode workspace settings
```
