# Set (card game)
A native iOS application for the game of Set. Learn how to play the game [here](https://en.wikipedia.org/wiki/Set_(card_game)).

## Demo

https://github.com/user-attachments/assets/42ff3434-9af8-4f3c-9340-9742a0023921

## Steps to build and run the application:

### Prerequisites
1. Download [Xcode](https://developer.apple.com/xcode/) if you dont have it already
2. Install Xcode Command Line Tools if you don't have it already: `xcode-select –-install`

### Cloning and navigating to the repository
1. Open your terminal and navigate to the directory you want to store this repo in
2. Clone the repo using: `git clone https://github.com/leerachel5/SetCardGame.git`
3. Navigate to the newly-created repo using: `cd SetCardGame`

### Setting up the simulator 
1. Obtain the list of simulators using: `xcrun simctl list`. This will give you a list of all simulator devices, runtimes and device types:
   ```
   == Device Types ==
   iPhone 15 Pro (com.apple.CoreSimulator.SimDeviceType.iPhone-15-Pro)
   == Runtimes ==
   iOS 17.5 (17.5 - 21F79) - com.apple.CoreSimulator.SimRuntime.iOS-17-5
   ```
3. Create a simulator: `xcrun simctl create <SIMULATOR_NAME> com.apple.CoreSimulator.SimDeviceType.iPhone-15-Pro com.apple.CoreSimulator.SimRuntime.iOS-17-5`, replacing `<SIMULATOR_NAME>` with a name for the simulator
4. After running the above command, you will get a UUID, which is an identifier for the newly created simulator. You will need this UUID in the following steps. If you ever lose this UUID, you can find it by running `xcrun simctl list`
5. Boot the simulator: `xcrun simctl boot <UUID>`, replacing `<UUID>` with the result you got from running the command in step 4
6. Open the simulator app: open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app/

### Building, installing, and launching the app:
1. Build the app: `xcodebuild -project SetCardGame.xcodeproj -scheme SetCardGame -destination "platform=iOS Simulator,name=iPhone 15 Pro Max,OS=17.5" SYMROOT="./build" build`
2. Install the built app to the simulator: `xcrun simctl install booted build/Debug-iphonesimulator/SetCardGame.app`
3. Launch the app: `xcrun simctl launch booted com.rachellee.ios-bootcamp.SetCardGame`

### Clean up
1. Run `xcrun simctl shutdown <UUID>` to shutdown your simulator
