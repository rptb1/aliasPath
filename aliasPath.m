// aliasPath.m -- print the POSIX path to the original of a Finder alias file
//
// Copyright 2013 Richard Brooksby.
// Open source under the BSD 2-Clause License
// <http://opensource.org/licenses/BSD-2-Clause>.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
// 
// 1. Redistributions of source code must retain the above copyright
// notice, this list of conditions and the following disclaimer.
// 
// 2. Redistributions in binary form must reproduce the above copyright
// notice, this list of conditions and the following disclaimer in the
// documentation and/or other materials provided with the distribution.
// 
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
// IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
// PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
// TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
// PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
// LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
// NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include <Foundation/NSString.h>
#include <Foundation/NSArray.h>
#include <Foundation/NSError.h>
#include <Foundation/NSDictionary.h>
#include <Foundation/NSURL.h>
#include <Foundation/NSURLHandle.h>


int main(int argc, char *argv[])
{
    int ch;
    int quiet = 0;
    int names = 0;
    
    while ((ch = getopt(argc, argv, "qH")) != -1)
        switch (ch) {
        case 'q':
            quiet = 1;
            break;
        case 'H':
            names = 1;
            break;
        default:
            fprintf(stderr,
                    "Usage: %s [option...] [file...]\n"
                    "Options:\n"
                    "  -q    Silently ignore errors.\n"
                    "  -H    Always print filename headers with output lines.\n",
                    argv[0]);
            return EXIT_FAILURE;
        }
    argc -= optind;
    argv += optind;

    int i;
    for (i = 0; i < argc; ++i) {
        NSString *aliasPath = [NSString stringWithUTF8String:argv[i]];
        NSURL *aliasURL = [NSURL fileURLWithPath:aliasPath];
        NSError *error;
        NSData *bookmarkData = [NSURL bookmarkDataWithContentsOfURL:aliasURL error:&error];
        if (bookmarkData == nil) {
            if (!quiet)
                fprintf(stderr, "%s: %s\n", argv[i], [[error localizedDescription] UTF8String]);
            continue;
        }
        NSDictionary *values = [NSURL resourceValuesForKeys:@[NSURLPathKey]
                                           fromBookmarkData:bookmarkData];
        NSString *path = [values objectForKey:NSURLPathKey];
        const char *s = [path UTF8String];
        if (argc > 1 || names)
            printf("%s: ", argv[i]);
        puts(s);
    }

    return EXIT_SUCCESS;
}

