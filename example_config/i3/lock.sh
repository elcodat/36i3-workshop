#!/bin/sh

# timings
#
# 0m0.098s scrot -q100
# 0m0.047s scrot -q10
# 0m0.249s convert -colorspace Gray -scale 10% -scale 1000%
# 0m0.436s convert -colorspace Gray -interpolate nearest -virtual-pixel mirror -spread 30
# 0m0.429s convert -colorspace Gray -interpolate nearest -spread 30
# 0m0.603s convert -colorspace Gray -spread 30
#
# screenshot sizes
#
# $ for q in $(seq -w 10 10 100); do scrot -q $q foo_q_$q.jpg; done
# 112K Dec  8 11:05 foo_q_010.jpg
# 150K Dec  8 11:05 foo_q_020.jpg
# 180K Dec  8 11:05 foo_q_030.jpg
# 205K Dec  8 11:05 foo_q_040.jpg
# 227K Dec  8 11:05 foo_q_050.jpg
# 251K Dec  8 11:05 foo_q_060.jpg
# 286K Dec  8 11:05 foo_q_070.jpg
# 341K Dec  8 11:05 foo_q_080.jpg
# 464K Dec  8 11:05 foo_q_090.jpg
# 1.1M Dec  8 11:05 foo_q_100.jpg
#
# * scrot:
#   * jpg is *much* faster (factor 10) than png
#   * -q10 and -q100 are both fast, but q10 has factor 10 smaller file size
#   * with -q10 we see jpg compression artifacts for low -spread values (like 5
#     or 10), but for high like 50 we don't, after all we only want to pixelate
#     the screen, not create art :)
# * convert:
#   * pixelating a jpg is a litte faster (factor 1.7), but i3lock only accepts
#     png [1], so we screenshot to jpg, but write out a pixelated png, ack!
#   * -interpolate nearest: almost factor of 2 faster
#   * no effect on speed:
#     * -spread N: different N
#     * -virtual-pixel mirror
#     * -colorspace Gray
#   * scale down and up again (-scale 100/x -scale 100*x) for pixelating is
#     fastest
#
# [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=776682

[ -d /dev/shm ] && tmpdir=/dev/shm || tmpdir=/tmp
shot=$tmpdir/screenshot.jpg
shot_blur=$tmpdir/screenshot_blur.png

##timeit(){
##    # http://ubuntuforums.org/showthread.php?t=1876531
##    tim=$((time $@) 2>&1 | sed -nre 's/real\s+(.*)/\1/p')
##    echo "$tim $@" | sed -re "s|$shot||" -e "s|$shot_blur||"
##}

# dims=[width]x[height]
# Need that to scale back exactly to the original size. Fast scale operations
# such as
#
#   convert -scale 10% -scale 1000%
#
# do not use fancy rescaling. The down-scaling (-scale 10% in the example) may
# change the aspect ratio slightly, for instance if the original pixels are not
# both divisible by 10. Therefore, the up-scaling will not restore the original
# size exactly and can leave borders at screen edges. This can be solved by
#
#   convert -scale 10% -scale ${orig_width}x${orig_height}\!
#
# The flag "!" behind the dimensions instructs convert to ignore the aspect
# ratio of the scaled down image, which is about to be scaled up again.
#
# Caveat: even if
#   qiv $shot_blur # NOT qiv -f $shot_blur
# fills the screen,
#   i3lock -i $shot_blur
# might not!
dims=$(xdpyinfo | sed -nre 's/\s+dimensions:\s+(.*)\s+pix.*/\1/p')
scrot -q10 $shot
convert -colorspace Gray -scale 5% -scale $dims\! $shot $shot_blur
rm $shot
i3lock -i $shot_blur

# use this instead of i3lock for testing
##qiv $shot_blur
