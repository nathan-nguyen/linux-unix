#! /usr/bin/expect -f
################################################################################
#   Description:
#       Copy file using scp
#-------------------------------------------------------------------------------
#   Syntax:
#       secureCopy.sh <FILE_NAME> <USER@HOST_NAME> <DESTINATION> <PASSWORD>
################################################################################

set FILENAME [lindex $argv 0]
set HOSTNAME [lindex $argv 1]
set DESTINATION [lindex $argv 2]
set PASSWORD [lindex $argv 3]

spawn scp $FILENAME $HOSTNAME:$DESTINATION

expect {
    "Are you sure you want to continue connecting (yes/no)?" {
        send "yes\r"
    }
    "${HOSTNAME}'s password:" {
        send $PASSWORD\r
    }
    "Password: " {
        send $PASSWORD\r
    }
}
interact

