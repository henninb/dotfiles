# fdisk

https://unix.stackexchange.com/questions/542132/how-to-avoid-naming-of-partitions-with-parted

#!/bin/bash

LANG=C

echo "g
n


+256m

n


+1g

n




w" | fdisk /dev/sdX
exit 0


Explanation
The following list does not work (the comments are not accepted by fdisk), but it helps understanding the script above.

#!/bin/bash

LANG=C

echo "g     # gpt, GUID partition table
n           # new partition
            # default partition number
            # default start location
+256m       # size
            # default answer to partition name
n           # new partition
            # default partition number
            # default start location
+1g         # size
            # default answer to partition name
n           # new partition
            # default partition number
            # default start location
            # default end location at the drive's tail end
            # default answer to partition name
w           # write to the drive" | fdisk /dev/sdX
