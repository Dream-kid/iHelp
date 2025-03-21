<p align="center">
  <img src="https://github.com/Dream-kid/iHelp/blob/main/iHelp/Resources/Assets.xcassets/AppLogo.imageset/AppLogo.png" width="150" height="150" />
</p> 
 
 # iHelp
 
[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

iHelp: An iOS-based mHealth system for Care Partner Activation Program for Filipino-American AD/ADRD Caregivers
## Requirements

| Requirement            | Details                                          |
|------------------------|--------------------------------------------------|
| Platform               | iOS 16.0+                                        |
| Swift Version          | Swift 5.3                                       |
| Xcode Version          | Xcode 14.0+                                      |
| Supported Architectures| arm64, x86_64 (Simulator)                        |
| Dependency Managers    | Swift Package Manager                            |
| Contribution Guidelines| [Contribution Guide](#contributions)             |


### App Development Environment
* IDE and Code Editor: Xcode
* Core programming language: Swift
* UI Frameworks: UIKit & SwiftUI
* Dependency manager: Swift Package Manager
* Version control system: Git
* Hardware: Mac computer


## Installation

This section provides instructions on setting up the project on your local development environment.

### Step 1: Clone the Repository

Clone the project repository to your local machine by running the following command in the terminal:

```bash
git clone https://github.com/Dream-kid/iHelp.git
cd iHelp
```

### Step 2: Setting Up the Project in Xcode
1. **Open the Project**: After cloning the repository, open the .xcodeproj file in Xcode:
2. **Install Dependencies**: Xcode should automatically fetch the dependencies with Swift Package Manager. If it doesn't, you can manually fetch and update the packages by navigating to: `Xcode > File > Swift Packages > Update to Latest Package Versions`

### Step 3:  Configuring Signing and Provisioning
Each target in the project (main app and extensions) requires specific signing and provisioning settings:
1. **Select the Team**: In Xcode's General tab for each target, select the appropriate team from the "Team" dropdown.
2. **Manage Signing**:
   - **Automatic**: For automatic signing, check "Automatically manage signing" and ensure the correct team is selected.
   - **Manual**: For manual signing, uncheck "Automatically manage signing" and select the specific provisioning profiles for each target, aligned with their bundle identifiers and capabilities.

### Step 4: Run the Project
Select your target device or simulator from the Xcode toolbar. Then, press the Run button (▶) to build and run the project.

## Dependencies

iHelp depends on the following libraries:

- [PagerTabStripView](https://github.com/xmartlabs/PagerTabStripView)
- [DateHelper](https://github.com/melvitax/DateHelper)
- [Reachability](https://github.com/ashleymills/Reachability.swift)
- [PDFKit](https://developer.apple.com/documentation/pdfkit)
- [XCTest](https://github.com/swiftlang/swift-corelibs-xctest)

## Contributions
Your contributions are appreciated! Here's how you can help:

1. **Fork** the repository.
2. **Create** a new branch: `git checkout -b feature/your-feature-name`.
3. **Commit** your changes: `git commit -am 'Add some feature'`.
4. **Push** to the branch: `git push origin feature/your-feature-name`.
5. **Open** a pull request.

Thank you for supporting iHelp!



## Troubleshooting
- Ensure all targets have the correct signing team and provisioning profiles, especially if using manual signing.
- For issues related to dependency fetching, verify your internet connection and the configuration of Swift Package Manager within Xcode.

Feel free to report any issues or ask for help by opening an issue on GitHub.



## License

iHelp is released under Apache License 2.0. [See LICENSE](https://github.com/Dream-kid/iHelp/blob/main/LICENSE) for details.
