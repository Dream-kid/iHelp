<p align="center">
  <img src="https://github.com/Dream-kid/iHelp/blob/main/iHelp/Resources/Assets.xcassets/AppLogo.imageset/AppLogo.png" width="100" height="100" />
</p> 
 
 # iHelp
 
[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Alzheimer’s Care for Filipino-Americans with an iOS-Based Approach
## Requirements

| Requirement            | Details                                          |
|------------------------|--------------------------------------------------|
| Platform               | iOS 15.0                                        |
| Swift Version          | Swift 6.0.3                                       |
| Xcode Version          | Xcode 16.2                                      |
| Supported Architectures| arm64, x86_64 (Simulator)                        |
| Dependency Managers    | Swift Package Manager                            |
| Third-Party Services   | Firebase                                         |
| Contribution Guidelines| [Contribution Guide](#contributions)             |


### App Development Environment
* IDE and Code Editor: Xcode
* Core programming language: Swift
* UI Frameworks: UIKit & Swift
* Dependency manager: Swift Package Manager
* Version control system: Git
* Backend Infrastructure: Firebase SDKs
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

### Step 4: Configure Firebase
The project uses Firebase as a third-party service. the project already includes Firebase configuation, but to configure Firebase your own:
* Download the GoogleService-Info.plist file from your Firebase project's settings page.
* Drag and drop the GoogleService-Info.plist file into the root of your Xcode project. Ensure you select "Copy items if needed" and add the file to all relevant targets.

### Step 5: Run the Project
Select your target device or simulator from the Xcode toolbar. Then, press the Run button (▶) to build and run the project.

## Dependencies

iHelp depends on the following libraries:

- [Firebase](https://github.com/firebase/firebase-ios-sdk)
- [AVFoundation](https://github.com/theos/sdks/tree/master/iPhoneOS9.3.sdk/System/Library/Frameworks/AVFoundation.framework)
- [Alamofire](https://github.com/Alamofire/Alamofire)
- [Coremltools](https://github.com/apple/coremltools)


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
