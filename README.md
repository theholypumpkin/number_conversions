# Number Conversions

I wanted to get a better understanding of bash. So here are 3 bash scripts which convert between number bases.

`hex.sh` converts a number from decimal or binary into hexadecimal.

`bin.sh` converts a number from decimal or hexadecimal into binary.

`dec.sh` converts a number from binary or hexadecimal into decimal.

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
```

## Usage

```bash
    # convert decimal number 12345 into binary
    bin 12345
    # 12345 = 0b11000000111001
```

```bash
    # convert hexadecimal number 0xBEEF into binary
    bin 0xBEEF
    # 0xBEEF = 0b1011111011101111
```

## known issues

- bin and hex do not support any lower case letters<br>
&emsp;`bin 0xabc` won't work, but `bin 0xABC` will.

- mixing of multiple bases in `bin` and `hex` return wrong result

    ```bash
        bin 123 567 0x237 1
        # 123 = 0b1111011       # thats ok
        # 567 = 0b1000110111    # thats ok
        # 0X237 = 0b11          # wrong
        # 1 = 0b1               # thats ok
    ```

## won't fix

- false positives in automatic binary detection in `bin` and `hex`<br>
&emsp;When you enter a number which starts with $0B$ and than it is followed exclusivly by $0$ and $1$ like, $0B1001001$ it will be interpreteted as binary, even though it could also be a valid hexadecimal number. To avoid it just leave out the leading $0$ like $B1001001$ and you are fine.

