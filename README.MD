#Swiftlog


This is a simple logging framework for Swift. 


### Available Functions
This framework creates four logging functions that offer varying degrees of debug data:
- DebugLog()			- Prints prefix, date, function, line, string
- DebugLogWhereAmI()	- Prints prefix, date, function, line
- StrippedLog()			- Prints prefix, function, line, string
- BareLog()				- Prints prefix, string

### Features
It also offers the following features:
- Set whitelists - only display logs with text in whitelist
- Set blacklists - do not show logs with text in blacklist
- Write logs to files
- Log asynchronously
