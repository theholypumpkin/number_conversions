#!/bin/bash

# file float.sh

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
sign_bit() { 
    echo $(( $1 > 0 ? 0 : 1 )) # return the absolut value 
}

# =================================================================================================
# input=$1
single_tab="Input:Fixed Point:Sign:Exponent (Single):Manissa\n"
double_tab="Input:Fixed Point:Sign:Exponent (Double):Manissa\n"

# _________________________________________________________________________________________________
for input in "$@"
do
    #input=-85.125

    sign=$(sign_bit $(echo $input | cut -d . -f 1))
    
    if [[ $sign -eq 0 ]]; then
        # calculate normally convert input decimal into binary
        fixed_point=$(bc -l <<< "obase=2; ibase=10; $input") 
    else
        # multiply by -1 to get a positve number than add back the minus sign
        fixed_point=$(bc -l <<< "obase=2; ibase=10; $input*-1")
    fi 
    # -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
    # get whole number binary and decimal as binary
    number=$(echo $fixed_point | cut -d . -f 1)
    decimal=$(echo $fixed_point | cut -d . -f 2 | cut -d '\' -f 1)
    # -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
    # get the single and double presicion exponent.
    exponent_single=$(bc -l <<<"obase=2; ibase=10; $((${#number}-1))+127")
    exponent_double=$(bc -l <<<"obase=2; ibase=10; $((${#number}-1))+1023")
    # -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
    # figure out where to cut the string basied of we have a minus sign or not.
    sign=$(sign_bit $(echo $input | cut -d . -f 1))
    [[ $sign -eq 1 ]] && fixed_point="-${fixed_point}"
    # -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
    # add result to tables
    single_tab="${single_tab}${input}:${fixed_point}:${sign}:${exponent_single}:${number:1}${decimal}\n"
    double_tab="${double_tab}${input}:${fixed_point}:${sign}:${exponent_double}:${number:1}${decimal}\n"
    # -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
done

echo -e "$single_tab" | column -t -s ':'
echo -e "" # empty line
echo -e "$double_tab" | column -t -s ':'
echo -e "" # empty line

# =================================================================================================
# end of file
