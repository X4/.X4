#!/bin/sh

mount -t debugfs debugfs /sys/kernel/debug -o remount
modprobe radeon
echo "Turning off ATI graphics"
echo IGD > /sys/kernel/debug/vgaswitcheroo/switch
echo OFF > /sys/kernel/debug/vgaswitcheroo/switch

