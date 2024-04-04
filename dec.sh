#!/bin/bash

# file: dec.sh

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
# cuts of the prefix and than prints the hexadecimal number as a  decimal number
hex_to_dec(){
	# cut of indentifier prefix
	local number_no_prefix=$(echo $1 | cut -c3-);

	# print the numbers as decimal
	echo "$1 = $((16#$number_no_prefix))";
}

# --------------------------------------------------------------------------------------------------
# onliner to print the binary number as decimal. $1 is the number with its 0b prefix and $2 is the
# number without it 0b prefix.
bin_to_dec(){ echo "$1 = $((2#$2))"; }

# --------------------------------------------------------------------------------------------------
# checks if the passed parameter is equal to a regex only allowing binary. It this is the case
# interpret the number as binary and print the matching decimal number.
# There is the chance for a false positve. If we intend to convert a hexadecimal number which start
# with the digits 0b and than an abritrary amounth of 0 and 1 follow. It will be considert as binary
# and not hexadecimal. any other hexadezimal number starting with 0b is still considered hexadezimal
# and therfore is converted correctly.
check_binary(){
	# cut of identifing prefix
	local number_no_prefix=$(echo $1 | cut -c3-);
	# echo $number_no_prefix

	# check with regex if it is binary. Then print it as decimal. If not binary interpret as
	# hexadecimal.
	[[ $number_no_prefix =~ ^[01]+$ ]] && bin_to_dec $1 $number_no_prefix || hex_to_dec $1
}

# ==================================================================================================
# main entrypoint
# for each passed parameter try convertig it from bin or hex to dec.
for number in "$@"
do
	# get prefix by cutting the first to character of
	prefix=$(echo $number | cut -c1-2);

	# -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
	# if a0x prefix exists, print as hex
	if [ $prefix = '0x' ] || [ $prefix = '0X' ]; then
		 hex_to_dec $number
	# -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
	# if a 0b prefix exists, check if binay
	elif [ $prefix = '0b' ] || [ $prefix = '0B' ]; then
		check_binary $number
	# -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
	# else interpret as hexadecimal
	else
		hex_to_dec "0x$number"
	fi
done

# =================================================================================================
# end of file
