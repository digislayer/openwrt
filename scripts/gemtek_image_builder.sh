#!/bin/sh
#
#   Gemtek Factory Image checksum calculator
#   SPDX-License-Identifier: GPL-2.0-or-later
#
#   This script calculates 16 bytes trailer expected by 
#   Linksys/ Gemtek based router boards factory firmware
#   image. This script is based based on 
#   GPL code released by Linksys for E5600 Wifi router 
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
IMAGE=$1
OUTPUT=$2
MAGIC=".GEMTEK."
CHKSUM=$(cksum $IMAGE | awk '{print $1}')
# 16 bytes
HDR=$(printf "%8s%08X" $MAGIC $CHKSUM)

(cat $IMAGE ; echo -n $HDR) > $OUTPUT
(md5sum $OUTPUT | cut -d' ' -f 1) > ${OUTPUT}.md5
