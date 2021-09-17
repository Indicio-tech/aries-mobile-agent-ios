# About Aries Mobile Agent iOS

This framework is a Swift wrapper around the Objective-C Indy.Framework. The official source for Indy is located here: [Hyperledger Indy Sdk](https://github.com/hyperledger/indy-sdk).

**_Note: At this time, apps built with Aries Mobile Agent iOS will not work in the Xcode canvas or on simulators, and will only work on a physical device._**

# Aries Mobile Agent iOS Install

## Download the two required frameworks

1. Download or clone this repo, specifically the Indy.Framework and the Aries.Framework folders, located in the root directory
2. Decompress, if necessary

## Add them to your project

1. Open your Xcode Project (or XCWorkspace)
2. Drag both the Indy.Framework and the Aries.Framework folders into the root directory of your project in the Xcode file explorer. You should select to Copy items if needed, Create groups and add to the relevant targets.
3. Go into the Build Settings for the project and change "Enable Bitcode" to "No"
4. Go to the General tab, and down to "Frameworks, Libraries and Embedded Content". You should see both Indy.Framework and Aries.Framework
5. You should be able to now "import Aries" into your project. _Note that you should avoid importing "Indy", as there may be issues with the shared instance._

# Building the AMA-iOS Framework File

The framework is a product of the build/compile cycle in XCode. To use AMA-iOS in a project, you have to place a copy of that framework folder into the root directory. There may be a way to just have an XCode project point to that compiled framework folder, but I haven't tested it yet.

1. Open the XCode Project file
2. Build the project
3. Expand the folder xxx to show the Aries.Framework folder
4. Right-click on the folder and select "Show in Finder"
5. Copy that folder into another location

# Troubleshooting

1. Apple silicon issuses?
2. Need to check whether people will need to install some of the Indy dependencies.
