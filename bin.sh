#!/bin/bash

# file bin.sh

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

# =================================================================================================
table="Input:Binary:Two Complement\n"

for number in "$@"
do
    [[ $number -lt "0" ]] && negative=true || negative=false;
    # replace all lower case letters with upper case so bc doesn't complain
    number_upper=$(echo $number | tr "a-z" "A-Z")

	# get prefix by cutting the first to character of
	prefix=$(echo $number_upper | cut -c1-2);

	# if a 0b prefix exists, check if hexadecimal
	if [ $prefix = '0X' ]; then
		number_no_prefix=$(echo $number_upper | cut -c3-);
		output=$(echo "$number:0b$({ echo 'obase=2'; echo 'ibase=F+1'; echo $number_no_prefix; } | bc)\n")
        table="${table}${output}" # concat conversion to table
	# -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
	# else interpret as decimal
	else
        # check if negative number
        if $negative; then
            # make positve
            result=$(bc -l <<< "obase=2; ibase=A; $number*-1")
            # flip the bits
            invert=$(echo $result | tr "01" "10")
            # make twos complement
            invert=$(bc -l <<< "obase=2; ibase=2; $invert+1")
            # concat
            output=:-0b${result}:0b${invert}
        else
            output=":0b$(bc -l <<< "obase=2; ibase=A; $number")"
        fi
		# concat to table
        table="${table}${number}${output}\n" # concat conversion to table
	fi

done

# print the table
echo -e "$table" | column -t -s ':'

# =================================================================================================
# end of file
