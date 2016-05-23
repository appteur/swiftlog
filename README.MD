#Swiftlog


This is a simple logging framework for Swift. 


### Available Functions
It adds four logging functions that offer varying degrees of debug data:
1. DebugLog()			- Prints prefix, date, function, line, string
2. DebugLogWhereAmI()	- Prints prefix, date, function, line
3. StrippedLog()		- Prints prefix, function, line, string
4. BareLog()			- Prints prefix, string

### Features
It also offers the following features:
- Set whitelists - only display logs with text in whitelist
- Set blacklists - do not show logs with text in blacklist
- Write logs to files
- Log asynchronously
