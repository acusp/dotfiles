#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os

DYNSYM_TYPE = 11


def __damage_section_header_table(obj_file):
    with open(obj_file, 'rb+') as f:
        content = f.read()

        elf_bits = content[4]
        if 2 == elf_bits:
            section_table_in_elf_header = 40
            string_table_in_elf_header = 62
            section_table_element_size = 64
            s_offset_for_string_table = 24
            string_table_item_size = 8
        elif 1 == elf_bits:
            section_table_in_elf_header = 32
            string_table_in_elf_header = 50
            section_table_element_size = 40
            s_offset_for_string_table = 16
            string_table_item_size = 4

        section_header_offset = content[section_table_in_elf_header + 1] * 256 + content[section_table_in_elf_header]
        string_table_index = content[string_table_in_elf_header]
        print("section_header_offset = {0}, string_table_index = {1}".
              format(hex(section_header_offset), string_table_index))

        section_table_element_addr = None
        s_type_offset = section_header_offset + 4
        while True:
            if content[s_type_offset] == DYNSYM_TYPE:
                section_table_element_addr = s_type_offset
                break
            s_type_offset += section_table_element_size

        print("section_table_element_addr = {0}".format(hex(section_table_element_addr)))
        f.seek(section_table_element_addr, os.SEEK_SET)
        f.write(b'\x00' * (section_table_element_size - 4))

        data_offset = section_header_offset + section_table_element_size * string_table_index + s_offset_for_string_table
        data_size = content[data_offset + string_table_item_size + 1] * 256 + content[data_offset + string_table_item_size]
        data_addr = content[data_offset + 1] * 256 + content[data_offset]
        print("data_size = {0}, data_addr = {1}".format(data_size, hex(data_addr)))
        f.seek(data_addr, os.SEEK_SET)
        f.write(b'\x20' * data_size)


if __name__ == "__main__":
    if 2 != len(sys.argv):
        print("Usage: show.py <elf file>")
        sys.exit(1)
    obj_file = sys.argv[1]
    __damage_section_header_table(obj_file)
