# -*- coding:utf-8 -*-

ECODE = {'A': '.-',     'B': '-...',   'C': '-.-.',
        'D': '-..',    'E': '.',      'F': '..-.',
        'G': '--.',    'H': '....',   'I': '..',
        'J': '.---',   'K': '-.-',    'L': '.-..',
        'M': '--',     'N': '-.',     'O': '---',
        'P': '.--.',   'Q': '--.-',   'R': '.-.',
        'S': '...',    'T': '-',      'U': '..-',
        'V': '...-',   'W': '.--',    'X': '-..-',
        'Y': '-.--',   'Z': '--..',

        '0': '-----',  '1': '.----',  '2': '..---',
        '3': '...--',  '4': '....-',  '5': '.....',
        '6': '-....',  '7': '--...',  '8': '---..',
        '9': '----.'
        }

DCODE = {'.-'	: 'A',  '-...'	: 'B',  '-.-.'	: 'C',
        '-..'	: 'D',  '.'		: 'E',  '..-.'	: 'F',
        '--.'	: 'G',  '....'	: 'H',  '..'	: 'I',
        '.---'	: 'J',  '-.-'	: 'K',  '.-..'	: 'L',
        '--'	: 'M',  '-.'	: 'N',  '---'	: 'O',
        '.--.'	: 'P',  '--.-'	: 'Q',  '.-.'	: 'R',
        '...'	: 'S',  '-'		: 'T',  '..-'	: 'U',
        '...-'	: 'V',  '.--'	: 'W',  '-..-'	: 'X',
        '-.--'	: 'Y',  '--..'	: 'Z',

        '-----'	: '0',  '.----'	: '1',  '..---'	: '2',
        '...--'	: '3',  '....-'	: '4',  '.....'	: '5',
        '-....'	: '6',  '--...'	: '7',  '---..'	: '8',
        '----.'	: '9'
        }

def encode():
    msg = raw_input('PLAIN TEXT: ')
    for char in msg:
        if char == ' ':
            print ' ',
        else:
            print ECODE[char.upper()] + ' ',
    print

def decode():
    msg = raw_input('CIPHER TEXT: ')
    morses = msg.split(' ')
    str = ''
    for i in morses:
        str = str + DCODE[i]
    print str

if __name__ == "__main__":
    encode()
    decode()
