opt_ex.aocloop_do_work_1:
  0000000140009A90: 41 57              push        r15
  0000000140009A92: 41 56              push        r14
  0000000140009A94: 41 54              push        r12
  0000000140009A96: 56                 push        rsi
  0000000140009A97: 57                 push        rdi
  0000000140009A98: 55                 push        rbp
  0000000140009A99: 53                 push        rbx
  0000000140009A9A: 48 8B 35 37 65 03  mov         rsi,qword ptr [14003FFD8h]
                    00
  0000000140009AA1: 48 85 F6           test        rsi,rsi
  0000000140009AA4: 7E 27              jle         0000000140009ACD
  0000000140009AA6: 4C 8B 15 53 65 03  mov         r10,qword ptr [140040000h]
                    00
  0000000140009AAD: 41 89 F3           mov         r11d,esi
  0000000140009AB0: 41 83 E3 07        and         r11d,7
  0000000140009AB4: 48 83 FE 08        cmp         rsi,8
  0000000140009AB8: 73 1A              jae         0000000140009AD4
  0000000140009ABA: 45 31 C0           xor         r8d,r8d
  0000000140009ABD: 31 C9              xor         ecx,ecx
  0000000140009ABF: 4D 85 DB           test        r11,r11
  0000000140009AC2: 0F 85 58 03 00 00  jne         0000000140009E20
  0000000140009AC8: E9 D2 03 00 00     jmp         0000000140009E9F
  0000000140009ACD: 31 C9              xor         ecx,ecx
  0000000140009ACF: E9 CB 03 00 00     jmp         0000000140009E9F
  0000000140009AD4: 48 8B 3D F5 64 03  mov         rdi,qword ptr [14003FFD0h]
                    00
  0000000140009ADB: 48 8B 1D FE 64 03  mov         rbx,qword ptr [14003FFE0h]
                    00
  0000000140009AE2: 4C 8B 35 07 65 03  mov         r14,qword ptr [14003FFF0h]
                    00
  0000000140009AE9: 48 83 E6 F8        and         rsi,0FFFFFFFFFFFFFFF8h
  0000000140009AED: 45 31 C9           xor         r9d,r9d
  0000000140009AF0: 31 C9              xor         ecx,ecx
  0000000140009AF2: EB 38              jmp         0000000140009B2C
  0000000140009AF4: 66 66 66 2E 0F 1F  nop         word ptr cs:[rax+rax]
                    84 00 00 00 00 00
  0000000140009B00: 4D 8B 3C D6        mov         r15,qword ptr [r14+rdx*8]
  0000000140009B04: 49 89 D4           mov         r12,rdx
  0000000140009B07: 49 FF C4           inc         r12
  0000000140009B0A: 48 01 C1           add         rcx,rax
  0000000140009B0D: 4D 0F AF E2        imul        r12,r10
  0000000140009B11: 49 F7 D7           not         r15
  0000000140009B14: 4D 01 FC           add         r12,r15
  0000000140009B17: 42 C6 04 23 4F     mov         byte ptr [rbx+r12],4Fh
  0000000140009B1C: 49 FF 04 D6        inc         qword ptr [r14+rdx*8]
  0000000140009B20: 49 FF C1           inc         r9
  0000000140009B23: 49 39 F1           cmp         r9,rsi
  0000000140009B26: 0F 84 EB 02 00 00  je          0000000140009E17
  0000000140009B2C: 4D 89 C8           mov         r8,r9
  0000000140009B2F: 4C 89 C0           mov         rax,r8
  0000000140009B32: 48 99              cqo
  0000000140009B34: 46 0F B6 0C 0F     movzx       r9d,byte ptr [rdi+r9]
  0000000140009B39: 49 F7 FA           idiv        rax,r10
  0000000140009B3C: 41 83 F9 23        cmp         r9d,23h
  0000000140009B40: 74 2E              je          0000000140009B70
  0000000140009B42: 41 83 F9 4F        cmp         r9d,4Fh
  0000000140009B46: 75 47              jne         0000000140009B8F
  0000000140009B48: 4D 8B 0C D6        mov         r9,qword ptr [r14+rdx*8]
  0000000140009B4C: 49 89 D7           mov         r15,rdx
  0000000140009B4F: 49 FF C7           inc         r15
  0000000140009B52: 48 01 C1           add         rcx,rax
  0000000140009B55: 4D 0F AF FA        imul        r15,r10
  0000000140009B59: 49 F7 D1           not         r9
  0000000140009B5C: 4D 01 CF           add         r15,r9
  0000000140009B5F: 42 C6 04 3B 4F     mov         byte ptr [rbx+r15],4Fh
  0000000140009B64: 49 FF 04 D6        inc         qword ptr [r14+rdx*8]
  0000000140009B68: EB 25              jmp         0000000140009B8F
  0000000140009B6A: 66 0F 1F 44 00 00  nop         word ptr [rax+rax]
  0000000140009B70: 49 89 D1           mov         r9,rdx
  0000000140009B73: 4D 0F AF CA        imul        r9,r10
  0000000140009B77: 49 89 C7           mov         r15,rax
  0000000140009B7A: 49 F7 D7           not         r15
  0000000140009B7D: 48 FF C0           inc         rax
  0000000140009B80: 4D 01 D1           add         r9,r10
  0000000140009B83: 4D 01 F9           add         r9,r15
  0000000140009B86: 42 C6 04 0B 23     mov         byte ptr [rbx+r9],23h
  0000000140009B8B: 49 89 04 D6        mov         qword ptr [r14+rdx*8],rax
  0000000140009B8F: 4D 8D 48 01        lea         r9,[r8+1]
  0000000140009B93: 42 0F B6 6C 07 01  movzx       ebp,byte ptr [rdi+r8+1]
  0000000140009B99: 4C 89 C8           mov         rax,r9
  0000000140009B9C: 48 99              cqo
  0000000140009B9E: 49 F7 FA           idiv        rax,r10
  0000000140009BA1: 83 FD 4F           cmp         ebp,4Fh
  0000000140009BA4: 74 2A              je          0000000140009BD0
  0000000140009BA6: 83 FD 23           cmp         ebp,23h
  0000000140009BA9: 75 45              jne         0000000140009BF0
  0000000140009BAB: 49 89 D7           mov         r15,rdx
  0000000140009BAE: 4D 0F AF FA        imul        r15,r10
  0000000140009BB2: 49 89 C4           mov         r12,rax
  0000000140009BB5: 49 F7 D4           not         r12
  0000000140009BB8: 48 FF C0           inc         rax
  0000000140009BBB: 4D 01 D7           add         r15,r10
  0000000140009BBE: 4D 01 E7           add         r15,r12
  0000000140009BC1: 42 C6 04 3B 23     mov         byte ptr [rbx+r15],23h
  0000000140009BC6: 49 89 04 D6        mov         qword ptr [r14+rdx*8],rax
  0000000140009BCA: EB 24              jmp         0000000140009BF0
  0000000140009BCC: 0F 1F 40 00        nop         dword ptr [rax]
  0000000140009BD0: 4D 8B 3C D6        mov         r15,qword ptr [r14+rdx*8]
  0000000140009BD4: 49 89 D4           mov         r12,rdx
  0000000140009BD7: 49 FF C4           inc         r12
  0000000140009BDA: 48 01 C1           add         rcx,rax
  0000000140009BDD: 4D 0F AF E2        imul        r12,r10
  0000000140009BE1: 49 F7 D7           not         r15
  0000000140009BE4: 4D 01 FC           add         r12,r15
  0000000140009BE7: 42 C6 04 23 4F     mov         byte ptr [rbx+r12],4Fh
  0000000140009BEC: 49 FF 04 D6        inc         qword ptr [r14+rdx*8]
  0000000140009BF0: 49 FF C1           inc         r9
  0000000140009BF3: 42 0F B6 6C 07 02  movzx       ebp,byte ptr [rdi+r8+2]
  0000000140009BF9: 4C 89 C8           mov         rax,r9
  0000000140009BFC: 48 99              cqo
  0000000140009BFE: 49 F7 FA           idiv        rax,r10
  0000000140009C01: 83 FD 4F           cmp         ebp,4Fh
  0000000140009C04: 74 2A              je          0000000140009C30
  0000000140009C06: 83 FD 23           cmp         ebp,23h
  0000000140009C09: 75 45              jne         0000000140009C50
  0000000140009C0B: 49 89 D7           mov         r15,rdx
  0000000140009C0E: 4D 0F AF FA        imul        r15,r10
  0000000140009C12: 49 89 C4           mov         r12,rax
  0000000140009C15: 49 F7 D4           not         r12
  0000000140009C18: 48 FF C0           inc         rax
  0000000140009C1B: 4D 01 D7           add         r15,r10
  0000000140009C1E: 4D 01 E7           add         r15,r12
  0000000140009C21: 42 C6 04 3B 23     mov         byte ptr [rbx+r15],23h
  0000000140009C26: 49 89 04 D6        mov         qword ptr [r14+rdx*8],rax
  0000000140009C2A: EB 24              jmp         0000000140009C50
  0000000140009C2C: 0F 1F 40 00        nop         dword ptr [rax]
  0000000140009C30: 4D 8B 3C D6        mov         r15,qword ptr [r14+rdx*8]
  0000000140009C34: 49 89 D4           mov         r12,rdx
  0000000140009C37: 49 FF C4           inc         r12
  0000000140009C3A: 48 01 C1           add         rcx,rax
  0000000140009C3D: 4D 0F AF E2        imul        r12,r10
  0000000140009C41: 49 F7 D7           not         r15
  0000000140009C44: 4D 01 FC           add         r12,r15
  0000000140009C47: 42 C6 04 23 4F     mov         byte ptr [rbx+r12],4Fh
  0000000140009C4C: 49 FF 04 D6        inc         qword ptr [r14+rdx*8]
  0000000140009C50: 49 FF C1           inc         r9
  0000000140009C53: 42 0F B6 6C 07 03  movzx       ebp,byte ptr [rdi+r8+3]
  0000000140009C59: 4C 89 C8           mov         rax,r9
  0000000140009C5C: 48 99              cqo
  0000000140009C5E: 49 F7 FA           idiv        rax,r10
  0000000140009C61: 83 FD 4F           cmp         ebp,4Fh
  0000000140009C64: 74 2A              je          0000000140009C90
  0000000140009C66: 83 FD 23           cmp         ebp,23h
  0000000140009C69: 75 45              jne         0000000140009CB0
  0000000140009C6B: 49 89 D7           mov         r15,rdx
  0000000140009C6E: 4D 0F AF FA        imul        r15,r10
  0000000140009C72: 49 89 C4           mov         r12,rax
  0000000140009C75: 49 F7 D4           not         r12
  0000000140009C78: 48 FF C0           inc         rax
  0000000140009C7B: 4D 01 D7           add         r15,r10
  0000000140009C7E: 4D 01 E7           add         r15,r12
  0000000140009C81: 42 C6 04 3B 23     mov         byte ptr [rbx+r15],23h
  0000000140009C86: 49 89 04 D6        mov         qword ptr [r14+rdx*8],rax
  0000000140009C8A: EB 24              jmp         0000000140009CB0
  0000000140009C8C: 0F 1F 40 00        nop         dword ptr [rax]
  0000000140009C90: 4D 8B 3C D6        mov         r15,qword ptr [r14+rdx*8]
  0000000140009C94: 49 89 D4           mov         r12,rdx
  0000000140009C97: 49 FF C4           inc         r12
  0000000140009C9A: 48 01 C1           add         rcx,rax
  0000000140009C9D: 4D 0F AF E2        imul        r12,r10
  0000000140009CA1: 49 F7 D7           not         r15
  0000000140009CA4: 4D 01 FC           add         r12,r15
  0000000140009CA7: 42 C6 04 23 4F     mov         byte ptr [rbx+r12],4Fh
  0000000140009CAC: 49 FF 04 D6        inc         qword ptr [r14+rdx*8]
  0000000140009CB0: 49 FF C1           inc         r9
  0000000140009CB3: 42 0F B6 6C 07 04  movzx       ebp,byte ptr [rdi+r8+4]
  0000000140009CB9: 4C 89 C8           mov         rax,r9
  0000000140009CBC: 48 99              cqo
  0000000140009CBE: 49 F7 FA           idiv        rax,r10
  0000000140009CC1: 83 FD 4F           cmp         ebp,4Fh
  0000000140009CC4: 74 2A              je          0000000140009CF0
  0000000140009CC6: 83 FD 23           cmp         ebp,23h
  0000000140009CC9: 75 45              jne         0000000140009D10
  0000000140009CCB: 49 89 D7           mov         r15,rdx
  0000000140009CCE: 4D 0F AF FA        imul        r15,r10
  0000000140009CD2: 49 89 C4           mov         r12,rax
  0000000140009CD5: 49 F7 D4           not         r12
  0000000140009CD8: 48 FF C0           inc         rax
  0000000140009CDB: 4D 01 D7           add         r15,r10
  0000000140009CDE: 4D 01 E7           add         r15,r12
  0000000140009CE1: 42 C6 04 3B 23     mov         byte ptr [rbx+r15],23h
  0000000140009CE6: 49 89 04 D6        mov         qword ptr [r14+rdx*8],rax
  0000000140009CEA: EB 24              jmp         0000000140009D10
  0000000140009CEC: 0F 1F 40 00        nop         dword ptr [rax]
  0000000140009CF0: 4D 8B 3C D6        mov         r15,qword ptr [r14+rdx*8]
  0000000140009CF4: 49 89 D4           mov         r12,rdx
  0000000140009CF7: 49 FF C4           inc         r12
  0000000140009CFA: 48 01 C1           add         rcx,rax
  0000000140009CFD: 4D 0F AF E2        imul        r12,r10
  0000000140009D01: 49 F7 D7           not         r15
  0000000140009D04: 4D 01 FC           add         r12,r15
  0000000140009D07: 42 C6 04 23 4F     mov         byte ptr [rbx+r12],4Fh
  0000000140009D0C: 49 FF 04 D6        inc         qword ptr [r14+rdx*8]
  0000000140009D10: 49 FF C1           inc         r9
  0000000140009D13: 42 0F B6 6C 07 05  movzx       ebp,byte ptr [rdi+r8+5]
  0000000140009D19: 4C 89 C8           mov         rax,r9
  0000000140009D1C: 48 99              cqo
  0000000140009D1E: 49 F7 FA           idiv        rax,r10
  0000000140009D21: 83 FD 4F           cmp         ebp,4Fh
  0000000140009D24: 74 2A              je          0000000140009D50
  0000000140009D26: 83 FD 23           cmp         ebp,23h
  0000000140009D29: 75 45              jne         0000000140009D70
  0000000140009D2B: 49 89 D7           mov         r15,rdx
  0000000140009D2E: 4D 0F AF FA        imul        r15,r10
  0000000140009D32: 49 89 C4           mov         r12,rax
  0000000140009D35: 49 F7 D4           not         r12
  0000000140009D38: 48 FF C0           inc         rax
  0000000140009D3B: 4D 01 D7           add         r15,r10
  0000000140009D3E: 4D 01 E7           add         r15,r12
  0000000140009D41: 42 C6 04 3B 23     mov         byte ptr [rbx+r15],23h
  0000000140009D46: 49 89 04 D6        mov         qword ptr [r14+rdx*8],rax
  0000000140009D4A: EB 24              jmp         0000000140009D70
  0000000140009D4C: 0F 1F 40 00        nop         dword ptr [rax]
  0000000140009D50: 4D 8B 3C D6        mov         r15,qword ptr [r14+rdx*8]
  0000000140009D54: 49 89 D4           mov         r12,rdx
  0000000140009D57: 49 FF C4           inc         r12
  0000000140009D5A: 48 01 C1           add         rcx,rax
  0000000140009D5D: 4D 0F AF E2        imul        r12,r10
  0000000140009D61: 49 F7 D7           not         r15
  0000000140009D64: 4D 01 FC           add         r12,r15
  0000000140009D67: 42 C6 04 23 4F     mov         byte ptr [rbx+r12],4Fh
  0000000140009D6C: 49 FF 04 D6        inc         qword ptr [r14+rdx*8]
  0000000140009D70: 49 FF C1           inc         r9
  0000000140009D73: 42 0F B6 6C 07 06  movzx       ebp,byte ptr [rdi+r8+6]
  0000000140009D79: 4C 89 C8           mov         rax,r9
  0000000140009D7C: 48 99              cqo
  0000000140009D7E: 49 F7 FA           idiv        rax,r10
  0000000140009D81: 83 FD 4F           cmp         ebp,4Fh
  0000000140009D84: 74 2A              je          0000000140009DB0
  0000000140009D86: 83 FD 23           cmp         ebp,23h
  0000000140009D89: 75 45              jne         0000000140009DD0
  0000000140009D8B: 49 89 D7           mov         r15,rdx
  0000000140009D8E: 4D 0F AF FA        imul        r15,r10
  0000000140009D92: 49 89 C4           mov         r12,rax
  0000000140009D95: 49 F7 D4           not         r12
  0000000140009D98: 48 FF C0           inc         rax
  0000000140009D9B: 4D 01 D7           add         r15,r10
  0000000140009D9E: 4D 01 E7           add         r15,r12
  0000000140009DA1: 42 C6 04 3B 23     mov         byte ptr [rbx+r15],23h
  0000000140009DA6: 49 89 04 D6        mov         qword ptr [r14+rdx*8],rax
  0000000140009DAA: EB 24              jmp         0000000140009DD0
  0000000140009DAC: 0F 1F 40 00        nop         dword ptr [rax]
  0000000140009DB0: 4D 8B 3C D6        mov         r15,qword ptr [r14+rdx*8]
  0000000140009DB4: 49 89 D4           mov         r12,rdx
  0000000140009DB7: 49 FF C4           inc         r12
  0000000140009DBA: 48 01 C1           add         rcx,rax
  0000000140009DBD: 4D 0F AF E2        imul        r12,r10
  0000000140009DC1: 49 F7 D7           not         r15
  0000000140009DC4: 4D 01 FC           add         r12,r15
  0000000140009DC7: 42 C6 04 23 4F     mov         byte ptr [rbx+r12],4Fh
  0000000140009DCC: 49 FF 04 D6        inc         qword ptr [r14+rdx*8]
  0000000140009DD0: 49 FF C1           inc         r9
  0000000140009DD3: 42 0F B6 6C 07 07  movzx       ebp,byte ptr [rdi+r8+7]
  0000000140009DD9: 4C 89 C8           mov         rax,r9
  0000000140009DDC: 48 99              cqo
  0000000140009DDE: 49 F7 FA           idiv        rax,r10
  0000000140009DE1: 83 FD 4F           cmp         ebp,4Fh
  0000000140009DE4: 0F 84 16 FD FF FF  je          0000000140009B00
  0000000140009DEA: 83 FD 23           cmp         ebp,23h
  0000000140009DED: 0F 85 2D FD FF FF  jne         0000000140009B20
  0000000140009DF3: 49 89 D7           mov         r15,rdx
  0000000140009DF6: 4D 0F AF FA        imul        r15,r10
  0000000140009DFA: 49 89 C4           mov         r12,rax
  0000000140009DFD: 49 F7 D4           not         r12
  0000000140009E00: 48 FF C0           inc         rax
  0000000140009E03: 4D 01 D7           add         r15,r10
  0000000140009E06: 4D 01 E7           add         r15,r12
  0000000140009E09: 42 C6 04 3B 23     mov         byte ptr [rbx+r15],23h
  0000000140009E0E: 49 89 04 D6        mov         qword ptr [r14+rdx*8],rax
  0000000140009E12: E9 09 FD FF FF     jmp         0000000140009B20
  0000000140009E17: 49 83 C0 08        add         r8,8
  0000000140009E1B: 4D 85 DB           test        r11,r11
  0000000140009E1E: 74 7F              je          0000000140009E9F
  0000000140009E20: 4C 8B 0D A9 61 03  mov         r9,qword ptr [14003FFD0h]
                    00
  0000000140009E27: 48 8B 35 B2 61 03  mov         rsi,qword ptr [14003FFE0h]
                    00
  0000000140009E2E: 48 8B 3D BB 61 03  mov         rdi,qword ptr [14003FFF0h]
                    00
  0000000140009E35: EB 31              jmp         0000000140009E68
  0000000140009E37: 66 0F 1F 84 00 00  nop         word ptr [rax+rax]
                    00 00 00
  0000000140009E40: 48 8B 1C D7        mov         rbx,qword ptr [rdi+rdx*8]
  0000000140009E44: 49 89 D6           mov         r14,rdx
  0000000140009E47: 49 FF C6           inc         r14
  0000000140009E4A: 48 01 C1           add         rcx,rax
  0000000140009E4D: 4D 0F AF F2        imul        r14,r10
  0000000140009E51: 48 F7 D3           not         rbx
  0000000140009E54: 49 01 DE           add         r14,rbx
  0000000140009E57: 42 C6 04 36 4F     mov         byte ptr [rsi+r14],4Fh
  0000000140009E5C: 48 FF 04 D7        inc         qword ptr [rdi+rdx*8]
  0000000140009E60: 49 FF C0           inc         r8
  0000000140009E63: 49 FF CB           dec         r11
  0000000140009E66: 74 37              je          0000000140009E9F
  0000000140009E68: 4C 89 C0           mov         rax,r8
  0000000140009E6B: 48 99              cqo
  0000000140009E6D: 43 0F B6 1C 01     movzx       ebx,byte ptr [r9+r8]
  0000000140009E72: 49 F7 FA           idiv        rax,r10
  0000000140009E75: 83 FB 4F           cmp         ebx,4Fh
  0000000140009E78: 74 C6              je          0000000140009E40
  0000000140009E7A: 83 FB 23           cmp         ebx,23h
  0000000140009E7D: 75 E1              jne         0000000140009E60
  0000000140009E7F: 48 89 D3           mov         rbx,rdx
  0000000140009E82: 49 0F AF DA        imul        rbx,r10
  0000000140009E86: 49 89 C6           mov         r14,rax
  0000000140009E89: 49 F7 D6           not         r14
  0000000140009E8C: 48 FF C0           inc         rax
  0000000140009E8F: 4C 01 D3           add         rbx,r10
  0000000140009E92: 4C 01 F3           add         rbx,r14
  0000000140009E95: C6 04 1E 23        mov         byte ptr [rsi+rbx],23h
  0000000140009E99: 48 89 04 D7        mov         qword ptr [rdi+rdx*8],rax
  0000000140009E9D: EB C1              jmp         0000000140009E60
  0000000140009E9F: 48 89 C8           mov         rax,rcx
  0000000140009EA2: 5B                 pop         rbx
  0000000140009EA3: 5D                 pop         rbp
  0000000140009EA4: 5F                 pop         rdi
  0000000140009EA5: 5E                 pop         rsi
  0000000140009EA6: 41 5C              pop         r12
  0000000140009EA8: 41 5E              pop         r14
  0000000140009EAA: 41 5F              pop         r15
  0000000140009EAC: C3                 ret
  0000000140009EAD: 0F 1F 00           nop         dword ptr [rax]