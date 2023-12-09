#!/bin/bash

# Replace <PID> with the actual PID
output=$(lsappinfo info $1)

# Use awk to extract the values and construct a JSON object
echo "$output" | awk '
    BEGIN {
        print "{"
        key[1] = "name";
        key[2] = "asn";
        key[3] = "bundleID";
        key[4] = "bundlePath";
        key[5] = "executablePath";
        key[6] = "pid";
        key[7] = "type";
        key[8] = "flavor";
        key[9] = "version";
        key[10] = "fileType";
        key[11] = "creator";
        key[12] = "arch";
        key[13] = "checkinTime";
        i = 1;
    }
    {
        value = $0;
        gsub(/.*=|^[ \t]+|"[ ]*/, "", value);  # Extract value after '=' and remove quotes
        if (value == "[ NULL ]") {
            value = "null";
        } else {
            value = "\"" value "\"";
        }
        if (i < 13) {
            printf "    \"%s\": %s,\n", key[i], value;
        } else {
            printf "    \"%s\": %s\n", key[i], value;
        }
        i++;
    }
    END {
        print "}"
    }
'
