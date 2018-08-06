aliasPath
=========
:author: Richard Brooksby
:organization: Ravenbrook Limited
:date: 2013-07-07

aliasPath prints the POSIX path to the original of a Finder alias.

It outputs the same information displayed by the Finder in the
"Get Info" window under "Original", but suitable for use in scripts.

It is mainly useful for repairing broken aliases, because it will work
even if the original can't be found.  This effect can't be achieved with
AppleScript.

To build and install a copy of this tool into /usr/local/bin, clone
the repo elsewhere, then just::

    sudo xcodebuild install

Open source under the `BSD 2-Clause License`_.

.. _`BSD 2-Clause License`: http://opensource.org/licenses/BSD-2-Clause
