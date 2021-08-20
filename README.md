# Lib Indy Install 

* Create a new Xcode project (Single view app)
* Close Xcode
* Create a terminal window in the project directory you just created
* Run the "pod init" command
* Run the "pod install" command
* Navigate to the "Pods" folder (don't have to use terminal)
* Create an empty directory called "Frameworks" within Pods folder
* Download LibIndy for iOS: https://github.com/hyperledger/aries-mobile-agent-react-native/tree/main/ios/Pods/Frameworks
* Extract the archive and move the Indy.framework folder into the Pods > Frameworks folder you created in step 7
* Open up the .xcworkspace file NOT the .xcodeproj file
* Go to the App Target > General Tab > Frameworks, Libraries and Embedded Content section
* Expand the section and click the "+" to add
* Go down to "Add Other…" on the drop-down menu at the bottom and select "Add files…"
* Navigate to the Indy.framework folder in your Pods > Frameworks folder and click "Open"
* You should see the framework has been added with the little suitcase icon in that section
* go to Targets - Build Settings -> Architectures -> change Supported Platforms to only include 'iphoneos'
* Build the project (note that Indy will NOT work with the simulators, it must be run on a device)
* go to Target -> 'Build Options' -> Set Bitcode to 'No'
* You should be able to go into any Swift file in the project now and use the "import Indy" command and then get access to the framework.