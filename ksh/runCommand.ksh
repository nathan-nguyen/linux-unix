#! /bin/ksh
#-------------------------------------------------------------------------------
#   Description:
#       Execute a command and send email to notify
#-------------------------------------------------------------------------------
#   Syntax:
#       runCommand.ksh <Command>
#-------------------------------------------------------------------------------

if [ "$#" -ne 1 ]
then echo "Syntax Error: runCommand.ksh <Command>"
    exit 1
fi

COMMAND=$1
FROM=`whoami`
SUBJECT="Batch Run Result"
RECIPIENT=email@host
LOG=/tmp/emailMsg

# Remove the log file
\rm -f $LOG

START_TIME=`date`
eval $COMMAND | tee -a $LOG
END_TIME=`date`
#mailx -s #SUBJECT $RECIPIENT < $LOG

BODY=`sed s/$/'<br>'/g $LOG | sed s/'OK'/"<b><font color=\"#006400\">OK<\/font><\/b>"/g | sed s/'FAILED'/"<b><font color=\"#FF0000\">FAILED<\/font><\/b>"/g`
MSG=$(cat <<EOF
From: $FROM
To: $RECIPIENT
CC:
Subject: $SUBJECT
Mime-Version: 1.0;
Content-Type: multipart/mixed; charset="ISO-8859-1"; boundary="part_boundary";

--part_boundary
Mime-Version: 1.0;
Content-Type: text/html; charset="ISO-8859-1";
Content-Transfer-Encoding: 7bit;

<p><b>Command:</b> ${COMMAND}</p>
<p><b>Start time:</b> ${START_TIME}</p>
<p>
$BODY
</p>
<p><b>End time:</b> ${END_TIME}</p>

EOF
)

mailx -t <<EOF
${MSG}
EOF

