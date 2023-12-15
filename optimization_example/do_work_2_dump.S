opt_ex.aocloop_do_work_2:
  0000000140009EB0: 41 57              push        r15
  0000000140009EB2: 41 56              push        r14
  0000000140009EB4: 56                 push        rsi
  0000000140009EB5: 57                 push        rdi
  0000000140009EB6: 53                 push        rbx
  0000000140009EB7: 4C 8B 1D 1A 61 03  mov         r11,qword ptr [14003FFD8h]
                    00
  0000000140009EBE: 4D 85 DB           test        r11,r11
  0000000140009EC1: 7E 27              jle         0000000140009EEA
  0000000140009EC3: 4C 8B 0D 36 61 03  mov         r9,qword ptr [140040000h]
                    00
  0000000140009ECA: 45 89 DA           mov         r10d,r11d
  0000000140009ECD: 41 83 E2 07        and         r10d,7
  0000000140009ED1: 49 83 FB 08        cmp         r11,8
  0000000140009ED5: 73 1A              jae         0000000140009EF1
  0000000140009ED7: 45 31 C0           xor         r8d,r8d
  0000000140009EDA: 31 C9              xor         ecx,ecx
  0000000140009EDC: 4D 85 D2           test        r10,r10
  0000000140009EDF: 0F 85 FF 03 00 00  jne         000000014000A2E4
  0000000140009EE5: E9 7D 04 00 00     jmp         000000014000A367
  0000000140009EEA: 31 C9              xor         ecx,ecx
  0000000140009EEC: E9 76 04 00 00     jmp         000000014000A367
  0000000140009EF1: 48 8B 35 D8 60 03  mov         rsi,qword ptr [14003FFD0h]
                    00
  0000000140009EF8: 48 8B 3D E1 60 03  mov         rdi,qword ptr [14003FFE0h]
                    00
  0000000140009EFF: 48 8B 1D EA 60 03  mov         rbx,qword ptr [14003FFF0h]
                    00
  0000000140009F06: 49 83 E3 F8        and         r11,0FFFFFFFFFFFFFFF8h
  0000000140009F0A: 41 B8 07 00 00 00  mov         r8d,7
  0000000140009F10: 31 C9              xor         ecx,ecx
  0000000140009F12: 49 F7 DB           neg         r11
  0000000140009F15: EB 44              jmp         0000000140009F5B
  0000000140009F17: 66 0F 1F 84 00 00  nop         word ptr [rax+rax]
                    00 00 00
  0000000140009F20: 4C 89 C0           mov         rax,r8
  0000000140009F23: 48 99              cqo
  0000000140009F25: 49 F7 F9           idiv        rax,r9
  0000000140009F28: 4C 8B 34 D3        mov         r14,qword ptr [rbx+rdx*8]
  0000000140009F2C: 49 89 D7           mov         r15,rdx
  0000000140009F2F: 4D 0F AF F9        imul        r15,r9
  0000000140009F33: 4D 01 CF           add         r15,r9
  0000000140009F36: 49 F7 D6           not         r14
  0000000140009F39: 4D 01 F7           add         r15,r14
  0000000140009F3C: 42 C6 04 3F 4F     mov         byte ptr [rdi+r15],4Fh
  0000000140009F41: 48 FF 04 D3        inc         qword ptr [rbx+rdx*8]
  0000000140009F45: 48 01 C1           add         rcx,rax
  0000000140009F48: 4B 8D 44 03 08     lea         rax,[r11+r8+8]
  0000000140009F4D: 49 83 C0 08        add         r8,8
  0000000140009F51: 48 83 F8 07        cmp         rax,7
  0000000140009F55: 0F 84 7C 03 00 00  je          000000014000A2D7
  0000000140009F5B: 42 0F B6 54 06 F9  movzx       edx,byte ptr [rsi+r8-7]
  0000000140009F61: 49 8D 40 F9        lea         rax,[r8-7]
  0000000140009F65: 83 FA 23           cmp         edx,23h
  0000000140009F68: 0F 84 B2 01 00 00  je          000000014000A120
  0000000140009F6E: 83 FA 4F           cmp         edx,4Fh
  0000000140009F71: 75 25              jne         0000000140009F98
  0000000140009F73: 48 99              cqo
  0000000140009F75: 49 F7 F9           idiv        rax,r9
  0000000140009F78: 4C 8B 34 D3        mov         r14,qword ptr [rbx+rdx*8]
  0000000140009F7C: 49 89 D7           mov         r15,rdx
  0000000140009F7F: 4D 0F AF F9        imul        r15,r9
  0000000140009F83: 4D 01 CF           add         r15,r9
  0000000140009F86: 49 F7 D6           not         r14
  0000000140009F89: 4D 01 F7           add         r15,r14
  0000000140009F8C: 42 C6 04 3F 4F     mov         byte ptr [rdi+r15],4Fh
  0000000140009F91: 48 FF 04 D3        inc         qword ptr [rbx+rdx*8]
  0000000140009F95: 48 01 C1           add         rcx,rax
  0000000140009F98: 42 0F B6 54 06 FA  movzx       edx,byte ptr [rsi+r8-6]
  0000000140009F9E: 49 8D 40 FA        lea         rax,[r8-6]
  0000000140009FA2: 83 FA 4F           cmp         edx,4Fh
  0000000140009FA5: 0F 84 AC 01 00 00  je          000000014000A157
  0000000140009FAB: 83 FA 23           cmp         edx,23h
  0000000140009FAE: 75 24              jne         0000000140009FD4
  0000000140009FB0: 48 99              cqo
  0000000140009FB2: 49 F7 F9           idiv        rax,r9
  0000000140009FB5: 49 89 D6           mov         r14,rdx
  0000000140009FB8: 4D 0F AF F1        imul        r14,r9
  0000000140009FBC: 4D 01 CE           add         r14,r9
  0000000140009FBF: 49 89 C7           mov         r15,rax
  0000000140009FC2: 49 F7 D7           not         r15
  0000000140009FC5: 48 FF C0           inc         rax
  0000000140009FC8: 4D 01 FE           add         r14,r15
  0000000140009FCB: 42 C6 04 37 23     mov         byte ptr [rdi+r14],23h
  0000000140009FD0: 48 89 04 D3        mov         qword ptr [rbx+rdx*8],rax
  0000000140009FD4: 42 0F B6 54 06 FB  movzx       edx,byte ptr [rsi+r8-5]
  0000000140009FDA: 49 8D 40 FB        lea         rax,[r8-5]
  0000000140009FDE: 83 FA 4F           cmp         edx,4Fh
  0000000140009FE1: 0F 84 A8 01 00 00  je          000000014000A18F
  0000000140009FE7: 83 FA 23           cmp         edx,23h
  0000000140009FEA: 75 24              jne         000000014000A010
  0000000140009FEC: 48 99              cqo
  0000000140009FEE: 49 F7 F9           idiv        rax,r9
  0000000140009FF1: 49 89 D6           mov         r14,rdx
  0000000140009FF4: 4D 0F AF F1        imul        r14,r9
  0000000140009FF8: 4D 01 CE           add         r14,r9
  0000000140009FFB: 49 89 C7           mov         r15,rax
  0000000140009FFE: 49 F7 D7           not         r15
  000000014000A001: 48 FF C0           inc         rax
  000000014000A004: 4D 01 FE           add         r14,r15
  000000014000A007: 42 C6 04 37 23     mov         byte ptr [rdi+r14],23h
  000000014000A00C: 48 89 04 D3        mov         qword ptr [rbx+rdx*8],rax
  000000014000A010: 42 0F B6 54 06 FC  movzx       edx,byte ptr [rsi+r8-4]
  000000014000A016: 49 8D 40 FC        lea         rax,[r8-4]
  000000014000A01A: 83 FA 4F           cmp         edx,4Fh
  000000014000A01D: 0F 84 A4 01 00 00  je          000000014000A1C7
  000000014000A023: 83 FA 23           cmp         edx,23h
  000000014000A026: 75 24              jne         000000014000A04C
  000000014000A028: 48 99              cqo
  000000014000A02A: 49 F7 F9           idiv        rax,r9
  000000014000A02D: 49 89 D6           mov         r14,rdx
  000000014000A030: 4D 0F AF F1        imul        r14,r9
  000000014000A034: 4D 01 CE           add         r14,r9
  000000014000A037: 49 89 C7           mov         r15,rax
  000000014000A03A: 49 F7 D7           not         r15
  000000014000A03D: 48 FF C0           inc         rax
  000000014000A040: 4D 01 FE           add         r14,r15
  000000014000A043: 42 C6 04 37 23     mov         byte ptr [rdi+r14],23h
  000000014000A048: 48 89 04 D3        mov         qword ptr [rbx+rdx*8],rax
  000000014000A04C: 42 0F B6 54 06 FD  movzx       edx,byte ptr [rsi+r8-3]
  000000014000A052: 49 8D 40 FD        lea         rax,[r8-3]
  000000014000A056: 83 FA 4F           cmp         edx,4Fh
  000000014000A059: 0F 84 A0 01 00 00  je          000000014000A1FF
  000000014000A05F: 83 FA 23           cmp         edx,23h
  000000014000A062: 75 24              jne         000000014000A088
  000000014000A064: 48 99              cqo
  000000014000A066: 49 F7 F9           idiv        rax,r9
  000000014000A069: 49 89 D6           mov         r14,rdx
  000000014000A06C: 4D 0F AF F1        imul        r14,r9
  000000014000A070: 4D 01 CE           add         r14,r9
  000000014000A073: 49 89 C7           mov         r15,rax
  000000014000A076: 49 F7 D7           not         r15
  000000014000A079: 48 FF C0           inc         rax
  000000014000A07C: 4D 01 FE           add         r14,r15
  000000014000A07F: 42 C6 04 37 23     mov         byte ptr [rdi+r14],23h
  000000014000A084: 48 89 04 D3        mov         qword ptr [rbx+rdx*8],rax
  000000014000A088: 42 0F B6 54 06 FE  movzx       edx,byte ptr [rsi+r8-2]
  000000014000A08E: 49 8D 40 FE        lea         rax,[r8-2]
  000000014000A092: 83 FA 4F           cmp         edx,4Fh
  000000014000A095: 0F 84 9C 01 00 00  je          000000014000A237
  000000014000A09B: 83 FA 23           cmp         edx,23h
  000000014000A09E: 75 24              jne         000000014000A0C4
  000000014000A0A0: 48 99              cqo
  000000014000A0A2: 49 F7 F9           idiv        rax,r9
  000000014000A0A5: 49 89 D6           mov         r14,rdx
  000000014000A0A8: 4D 0F AF F1        imul        r14,r9
  000000014000A0AC: 4D 01 CE           add         r14,r9
  000000014000A0AF: 49 89 C7           mov         r15,rax
  000000014000A0B2: 49 F7 D7           not         r15
  000000014000A0B5: 48 FF C0           inc         rax
  000000014000A0B8: 4D 01 FE           add         r14,r15
  000000014000A0BB: 42 C6 04 37 23     mov         byte ptr [rdi+r14],23h
  000000014000A0C0: 48 89 04 D3        mov         qword ptr [rbx+rdx*8],rax
  000000014000A0C4: 42 0F B6 54 06 FF  movzx       edx,byte ptr [rsi+r8-1]
  000000014000A0CA: 49 8D 40 FF        lea         rax,[r8-1]
  000000014000A0CE: 83 FA 4F           cmp         edx,4Fh
  000000014000A0D1: 0F 84 98 01 00 00  je          000000014000A26F
  000000014000A0D7: 83 FA 23           cmp         edx,23h
  000000014000A0DA: 75 24              jne         000000014000A100
  000000014000A0DC: 48 99              cqo
  000000014000A0DE: 49 F7 F9           idiv        rax,r9
  000000014000A0E1: 49 89 D6           mov         r14,rdx
  000000014000A0E4: 4D 0F AF F1        imul        r14,r9
  000000014000A0E8: 4D 01 CE           add         r14,r9
  000000014000A0EB: 49 89 C7           mov         r15,rax
  000000014000A0EE: 49 F7 D7           not         r15
  000000014000A0F1: 48 FF C0           inc         rax
  000000014000A0F4: 4D 01 FE           add         r14,r15
  000000014000A0F7: 42 C6 04 37 23     mov         byte ptr [rdi+r14],23h
  000000014000A0FC: 48 89 04 D3        mov         qword ptr [rbx+rdx*8],rax
  000000014000A100: 42 0F B6 04 06     movzx       eax,byte ptr [rsi+r8]
  000000014000A105: 83 F8 4F           cmp         eax,4Fh
  000000014000A108: 0F 85 94 01 00 00  jne         000000014000A2A2
  000000014000A10E: E9 0D FE FF FF     jmp         0000000140009F20
  000000014000A113: 66 66 66 66 2E 0F  nop         word ptr cs:[rax+rax]
                    1F 84 00 00 00 00
                    00
  000000014000A120: 48 99              cqo
  000000014000A122: 49 F7 F9           idiv        rax,r9
  000000014000A125: 49 89 D6           mov         r14,rdx
  000000014000A128: 4D 0F AF F1        imul        r14,r9
  000000014000A12C: 4D 01 CE           add         r14,r9
  000000014000A12F: 49 89 C7           mov         r15,rax
  000000014000A132: 49 F7 D7           not         r15
  000000014000A135: 48 FF C0           inc         rax
  000000014000A138: 4D 01 FE           add         r14,r15
  000000014000A13B: 42 C6 04 37 23     mov         byte ptr [rdi+r14],23h
  000000014000A140: 48 89 04 D3        mov         qword ptr [rbx+rdx*8],rax
  000000014000A144: 42 0F B6 54 06 FA  movzx       edx,byte ptr [rsi+r8-6]
  000000014000A14A: 49 8D 40 FA        lea         rax,[r8-6]
  000000014000A14E: 83 FA 4F           cmp         edx,4Fh
  000000014000A151: 0F 85 54 FE FF FF  jne         0000000140009FAB
  000000014000A157: 48 99              cqo
  000000014000A159: 49 F7 F9           idiv        rax,r9
  000000014000A15C: 4C 8B 34 D3        mov         r14,qword ptr [rbx+rdx*8]
  000000014000A160: 49 89 D7           mov         r15,rdx
  000000014000A163: 4D 0F AF F9        imul        r15,r9
  000000014000A167: 4D 01 CF           add         r15,r9
  000000014000A16A: 49 F7 D6           not         r14
  000000014000A16D: 4D 01 F7           add         r15,r14
  000000014000A170: 42 C6 04 3F 4F     mov         byte ptr [rdi+r15],4Fh
  000000014000A175: 48 FF 04 D3        inc         qword ptr [rbx+rdx*8]
  000000014000A179: 48 01 C1           add         rcx,rax
  000000014000A17C: 42 0F B6 54 06 FB  movzx       edx,byte ptr [rsi+r8-5]
  000000014000A182: 49 8D 40 FB        lea         rax,[r8-5]
  000000014000A186: 83 FA 4F           cmp         edx,4Fh
  000000014000A189: 0F 85 58 FE FF FF  jne         0000000140009FE7
  000000014000A18F: 48 99              cqo
  000000014000A191: 49 F7 F9           idiv        rax,r9
  000000014000A194: 4C 8B 34 D3        mov         r14,qword ptr [rbx+rdx*8]
  000000014000A198: 49 89 D7           mov         r15,rdx
  000000014000A19B: 4D 0F AF F9        imul        r15,r9
  000000014000A19F: 4D 01 CF           add         r15,r9
  000000014000A1A2: 49 F7 D6           not         r14
  000000014000A1A5: 4D 01 F7           add         r15,r14
  000000014000A1A8: 42 C6 04 3F 4F     mov         byte ptr [rdi+r15],4Fh
  000000014000A1AD: 48 FF 04 D3        inc         qword ptr [rbx+rdx*8]
  000000014000A1B1: 48 01 C1           add         rcx,rax
  000000014000A1B4: 42 0F B6 54 06 FC  movzx       edx,byte ptr [rsi+r8-4]
  000000014000A1BA: 49 8D 40 FC        lea         rax,[r8-4]
  000000014000A1BE: 83 FA 4F           cmp         edx,4Fh
  000000014000A1C1: 0F 85 5C FE FF FF  jne         000000014000A023
  000000014000A1C7: 48 99              cqo
  000000014000A1C9: 49 F7 F9           idiv        rax,r9
  000000014000A1CC: 4C 8B 34 D3        mov         r14,qword ptr [rbx+rdx*8]
  000000014000A1D0: 49 89 D7           mov         r15,rdx
  000000014000A1D3: 4D 0F AF F9        imul        r15,r9
  000000014000A1D7: 4D 01 CF           add         r15,r9
  000000014000A1DA: 49 F7 D6           not         r14
  000000014000A1DD: 4D 01 F7           add         r15,r14
  000000014000A1E0: 42 C6 04 3F 4F     mov         byte ptr [rdi+r15],4Fh
  000000014000A1E5: 48 FF 04 D3        inc         qword ptr [rbx+rdx*8]
  000000014000A1E9: 48 01 C1           add         rcx,rax
  000000014000A1EC: 42 0F B6 54 06 FD  movzx       edx,byte ptr [rsi+r8-3]
  000000014000A1F2: 49 8D 40 FD        lea         rax,[r8-3]
  000000014000A1F6: 83 FA 4F           cmp         edx,4Fh
  000000014000A1F9: 0F 85 60 FE FF FF  jne         000000014000A05F
  000000014000A1FF: 48 99              cqo
  000000014000A201: 49 F7 F9           idiv        rax,r9
  000000014000A204: 4C 8B 34 D3        mov         r14,qword ptr [rbx+rdx*8]
  000000014000A208: 49 89 D7           mov         r15,rdx
  000000014000A20B: 4D 0F AF F9        imul        r15,r9
  000000014000A20F: 4D 01 CF           add         r15,r9
  000000014000A212: 49 F7 D6           not         r14
  000000014000A215: 4D 01 F7           add         r15,r14
  000000014000A218: 42 C6 04 3F 4F     mov         byte ptr [rdi+r15],4Fh
  000000014000A21D: 48 FF 04 D3        inc         qword ptr [rbx+rdx*8]
  000000014000A221: 48 01 C1           add         rcx,rax
  000000014000A224: 42 0F B6 54 06 FE  movzx       edx,byte ptr [rsi+r8-2]
  000000014000A22A: 49 8D 40 FE        lea         rax,[r8-2]
  000000014000A22E: 83 FA 4F           cmp         edx,4Fh
  000000014000A231: 0F 85 64 FE FF FF  jne         000000014000A09B
  000000014000A237: 48 99              cqo
  000000014000A239: 49 F7 F9           idiv        rax,r9
  000000014000A23C: 4C 8B 34 D3        mov         r14,qword ptr [rbx+rdx*8]
  000000014000A240: 49 89 D7           mov         r15,rdx
  000000014000A243: 4D 0F AF F9        imul        r15,r9
  000000014000A247: 4D 01 CF           add         r15,r9
  000000014000A24A: 49 F7 D6           not         r14
  000000014000A24D: 4D 01 F7           add         r15,r14
  000000014000A250: 42 C6 04 3F 4F     mov         byte ptr [rdi+r15],4Fh
  000000014000A255: 48 FF 04 D3        inc         qword ptr [rbx+rdx*8]
  000000014000A259: 48 01 C1           add         rcx,rax
  000000014000A25C: 42 0F B6 54 06 FF  movzx       edx,byte ptr [rsi+r8-1]
  000000014000A262: 49 8D 40 FF        lea         rax,[r8-1]
  000000014000A266: 83 FA 4F           cmp         edx,4Fh
  000000014000A269: 0F 85 68 FE FF FF  jne         000000014000A0D7
  000000014000A26F: 48 99              cqo
  000000014000A271: 49 F7 F9           idiv        rax,r9
  000000014000A274: 4C 8B 34 D3        mov         r14,qword ptr [rbx+rdx*8]
  000000014000A278: 49 89 D7           mov         r15,rdx
  000000014000A27B: 4D 0F AF F9        imul        r15,r9
  000000014000A27F: 4D 01 CF           add         r15,r9
  000000014000A282: 49 F7 D6           not         r14
  000000014000A285: 4D 01 F7           add         r15,r14
  000000014000A288: 42 C6 04 3F 4F     mov         byte ptr [rdi+r15],4Fh
  000000014000A28D: 48 FF 04 D3        inc         qword ptr [rbx+rdx*8]
  000000014000A291: 48 01 C1           add         rcx,rax
  000000014000A294: 42 0F B6 04 06     movzx       eax,byte ptr [rsi+r8]
  000000014000A299: 83 F8 4F           cmp         eax,4Fh
  000000014000A29C: 0F 84 7E FC FF FF  je          0000000140009F20
  000000014000A2A2: 83 F8 23           cmp         eax,23h
  000000014000A2A5: 0F 85 9D FC FF FF  jne         0000000140009F48
  000000014000A2AB: 4C 89 C0           mov         rax,r8
  000000014000A2AE: 48 99              cqo
  000000014000A2B0: 49 F7 F9           idiv        rax,r9
  000000014000A2B3: 49 89 D6           mov         r14,rdx
  000000014000A2B6: 4D 0F AF F1        imul        r14,r9
  000000014000A2BA: 4D 01 CE           add         r14,r9
  000000014000A2BD: 49 89 C7           mov         r15,rax
  000000014000A2C0: 49 F7 D7           not         r15
  000000014000A2C3: 48 FF C0           inc         rax
  000000014000A2C6: 4D 01 FE           add         r14,r15
  000000014000A2C9: 42 C6 04 37 23     mov         byte ptr [rdi+r14],23h
  000000014000A2CE: 48 89 04 D3        mov         qword ptr [rbx+rdx*8],rax
  000000014000A2D2: E9 71 FC FF FF     jmp         0000000140009F48
  000000014000A2D7: 49 83 C0 F9        add         r8,0FFFFFFFFFFFFFFF9h
  000000014000A2DB: 4D 85 D2           test        r10,r10
  000000014000A2DE: 0F 84 83 00 00 00  je          000000014000A367
  000000014000A2E4: 4C 8B 1D E5 5C 03  mov         r11,qword ptr [14003FFD0h]
                    00
  000000014000A2EB: 48 8B 35 EE 5C 03  mov         rsi,qword ptr [14003FFE0h]
                    00
  000000014000A2F2: 48 8B 3D F7 5C 03  mov         rdi,qword ptr [14003FFF0h]
                    00
  000000014000A2F9: EB 35              jmp         000000014000A330
  000000014000A2FB: 0F 1F 44 00 00     nop         dword ptr [rax+rax]
  000000014000A300: 4C 89 C0           mov         rax,r8
  000000014000A303: 48 99              cqo
  000000014000A305: 49 F7 F9           idiv        rax,r9
  000000014000A308: 48 8B 1C D7        mov         rbx,qword ptr [rdi+rdx*8]
  000000014000A30C: 49 89 D6           mov         r14,rdx
  000000014000A30F: 4D 0F AF F1        imul        r14,r9
  000000014000A313: 4D 01 CE           add         r14,r9
  000000014000A316: 48 F7 D3           not         rbx
  000000014000A319: 49 01 DE           add         r14,rbx
  000000014000A31C: 42 C6 04 36 4F     mov         byte ptr [rsi+r14],4Fh
  000000014000A321: 48 FF 04 D7        inc         qword ptr [rdi+rdx*8]
  000000014000A325: 48 01 C1           add         rcx,rax
  000000014000A328: 49 FF C0           inc         r8
  000000014000A32B: 49 FF CA           dec         r10
  000000014000A32E: 74 37              je          000000014000A367
  000000014000A330: 43 0F B6 04 03     movzx       eax,byte ptr [r11+r8]
  000000014000A335: 83 F8 4F           cmp         eax,4Fh
  000000014000A338: 74 C6              je          000000014000A300
  000000014000A33A: 83 F8 23           cmp         eax,23h
  000000014000A33D: 75 E9              jne         000000014000A328
  000000014000A33F: 4C 89 C0           mov         rax,r8
  000000014000A342: 48 99              cqo
  000000014000A344: 49 F7 F9           idiv        rax,r9
  000000014000A347: 48 89 D3           mov         rbx,rdx
  000000014000A34A: 49 0F AF D9        imul        rbx,r9
  000000014000A34E: 4C 01 CB           add         rbx,r9
  000000014000A351: 49 89 C6           mov         r14,rax
  000000014000A354: 49 F7 D6           not         r14
  000000014000A357: 48 FF C0           inc         rax
  000000014000A35A: 4C 01 F3           add         rbx,r14
  000000014000A35D: C6 04 1E 23        mov         byte ptr [rsi+rbx],23h
  000000014000A361: 48 89 04 D7        mov         qword ptr [rdi+rdx*8],rax
  000000014000A365: EB C1              jmp         000000014000A328
  000000014000A367: 48 89 C8           mov         rax,rcx
  000000014000A36A: 5B                 pop         rbx
  000000014000A36B: 5F                 pop         rdi
  000000014000A36C: 5E                 pop         rsi
  000000014000A36D: 41 5E              pop         r14
  000000014000A36F: 41 5F              pop         r15
  000000014000A371: C3                 ret
  000000014000A372: 66 66 66 66 66 2E  nop         word ptr cs:[rax+rax]
                    0F 1F 84 00 00 00
                    00 00