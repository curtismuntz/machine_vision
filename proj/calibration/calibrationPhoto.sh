#!/bin/bash

#set the autofocus on the cameras to off
v4l2-ctl -c focus_auto=0
v4l2-ctl -d 1 -c focus_auto=0

cd ~/Desktop/
mkdir calibration/
mkdir calibration/video0
mkdir calibration/video1
cd calibration

# take 30 photos from each camera, pausing 3 seconds in between
for (( i = 0; i < 30; i++ )); do
	for (( j = 3; j >= 0; j-- )); do
		sleep 1
		echo "taking photo " + $i + " in " + $j + " seconds..."
	done
	ffmpeg -f v4l2 -i /dev/video0 -vframes 1 video0/video0_calib_$i.jpg
	ffmpeg -f v4l2 -i /dev/video1 -vframes 1 video1/video1_calib_$i.jpg
done

# not sure if i should re-enable autofocus
#v4l2-ctl -c focus_auto=1
#v4l2-ctl -d 1 -c focus_auto=1
