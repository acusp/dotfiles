#!/usr/bin/env python3
# -*- coding: utf-8 -*-
'''
#=============================================================================
#     FileName: crypt.py
#         Desc: encrypt/decrypt methods collection.
#       Author: acusp
#        Email: acusp.xu@gmail.com
#   LastChange: 2017-10-02 18:23:57
#=============================================================================
'''
import hashlib
from Crypto import Random
from Crypto.Cipher import AES


'''
Thanks to
http://stackoverflow.com/questions/12524994/encrypt-decrypt-using-pycrypto-aes-256
'''
class AESCipher:
    def __init__(self, key):
        self.bs = 32	# Block size
        self.key = hashlib.sha256(key.encode()).digest()	# 32 bit digest

    # raw must be bytes
    def encrypt(self, raw):
        raw = self._pad(raw)
        iv = Random.new().read(AES.block_size)
        cipher = AES.new(self.key, AES.MODE_CBC, iv)
        return iv + cipher.encrypt(raw)

    # enc must be bytes
    def decrypt(self, enc):
        iv = enc[:AES.block_size]
        cipher = AES.new(self.key, AES.MODE_CBC, iv)
        return self._unpad(cipher.decrypt(enc[AES.block_size:]))

    def _pad(self, s):
        pad = (self.bs - len(s) % self.bs) * chr(self.bs - len(s) % self.bs)
        return s + pad.encode()

    @staticmethod
    def _unpad(s):
        return s[:-ord(s[len(s)-1:])]

if __name__ == '__main__':
    # encrypt
    pc = AESCipher('123456')
    aes_encrypt = pc.encrypt(b"flag{acusp}\n")

    # decrypt
    pc1 = AESCipher('123456')
    aes_decrypt = pc1.decrypt(aes_encrypt)

    print(aes_encrypt, aes_decrypt)
