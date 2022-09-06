# iOS Technical Test

## Instructions to build the project

- Open the RestaurantiOS.xcodeproj file using Xcode.
- Once the project is open in the Xcode enviroment, make sure it compiles. For this go to the Product menu and the click in Build, or you can use the cmd+B shortcut.
- If the project compiles successfully you can run it in a simulator by selecting the one you want to use in the status bar (In the left side of the Build succeded message) and then clicking in the "Play" button. 
- This will quickly build the app, run the simulator, install the app in it and launch it.
- You can also check the tests by opening the RestaurantiOSTests class in the project and clicking the diamond icon next to the class name. This will run the tests.
- Another option to run the tests are the following command lines:
    - xcrun simctl list (This command will list the simulators available)
    - xcodebuild test -project RestaurantiOS.xcodeproj -scheme RestaurantiOS -destination 'platform=iOS Simulator,name=iPhone 13' (This command will run the tests in the simulator with name iPhone 13. Change that value to one of your available simulators.)
    
## Technical choices and potential difficulties

### Technical choices

- MVVM was selected as architectural pattern for this project as it is a very flexible pattern for any app size (considering this one is a small app). Also this architectural pattern is the one I have more experience with, so I felt more confident using it.
- XCTests were added. I could have been used some testing framework but I didn't want to add more complexity to this project.
- I've added an extension for UIImageView in order to make the loading of network images easier in the app. This way we can use the added "load" method in UIImage to pass an URL parameter and the image will be downloaded from the network and rendered in the view.
- I've implemented a custom decoding for the restaurants response to adjust the properties in the response to what we need in the app. The data in the JSON file has a complex structure that does not fit with our needs. I've processed the responde to get those values and format them as we need them to be shown in the app.
- UserDefaults was used to store the favorites restaurants configuration in the app. I think this solution is enough for this particular project. There are other options, but the information handled was not that big and any other solution would have added more complexity to the project.

### Potential difficulties

- The constraints used for the table and cells layout need to be reviewed and improved as the elements in the screen could have a better design. In previous projects I've used Masonry to solve this. In more recent projects I have been using SwiftUI, but the requirement was to use UIKit.
