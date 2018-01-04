#!/bin/sh

B='#00000000'  # blank
C='#393E4644'  # clear ish
D='#393E4600'  # default
T='#EEEEEEDD'  # text
W='#FF2E63BB'  # wrong
V='#08D9D6CC'  # verifying

i3lock -e -i ~/图片/Wallpapers/arch-linux-5991.png \
--radius=120          \
--ring-width=7        \
--ringcolor=$D        \
--ringvercolor=$V     \
--ringwrongcolor=$W   \
--keyhlcolor=$V       \
--bshlcolor=$W        \
\
--insidecolor=$B      \
--insidevercolor=$B   \
--insidewrongcolor=$B \
\
--linecolor=$B        \
--separatorcolor=$D   \
\
--veriftext=""        \
--wrongtext=""        \
--textsize=32         \
--textcolor=$T        \
# --statusfont="FiraCode" \
# \
# --clock               \
# --timestr="%H:%M"     \
# --timefont="Ubuntu"   \
# --timesize=48         \
# --timecolor=$T        \
# --datestr="%A, %d %B %Y" \
# --datefont="Ubuntu"   \
# --datesize=22         \
# --datecolor=$T        \

# --indicator           \
# --modsize=10          \
# --blur 5
