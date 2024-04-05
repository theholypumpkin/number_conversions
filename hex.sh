#!/bin/bash

# file hex.sh

# Copyright (C) 2024 <theholypumpkin>

# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
# associated documentation files (the “Software”), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge, publish, distribute,
# sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all copies or
# substantial portions of the Software.

# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
# NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
# DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# ==================================================================================================
# yes that is all.
for number in "$@"
do
    # replace all lower case letters with upper case so bc doesn't complain
    number_upper=$(echo $number | tr "a-z" "A-Z")
    
	# get prefix by cutting the first to character of
	prefix=$(echo $number | cut -c1-2);

	# if a 0b prefix exists, check if binay
	if [ $prefix = '0b' ] || [ $prefix = '0B' ]; then
		number_no_prefix=$(echo $number | cut -c3-);
		echo "$number = 0x$({ echo 'obase=16'; echo 'ibase=2'; echo $number_no_prefix; } | bc)"
	# -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
	# else interpret as decimal
	else
		echo "$number = 0x$({ echo 'obase=16'; echo 'ibase=10'; echo $number; } | bc)"
	fi

done
# ==================================================================================================
