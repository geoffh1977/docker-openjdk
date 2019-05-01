#!/bin/bash
# Update The Software Version From Online

# Get The Versions Of The Software
JAVA_MAJOR=$(grep "javaMajorVersion" container.conf | cut -d= -f 2)
SITE_VERSION=$(curl -s https://nl.alpinelinux.org/alpine/v3.9/community/x86_64/ | grep "openjdk${JAVA_MAJOR}-${JAVA_MAJOR}\." | sed -e 's/<[^>]*>//g' | awk '{print $1}' |  grep -Eo "[0-9]{1,2}\.[0-9]{1,4}\.[0-9]{1,4}")
LOCAL_VERSION=$(grep "finalImageVersion" container.conf | cut -d= -f 2)

# Check Versions And Update File
if [ "$SITE_VERSION" != "$LOCAL_VERSION" ]
then
  sed -i "s/^finalImageVersion=.*/finalImageVersion=${SITE_VERSION}/" container.conf
  echo " Version Updated."
else
  echo " No Version Change."
fi
