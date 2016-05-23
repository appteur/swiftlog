#swiftlog

This is a simple logging framework for Swift. 

It adds four logging functions that offer varying degrees of debug data:
1. DebugLog()			- Prints prefix, date, function, line, string
2. DebugLogWhereAmI()	- Prints prefix, date, function, line
3. StrippedLog()		- Prints prefix, function, line, string
4. BareLog()			- Prints prefix, string

It also offers the following features:
1. Set whitelists - only display logs with text in whitelist
2. Set blacklists - do not show logs with text in blacklist
3. Write logs to files
4. Log asynchronously