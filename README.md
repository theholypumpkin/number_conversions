# Number Conversions

I wanted to get a better understanding of bash. So here are 3 bash scripts which convert between number bases.

`hex.sh` converts a number from decimal or binary into hexadecimal.

`bin.sh` converts a number from decimal or hexadecimal into binary.

`dec.sh` converts a number from binary or hexadecimal into decimal.

`float.sh` converts your fixt point decimal number into the floating point binary representation in memory. It is using the *IEEE 754* Standart to do so. Similar to what [this Website](https://www.h-schmidt.net/FloatConverter/IEEE754.html "IEEE-754 Floating Point Converter") is doing but using bash. It outputs both single presicion (i.e a float) and double presicion (i.e a double).

## Installation

```bash
    git clone https://github.com/theholypumpkin/number_conversions.git
    cd number_conversions
    # link the binary convesion to your applications
    ln <your/current/directory>/bin.sh /home/<your_username>/.local/bin/bin
    # link the hexadecimal convesion to your applications
    ln <your/current/directory>/hex.sh /home/<your_username>/.local/bin/hex
    # link the decimal convesion to your applications folder
    ln <your/current/directory>/dec.sh /home/<your_username>/.local/bin/dec
    # link the decimal convesion to your applications folder
    ln <your/current/directory>/float.sh /home/<your_username>/.local/bin/float
```

## Usage

### bin

convert a decimal number $12345$ into binary

```bash
    bin 12345
    # Input  Binary
    # 12345  0b11000000111001
```

convert a hexadecimal number $0xBEEF$ into binary

```bash
    bin 0xBEEF
    # Input  Binary
    # 0xBEEF 0b1011111011101111
```

convert multiple decimal numbers into binary

```bash
    bin 1 2 3 4
    # Input  Binary
    # 1      0b1
    # 2      0b10
    # 3      0b11
    # 4      0b100
```

convert multiple hexadecimal numbers into binary

```bash
    bin 0x1 0x2 0x3 0x4
    # Input  Binary
    # 0x1    0b1
    # 0x2    0b10
    # 0x3    0b11
    # 0x4    0b100
```

mix decimal and hexadecimal

```bash
    bin 0x1 2 3 4
    # Input  Binary
    # 0x1    0b1
    # 2      0b10
    # 3      0b11
    # 4      0b100
```

### hex

convert a decimal number $12345$ into hexadecimal

```bash
    hex 12345
    # Input  Hexadecimal
    # 12345  0x3039
```

convert a binary number $0b1011111011101111$ into hexadecimal

```bash
    hex 0b1011111011101111
    # Input               Hexadecimal
    # 0b1011111011101111  0xBEEF
```

convert multiple decimal numbers into hexadecimal

```bash
    hex 123 456 789
    # Input  Hexadecimal
    # 123    0x7B
    # 456    0x1C8
    # 789    0x315
```

convert multiple binary numbers into hexadecimal.

```bash
    hex 0b1011111011101111 0b1010
    # Input               Hexadecimal
    # 0b1011111011101111  0xBEEF   
    # 0x1010              0xA             
```

mix decimal and hexadecimal

```bash
    hex 0b1010 123 456
    # Input  Hexadecimal
    # 0b1010 0xA
    # 123    0x7B
    # 456    0x1C8
```

### dec

convert a hexdecimal number $0xBEEF$ into decimal

```bash
    dec 0XBEEF
    # Input   Decimal
    # 0XBEEF  48879
```

convert a binary number $0b1011111011101111$ into decimal

```bash
    dec 0b1011111011101111
    # Input               Decimal
    # 0b1011111011101111  48879
```

convert multiple hexadecimal numbers into decimal

```bash
    dec 0xBEEF 0xDEAD 0xCAFE
    # Input   Decimal
    # 0XBEEF  48879
    # 0XDEAD  57005
    # 0XCAFE  51966
```

convert multiple binary numbers into decimal.

```bash
    dec 0b1011 0b1100 0b1101 0b1110 0b1111
    # Input   Decimal
    # 0b1011  11
    # 0b1110  12
    # 0b1101  13
    # 0b1110  14
    # 0b1111  15
```

mix binary and hexadecimal

```bash
    dec 0b1011 0xBEEF
    # Input   Decimal
    # 0b1011  11
    # 0xBEEF  48879

```

## float

convert mutiple fixed point decimal numbers into floating point numbers.

```bash
    float 85.125 -85.125
    # Input    Fixed Point          Sign  Exponent (Single)  Manissa
    # 85.125   1010101.0010000000   0     10000101           0101010010000000
    # -85.125  -1010101.0010000000  1     10000101           0101010010000000

    # Input    Fixed Point          Sign  Exponent (Double)  Manissa
    # 85.125   1010101.0010000000   0     10000000101        0101010010000000
    # -85.125  -1010101.0010000000  1     10000000101        0101010010000000

```

## won't fix

- false positives in automatic binary detection in `bin` and `hex`<br>
&emsp;When you enter a number which starts with $0B$ and than it is followed exclusivly by $0$ and $1$ like, $0B1001001$ it will be interpreteted as binary, even though it could also be a valid hexadecimal number. To avoid it just leave out the leading $0$ like $B1001001$ and you are fine.
