aliasPath Project
=================
:author: Richard Brooksby
:organization: Ravenbrook Limited
:date: 2013-07-07

This is a simple Xcode project to build a command line tool that
extracts and prints the POSIX path to the original of a Finder alias
file.  It outputs the same information displayed by the Finder in the
"Get Info" window under "Original", but suitable for use in scripts.

It is mainly useful for repairing broken aliases, because it will work
even if the original can't be found.  This effect can't be achieved with
AppleScript.
