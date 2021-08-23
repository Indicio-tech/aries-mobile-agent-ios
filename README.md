# Lib Indy Install

1.  Create a new Xcode project (Single view app)
2.  Close Xcode
3.  Create a terminal window in the project directory you just created
4.  Run the "pod init" command
5.  Run the "pod install" command
6.  Navigate to the "Pods" folder (don't have to use terminal)
7.  Create an empty directory called "Frameworks" within Pods folder
8.  Download LibIndy for iOS: https://github.com/hyperledger/aries-mobile-agent-react-native/tree/main/ios/Pods/Frameworks
9.  Extract the archive and move the Indy.framework folder into the Pods > Frameworks folder you created in step 7
10. Open up the .xcworkspace file NOT the .xcodeproj file
11. Go to the App Target > General Tab > Frameworks, Libraries and Embedded Content section
12. Expand the section and click the "+" to add
13. Go down to "Add Other…" on the drop-down menu at the bottom and select "Add files…"
14. ameworks folder and click "Open"
15. You should see the framework has been added with the little suitcase icon in that section
16. Go to Targets - Build Settings -> Architectures -> change Supported Platforms to only include 'iphoneos'
17. Build the project (note that Indy will NOT work with the simulators, it must be run on a device)
18. Go to Target -> 'Build Settings' -> Set "Enable Bitcode" to 'No'
19. You should be able to go into any Swift file in the project now and use the "import Indy" command and then get access to the framework.
