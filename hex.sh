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

# =================================================================================================
concat_as_binary(){
    local output=$(echo "$1:0x$({ echo 'obase=16'; echo 'ibase=2'; echo $2; } | bc)\n")
    table="${table}${output}" # concat conversion to table
}

# =================================================================================================
table="Input:Hexadecimal\n"

for number in "$@"
do
    # replace all lower case letters with upper case so bc doesn't complain
    number_upper=$(echo $number | tr "a-z" "A-Z")
    
	# get prefix by cutting the first to character of
	prefix=$(echo $number_upper | cut -c1-2);

	# if a 0b prefix exists, check if binay
	if [ $prefix = '0B' ]; then
		number_no_prefix=$(echo $number_upper | cut -c3-);

        # check if it is acctually a binary number using regex.
        if [[ $number_no_prefix =~ ^[01]+$ ]]; then
            # if it is true binary concat
            concat_as_binary $number $number_no_prefix
        else
            # else show error in output
            output=$(echo "$number:Not Binary!\n")
            table="${table}${output}" # concat conversion to table
        fi
	# -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
	# else interpret as decimal
	else
		output=$(echo "$number:0x$({ echo 'obase=16'; echo 'ibase=10'; echo $number_upper; } | bc)\n")
        table="${table}${output}" # concat conversion to table
	fi

done

# print the table
echo -e "$table" | column -t -s ':'
# =================================================================================================
# end of file
