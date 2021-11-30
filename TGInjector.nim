import os, streams

const mainFile = staticRead "dat.dat"

var
    i, marker, padding, romSize : int64
    c : char
    romFilename : string
    romData : FileStream
    buf : array[1, int8]

var keyPSPIndex = 0
var keyPublicIndex = 0

let keyPSP = [0x22, 0xDE, 0xB3, 0xE5, 0x19, 0x4A, 0xE8, 0x47, 0x95, 0xFD, 0x45, 0xBA, 0xDD, 0x09, 0x6B, 0xF8]
let keyPublic = [0x7A, 0xE4, 0x14, 0x19, 0xE9, 0x2E, 0x5D, 0xB4, 0x03, 0x33, 0xA9, 0x1D, 0x9B, 0x6F, 0x47, 0x05, 0xCE, 0x0B, 0xEB, 0xE4, 0xA0, 0xE7, 0xA6, 0x9B, 0x8C, 0x0E, 0x97, 0x43, 0xD8, 0x65, 0x5F, 0xCE, 0x8E, 0xD9, 0xC3, 0x37, 0x3C, 0xE4, 0x65, 0x52, 0xCC, 0x1A, 0xAA, 0x44, 0x62, 0xFA, 0x6E, 0xC8, 0x10, 0xAA, 0xA5, 0x42, 0x86, 0x57, 0x7E, 0x93, 0x3D, 0x78, 0x8C, 0xDB, 0x96, 0x1A, 0xDB, 0x9E, 0xD3, 0xDA, 0x8F, 0xC2, 0xAB, 0x0F, 0xC9, 0xE9, 0xA5, 0x98, 0x17, 0x86, 0x3D, 0x62, 0x39, 0x92, 0xA0, 0xCE, 0x32, 0x2D, 0xBF, 0x1C, 0x47, 0x36, 0x5A, 0x30, 0xFA, 0xC3, 0x57, 0x8A, 0xBB, 0xB2, 0x3E, 0x0B, 0x70, 0x88, 0x6A, 0xAB, 0x1D, 0x01, 0xE1, 0xBC, 0x9D, 0xEE, 0x3F, 0xF7, 0x56, 0xDA, 0x3F, 0xFA, 0x3A, 0xC8, 0xE7, 0xAE, 0xDF, 0xB6, 0x92, 0x58, 0x67, 0x7B, 0x15, 0x05, 0x91, 0x1A, 0xDC, 0x65, 0x48, 0x31, 0xF2, 0xB0, 0x27, 0xF4, 0xB1, 0x31, 0x4C, 0x03, 0x7F, 0x59, 0xF6, 0x62, 0xDA, 0x1F, 0x83, 0x5D, 0x50, 0xF3, 0xCB, 0x90, 0x2B, 0xB9, 0xF6, 0x11, 0x44, 0xA2, 0xEB, 0xDB, 0x2A, 0x82, 0x11, 0xDA, 0xAF, 0x24, 0xE8, 0x8F, 0xD2, 0x45, 0x17, 0xB6, 0x61, 0xDC, 0x37, 0x38, 0x61, 0x04, 0xA0, 0xF6, 0x82, 0x34, 0xCA, 0xE9, 0x99, 0xB8, 0x06, 0x38, 0xBA, 0x16, 0xB0, 0x0E, 0x45, 0x71, 0xD8, 0xFC, 0x47, 0x1C, 0xB3, 0xB5, 0x36, 0xF4, 0x8A, 0x0A, 0xDB, 0x14, 0x2E, 0x4F, 0x82, 0xBD, 0xAF, 0x3F, 0x01, 0xF5, 0x59, 0xF6, 0xB8, 0x28, 0x40, 0xF7, 0x1E, 0xAF, 0xD4, 0xBC, 0x95, 0x08, 0x70, 0xF0, 0x03, 0x3B, 0xF1, 0x45, 0x51, 0xEA, 0xC0, 0x8D, 0xA9, 0xBF, 0x0D, 0x84, 0x89, 0xB6, 0xB6, 0xFD, 0x66, 0x70, 0x0D, 0x50, 0x18, 0xE2, 0x43, 0x1F, 0xDB, 0xBB, 0x97, 0x86, 0x1F, 0xCE, 0x75, 0xD2, 0xA4, 0x3E, 0x4B, 0x46, 0xCC, 0x6A, 0xEE, 0x16, 0x35, 0xCB, 0x4D, 0xF9, 0x1A, 0xBB, 0x6D, 0x67, 0xF9, 0xD7, 0x55, 0x25, 0xFA, 0x20, 0xD8, 0x21, 0xF7, 0xD2, 0x69, 0x96, 0x53, 0x39, 0x6D, 0xDA, 0x4A, 0x3B, 0xE0, 0x4B, 0x6A, 0x6F, 0x31, 0xFC, 0x82, 0xF7, 0x1B, 0x4C, 0x95, 0x49, 0x04, 0x1F, 0x4D, 0x30, 0x8D, 0x48, 0x78, 0x4F, 0xD7, 0x83, 0x65, 0x2A, 0x4F, 0xFA, 0x00, 0x58, 0xC3, 0xFB, 0x5E, 0x72, 0xAF, 0xDF, 0xDA, 0x21, 0xFD, 0x89, 0xA6, 0x59, 0xA3, 0x03, 0x05, 0x8B, 0x8B, 0xAD, 0xCD, 0x4A, 0x48, 0x23, 0xAC, 0x25, 0x62, 0xFA, 0x63, 0x5D, 0xE5, 0x3F, 0x20, 0x36, 0xFB, 0x29, 0x34, 0x1F, 0xEE, 0x23, 0x9A, 0x25, 0x44, 0x2B, 0x32, 0x03, 0xA2, 0x1E, 0xAC, 0xD4, 0x7E, 0xD9, 0x9E, 0xA1, 0x2C, 0xB6, 0x0F, 0xA0, 0x4F, 0x39, 0x10, 0xB5, 0x7C, 0x7D, 0x3C, 0xBD, 0x69, 0x6F, 0x5E, 0x79, 0xCE, 0xE5, 0x9D, 0x68, 0x13, 0xA8, 0x05, 0x1C, 0xF0, 0xA8, 0x82, 0x43, 0x4D, 0x8E, 0xDF, 0x0B, 0xA0, 0x7E, 0x0A, 0x45, 0x1A, 0x94, 0xD0, 0xB4, 0x12, 0xE5, 0xA8, 0xC7, 0xEF, 0x75, 0x9A, 0x32, 0xC0, 0x33, 0x05, 0x98, 0x3B, 0x35, 0x8E, 0x84, 0xB1, 0xF3, 0xB0, 0xA7, 0xB6, 0xCC, 0x67, 0xED, 0x9E, 0x30, 0x1C, 0xEA, 0x65, 0x19, 0x5E, 0x3A, 0x15, 0xE9, 0x55, 0x2D, 0xFF, 0x3E, 0x2C, 0x7A, 0x0D, 0x50, 0x83, 0x19, 0x89, 0x46, 0xCF, 0x6A, 0xF0, 0x86, 0x93, 0x26, 0xE4, 0x29, 0xFE, 0x46, 0x7E, 0xBB, 0x28, 0xBF, 0x58, 0xB0, 0xCD, 0xA7, 0xD4, 0xCA, 0x83, 0x52, 0xE0, 0x60, 0x84, 0x73, 0xC6, 0x35, 0x99, 0x65, 0x49, 0x4D, 0x64, 0x57, 0x60, 0xB1, 0xF9, 0xDE, 0x85, 0x38, 0x56, 0xEB, 0xEA, 0x0F, 0xAF, 0x44, 0x15, 0x6D, 0x21, 0x5D, 0x82, 0xDB]

echo "TGInjector v1"

if paramCount() == 0:
    echo "Provide a rom file as a command-line parameter, or drag'n'drop it on the executable. \nPress enter to exit ..."
    c = readChar(stdin)
    quit()
else:
    romFilename = paramStr(1)
    echo "Opening rom: ", romFilename
    try:
        romData = openFileStream(romFilename, fmRead)
    except:
        echo "Error opening: ", romFilename, "\nPress enter to exit ..."
        c = readChar(stdin)
        quit()

var f = open("temporary.DAT", fmReadWrite)
f.write(mainFile)
marker = f.getFilePos()
f.write(romData.readAll)
romSize = f.getFilePos() - marker
marker = f.getFilePos()

echo "Rom size is ", romSize, " bytes"
padding = (len(mainFile) + romSize) mod 32
echo "Padding needed is ", padding, " bytes"
f.setFilePos(0xD94)
discard f.writeBuffer(addr(romSize), sizeof(romSize))

f.setFilePos(0)

var final = open("CONTENT.DAT", fmReadWrite)
i = 0
while i < marker:
    keyPSPIndex = keyPSPIndex and 0xF
    keyPublicIndex = keyPublicIndex and 0x1FF

    discard f.readBytes(buf, 0, 1)
    #f.setFilePos(f.getFilePos() - 1)
    buf[0] = cast[int8](keyPSP[keyPSPIndex] xor keyPublic[keyPublicIndex] xor buf[0])
    discard final.writeBuffer(addr(buf[0]), 1) 
    keyPSPIndex = keyPSPIndex + 1
    keyPublicIndex = keyPublicIndex + 1
    i = i + 1

f.close()
removeFile("temporary.DAT")
echo "CONTENT.DAT created, copy it into the /PSP/GAME/NPUF30016 folder, overwriting the existing file \nPress enter to exit ..."
c = readChar(stdin)
quit()
