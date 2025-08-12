# Ebook-iOS

A simple iOS demo app that displays a collection of eBooks. Covers are loaded from a bundled JSON file and shown in a grid. Tapping a cover reveals a popup with actions such as read, share, or delete.

## Features
- UICollectionView grid of book covers
- Local JSON data source (`Application/data.json`)
- Popup view with buttons for read, share, and delete

## Project Structure
```
Ebook_IOS/
├── Application       # AppDelegate, assets, data.json and Core Data stack
├── Base.lproj        # Storyboards (Main and LaunchScreen)
├── Controller        # ViewController managing the collection view and popup
├── Model             # EBookModel struct describing books
└── View              # CollectionViewCell, PopUpView and XIB
```

## Data
Sample book data lives in `Application/data.json`:

```json
[
    {
        "title": "Alice in Wonderland",
        "cover": "cover1.png"
    }
]
```
Add more entries and corresponding images in `Assets.xcassets` to extend the library.

## Requirements
- Xcode 11 or later
- iOS 13+

## Building & Running
1. Clone the repository.
2. Open `Ebook_IOS.xcodeproj` in Xcode.
3. Select a simulator or device and run the project.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
