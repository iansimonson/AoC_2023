opt_ex.aocloop_do_work_3:
  000000014000A380: 41 57              push        r15
  000000014000A382: 41 56              push        r14
  000000014000A384: 41 55              push        r13
  000000014000A386: 41 54              push        r12
  000000014000A388: 56                 push        rsi
  000000014000A389: 57                 push        rdi
  000000014000A38A: 55                 push        rbp
  000000014000A38B: 53                 push        rbx
  000000014000A38C: 48 81 EC D0 00 00  sub         rsp,0D0h
                    00
  000000014000A393: 48 8B 05 3E 5C 03  mov         rax,qword ptr [14003FFD8h]
                    00
  000000014000A39A: 4C 8B 05 5F 5C 03  mov         r8,qword ptr [140040000h]
                    00
  000000014000A3A1: 31 C9              xor         ecx,ecx
  000000014000A3A3: 48 99              cqo
  000000014000A3A5: 49 F7 F8           idiv        rax,r8
  000000014000A3A8: 48 89 84 24 90 00  mov         qword ptr [rsp+90h],rax
                    00 00
  000000014000A3B0: 48 85 C0           test        rax,rax
  000000014000A3B3: 0F 8E A5 04 00 00  jle         000000014000A85E
  000000014000A3B9: 4D 85 C0           test        r8,r8
  000000014000A3BC: 0F 8E 9C 04 00 00  jle         000000014000A85E
  000000014000A3C2: 48 8B 15 17 5C 03  mov         rdx,qword ptr [14003FFE0h]
                    00
  000000014000A3C9: 44 89 C0           mov         eax,r8d
  000000014000A3CC: 83 E0 07           and         eax,7
  000000014000A3CF: 4A 8D 0C C5 00 00  lea         rcx,[r8*8]
                    00 00
  000000014000A3D7: 4B 8D 3C 40        lea         rdi,[r8+r8*2]
  000000014000A3DB: 4C 8B 15 EE 5B 03  mov         r10,qword ptr [14003FFD0h]
                    00
  000000014000A3E2: 48 8B 35 07 5C 03  mov         rsi,qword ptr [14003FFF0h]
                    00
  000000014000A3E9: 4D 89 C7           mov         r15,r8
  000000014000A3EC: 49 83 E7 F8        and         r15,0FFFFFFFFFFFFFFF8h
  000000014000A3F0: 48 89 84 24 80 00  mov         qword ptr [rsp+80h],rax
                    00 00
  000000014000A3F8: 4C 89 BC 24 88 00  mov         qword ptr [rsp+88h],r15
                    00 00
  000000014000A400: 48 89 8C 24 C8 00  mov         qword ptr [rsp+0C8h],rcx
                    00 00
  000000014000A408: 4E 8D 0C 82        lea         r9,[rdx+r8*4]
  000000014000A40C: 4A 8D 04 02        lea         rax,[rdx+r8]
  000000014000A410: 4E 8D 1C 42        lea         r11,[rdx+r8*2]
  000000014000A414: 4C 8D 24 3A        lea         r12,[rdx+rdi]
  000000014000A418: 48 8D 1C 7A        lea         rbx,[rdx+rdi*2]
  000000014000A41C: 48 89 94 24 C0 00  mov         qword ptr [rsp+0C0h],rdx
                    00 00
  000000014000A424: 48 89 54 24 60     mov         qword ptr [rsp+60h],rdx
  000000014000A429: 49 8D 6A 04        lea         rbp,[r10+4]
  000000014000A42D: 4D 8D 6A 03        lea         r13,[r10+3]
  000000014000A431: 4D 8D 72 02        lea         r14,[r10+2]
  000000014000A435: 49 8D 7A 01        lea         rdi,[r10+1]
  000000014000A439: 4C 89 14 24        mov         qword ptr [rsp],r10
  000000014000A43D: 48 89 44 24 18     mov         qword ptr [rsp+18h],rax
  000000014000A442: 48 89 C8           mov         rax,rcx
  000000014000A445: 4C 29 C0           sub         rax,r8
  000000014000A448: 4C 89 A4 24 B8 00  mov         qword ptr [rsp+0B8h],r12
                    00 00
  000000014000A450: 4C 89 64 24 48     mov         qword ptr [rsp+48h],r12
  000000014000A455: 49 8D 4A 07        lea         rcx,[r10+7]
  000000014000A459: 4C 89 4C 24 08     mov         qword ptr [rsp+8],r9
  000000014000A45E: 4F 8D 0C 80        lea         r9,[r8+r8*4]
  000000014000A462: 48 01 D0           add         rax,rdx
  000000014000A465: 4C 89 5C 24 10     mov         qword ptr [rsp+10h],r11
  000000014000A46A: 4E 8D 1C C2        lea         r11,[rdx+r8*8]
  000000014000A46E: 48 89 4C 24 78     mov         qword ptr [rsp+78h],rcx
  000000014000A473: 49 8D 4A 06        lea         rcx,[r10+6]
  000000014000A477: 48 89 9C 24 A8 00  mov         qword ptr [rsp+0A8h],rbx
                    00 00
  000000014000A47F: 48 89 5C 24 30     mov         qword ptr [rsp+30h],rbx
  000000014000A484: 4C 8B 64 24 08     mov         r12,qword ptr [rsp+8]
  000000014000A489: 48 89 4C 24 70     mov         qword ptr [rsp+70h],rcx
  000000014000A48E: 49 8D 4A 05        lea         rcx,[r10+5]
  000000014000A492: 48 89 84 24 A0 00  mov         qword ptr [rsp+0A0h],rax
                    00 00
  000000014000A49A: 48 89 44 24 28     mov         qword ptr [rsp+28h],rax
  000000014000A49F: 49 01 D1           add         r9,rdx
  000000014000A4A2: 48 8B 54 24 18     mov         rdx,qword ptr [rsp+18h]
  000000014000A4A7: 48 89 4C 24 68     mov         qword ptr [rsp+68h],rcx
  000000014000A4AC: 31 C9              xor         ecx,ecx
  000000014000A4AE: 4C 89 9C 24 98 00  mov         qword ptr [rsp+98h],r11
                    00 00
  000000014000A4B6: 4C 89 5C 24 20     mov         qword ptr [rsp+20h],r11
  000000014000A4BB: 45 31 DB           xor         r11d,r11d
  000000014000A4BE: 4C 89 8C 24 B0 00  mov         qword ptr [rsp+0B0h],r9
                    00 00
  000000014000A4C6: 4C 89 4C 24 38     mov         qword ptr [rsp+38h],r9
  000000014000A4CB: 4C 89 64 24 40     mov         qword ptr [rsp+40h],r12
  000000014000A4D0: 48 89 54 24 58     mov         qword ptr [rsp+58h],rdx
  000000014000A4D5: 48 8B 54 24 10     mov         rdx,qword ptr [rsp+10h]
  000000014000A4DA: 48 89 54 24 50     mov         qword ptr [rsp+50h],rdx
  000000014000A4DF: EB 77              jmp         000000014000A558
  000000014000A4E1: 66 66 66 66 66 66  nop         word ptr cs:[rax+rax]
                    2E 0F 1F 84 00 00
                    00 00 00
  000000014000A4F0: 4C 01 44 24 78     add         qword ptr [rsp+78h],r8
  000000014000A4F5: 48 FF 4C 24 20     dec         qword ptr [rsp+20h]
  000000014000A4FA: 4C 01 44 24 70     add         qword ptr [rsp+70h],r8
  000000014000A4FF: 48 FF 4C 24 28     dec         qword ptr [rsp+28h]
  000000014000A504: 4C 01 44 24 68     add         qword ptr [rsp+68h],r8
  000000014000A509: 48 FF 4C 24 30     dec         qword ptr [rsp+30h]
  000000014000A50E: 48 FF 4C 24 38     dec         qword ptr [rsp+38h]
  000000014000A513: 48 FF 4C 24 40     dec         qword ptr [rsp+40h]
  000000014000A518: 48 FF 4C 24 48     dec         qword ptr [rsp+48h]
  000000014000A51D: 48 FF 4C 24 50     dec         qword ptr [rsp+50h]
  000000014000A522: 48 FF 4C 24 58     dec         qword ptr [rsp+58h]
  000000014000A527: 48 FF 4C 24 60     dec         qword ptr [rsp+60h]
  000000014000A52C: 4C 01 04 24        add         qword ptr [rsp],r8
  000000014000A530: 4C 8B BC 24 88 00  mov         r15,qword ptr [rsp+88h]
                    00 00
  000000014000A538: 4C 01 C5           add         rbp,r8
  000000014000A53B: 4D 01 C5           add         r13,r8
  000000014000A53E: 4D 01 C6           add         r14,r8
  000000014000A541: 4C 01 C7           add         rdi,r8
  000000014000A544: 4D 01 C2           add         r10,r8
  000000014000A547: 4D 89 CB           mov         r11,r9
  000000014000A54A: 4C 3B 8C 24 90 00  cmp         r9,qword ptr [rsp+90h]
                    00 00
  000000014000A552: 0F 84 06 03 00 00  je          000000014000A85E
  000000014000A558: 4D 8D 4B 01        lea         r9,[r11+1]
  000000014000A55C: 49 83 F8 08        cmp         r8,8
  000000014000A560: 0F 83 7A 00 00 00  jae         000000014000A5E0
  000000014000A566: 31 DB              xor         ebx,ebx
  000000014000A568: 48 83 BC 24 80 00  cmp         qword ptr [rsp+80h],0
                    00 00 00
  000000014000A571: 0F 84 79 FF FF FF  je          000000014000A4F0
  000000014000A577: 48 8D 43 01        lea         rax,[rbx+1]
  000000014000A57B: 48 8D 14 DE        lea         rdx,[rsi+rbx*8]
  000000014000A57F: 48 03 1C 24        add         rbx,qword ptr [rsp]
  000000014000A583: 45 31 FF           xor         r15d,r15d
  000000014000A586: 49 0F AF C0        imul        rax,r8
  000000014000A58A: 48 FF C8           dec         rax
  000000014000A58D: EB 2D              jmp         000000014000A5BC
  000000014000A58F: 90                 nop
  000000014000A590: 4C 8B A4 24 C0 00  mov         r12,qword ptr [rsp+0C0h]
                    00 00
  000000014000A598: 4C 01 D9           add         rcx,r11
  000000014000A59B: 4E 2B 24 FA        sub         r12,qword ptr [rdx+r15*8]
  000000014000A59F: 41 C6 04 04 4F     mov         byte ptr [r12+rax],4Fh
  000000014000A5A4: 4A FF 04 FA        inc         qword ptr [rdx+r15*8]
  000000014000A5A8: 49 FF C7           inc         r15
  000000014000A5AB: 4C 01 C0           add         rax,r8
  000000014000A5AE: 4C 39 BC 24 80 00  cmp         qword ptr [rsp+80h],r15
                    00 00
  000000014000A5B6: 0F 84 34 FF FF FF  je          000000014000A4F0
  000000014000A5BC: 46 0F B6 24 3B     movzx       r12d,byte ptr [rbx+r15]
  000000014000A5C1: 41 83 FC 4F        cmp         r12d,4Fh
  000000014000A5C5: 74 C9              je          000000014000A590
  000000014000A5C7: 41 83 FC 23        cmp         r12d,23h
  000000014000A5CB: 75 DB              jne         000000014000A5A8
  000000014000A5CD: 4C 8B 64 24 60     mov         r12,qword ptr [rsp+60h]
  000000014000A5D2: 41 C6 04 04 23     mov         byte ptr [r12+rax],23h
  000000014000A5D7: 4E 89 0C FA        mov         qword ptr [rdx+r15*8],r9
  000000014000A5DB: EB CB              jmp         000000014000A5A8
  000000014000A5DD: 0F 1F 00           nop         dword ptr [rax]
  000000014000A5E0: 48 C7 C2 FF FF FF  mov         rdx,0FFFFFFFFFFFFFFFFh
                    FF
  000000014000A5E7: 31 DB              xor         ebx,ebx
  000000014000A5E9: EB 33              jmp         000000014000A61E
  000000014000A5EB: 0F 1F 44 00 00     nop         dword ptr [rax+rax]
  000000014000A5F0: 48 8B 84 24 98 00  mov         rax,qword ptr [rsp+98h]
                    00 00
  000000014000A5F8: 4C 01 D9           add         rcx,r11
  000000014000A5FB: 48 2B 44 DE 38     sub         rax,qword ptr [rsi+rbx*8+38h]
  000000014000A600: C6 04 10 4F        mov         byte ptr [rax+rdx],4Fh
  000000014000A604: 48 FF 44 DE 38     inc         qword ptr [rsi+rbx*8+38h]
  000000014000A609: 48 03 94 24 C8 00  add         rdx,qword ptr [rsp+0C8h]
                    00 00
  000000014000A611: 48 83 C3 08        add         rbx,8
  000000014000A615: 49 39 DF           cmp         r15,rbx
  000000014000A618: 0F 84 4A FF FF FF  je          000000014000A568
  000000014000A61E: 41 0F B6 04 1A     movzx       eax,byte ptr [r10+rbx]
  000000014000A623: 83 F8 4F           cmp         eax,4Fh
  000000014000A626: 0F 84 04 01 00 00  je          000000014000A730
  000000014000A62C: 83 F8 23           cmp         eax,23h
  000000014000A62F: 75 0D              jne         000000014000A63E
  000000014000A631: 48 8B 44 24 58     mov         rax,qword ptr [rsp+58h]
  000000014000A636: C6 04 10 23        mov         byte ptr [rax+rdx],23h
  000000014000A63A: 4C 89 0C DE        mov         qword ptr [rsi+rbx*8],r9
  000000014000A63E: 0F B6 04 1F        movzx       eax,byte ptr [rdi+rbx]
  000000014000A642: 83 F8 4F           cmp         eax,4Fh
  000000014000A645: 0F 84 06 01 00 00  je          000000014000A751
  000000014000A64B: 83 F8 23           cmp         eax,23h
  000000014000A64E: 75 0E              jne         000000014000A65E
  000000014000A650: 48 8B 44 24 50     mov         rax,qword ptr [rsp+50h]
  000000014000A655: C6 04 10 23        mov         byte ptr [rax+rdx],23h
  000000014000A659: 4C 89 4C DE 08     mov         qword ptr [rsi+rbx*8+8],r9
  000000014000A65E: 41 0F B6 04 1E     movzx       eax,byte ptr [r14+rbx]
  000000014000A663: 83 F8 4F           cmp         eax,4Fh
  000000014000A666: 0F 84 09 01 00 00  je          000000014000A775
  000000014000A66C: 83 F8 23           cmp         eax,23h
  000000014000A66F: 75 0E              jne         000000014000A67F
  000000014000A671: 48 8B 44 24 48     mov         rax,qword ptr [rsp+48h]
  000000014000A676: C6 04 10 23        mov         byte ptr [rax+rdx],23h
  000000014000A67A: 4C 89 4C DE 10     mov         qword ptr [rsi+rbx*8+10h],r9
  000000014000A67F: 41 0F B6 44 1D 00  movzx       eax,byte ptr [r13+rbx]
  000000014000A685: 83 F8 4F           cmp         eax,4Fh
  000000014000A688: 0F 84 0F 01 00 00  je          000000014000A79D
  000000014000A68E: 83 F8 23           cmp         eax,23h
  000000014000A691: 75 0E              jne         000000014000A6A1
  000000014000A693: 48 8B 44 24 40     mov         rax,qword ptr [rsp+40h]
  000000014000A698: C6 04 10 23        mov         byte ptr [rax+rdx],23h
  000000014000A69C: 4C 89 4C DE 18     mov         qword ptr [rsi+rbx*8+18h],r9
  000000014000A6A1: 0F B6 44 1D 00     movzx       eax,byte ptr [rbp+rbx]
  000000014000A6A6: 83 F8 4F           cmp         eax,4Fh
  000000014000A6A9: 0F 84 12 01 00 00  je          000000014000A7C1
  000000014000A6AF: 83 F8 23           cmp         eax,23h
  000000014000A6B2: 75 0E              jne         000000014000A6C2
  000000014000A6B4: 48 8B 44 24 38     mov         rax,qword ptr [rsp+38h]
  000000014000A6B9: C6 04 10 23        mov         byte ptr [rax+rdx],23h
  000000014000A6BD: 4C 89 4C DE 20     mov         qword ptr [rsi+rbx*8+20h],r9
  000000014000A6C2: 48 8B 44 24 68     mov         rax,qword ptr [rsp+68h]
  000000014000A6C7: 0F B6 04 18        movzx       eax,byte ptr [rax+rbx]
  000000014000A6CB: 83 F8 4F           cmp         eax,4Fh
  000000014000A6CE: 0F 84 18 01 00 00  je          000000014000A7EC
  000000014000A6D4: 83 F8 23           cmp         eax,23h
  000000014000A6D7: 75 0E              jne         000000014000A6E7
  000000014000A6D9: 48 8B 44 24 30     mov         rax,qword ptr [rsp+30h]
  000000014000A6DE: C6 04 10 23        mov         byte ptr [rax+rdx],23h
  000000014000A6E2: 4C 89 4C DE 28     mov         qword ptr [rsi+rbx*8+28h],r9
  000000014000A6E7: 48 8B 44 24 70     mov         rax,qword ptr [rsp+70h]
  000000014000A6EC: 0F B6 04 18        movzx       eax,byte ptr [rax+rbx]
  000000014000A6F0: 83 F8 4F           cmp         eax,4Fh
  000000014000A6F3: 0F 84 1E 01 00 00  je          000000014000A817
  000000014000A6F9: 83 F8 23           cmp         eax,23h
  000000014000A6FC: 75 0E              jne         000000014000A70C
  000000014000A6FE: 48 8B 44 24 28     mov         rax,qword ptr [rsp+28h]
  000000014000A703: C6 04 10 23        mov         byte ptr [rax+rdx],23h
  000000014000A707: 4C 89 4C DE 30     mov         qword ptr [rsi+rbx*8+30h],r9
  000000014000A70C: 48 8B 44 24 78     mov         rax,qword ptr [rsp+78h]
  000000014000A711: 0F B6 04 18        movzx       eax,byte ptr [rax+rbx]
  000000014000A715: 83 F8 4F           cmp         eax,4Fh
  000000014000A718: 0F 85 24 01 00 00  jne         000000014000A842
  000000014000A71E: E9 CD FE FF FF     jmp         000000014000A5F0
  000000014000A723: 66 66 66 66 2E 0F  nop         word ptr cs:[rax+rax]
                    1F 84 00 00 00 00
                    00
  000000014000A730: 48 8B 44 24 18     mov         rax,qword ptr [rsp+18h]
  000000014000A735: 4C 01 D9           add         rcx,r11
  000000014000A738: 48 2B 04 DE        sub         rax,qword ptr [rsi+rbx*8]
  000000014000A73C: C6 04 10 4F        mov         byte ptr [rax+rdx],4Fh
  000000014000A740: 48 FF 04 DE        inc         qword ptr [rsi+rbx*8]
  000000014000A744: 0F B6 04 1F        movzx       eax,byte ptr [rdi+rbx]
  000000014000A748: 83 F8 4F           cmp         eax,4Fh
  000000014000A74B: 0F 85 FA FE FF FF  jne         000000014000A64B
  000000014000A751: 48 8B 44 24 10     mov         rax,qword ptr [rsp+10h]
  000000014000A756: 4C 01 D9           add         rcx,r11
  000000014000A759: 48 2B 44 DE 08     sub         rax,qword ptr [rsi+rbx*8+8]
  000000014000A75E: C6 04 10 4F        mov         byte ptr [rax+rdx],4Fh
  000000014000A762: 48 FF 44 DE 08     inc         qword ptr [rsi+rbx*8+8]
  000000014000A767: 41 0F B6 04 1E     movzx       eax,byte ptr [r14+rbx]
  000000014000A76C: 83 F8 4F           cmp         eax,4Fh
  000000014000A76F: 0F 85 F7 FE FF FF  jne         000000014000A66C
  000000014000A775: 48 8B 84 24 B8 00  mov         rax,qword ptr [rsp+0B8h]
                    00 00
  000000014000A77D: 4C 01 D9           add         rcx,r11
  000000014000A780: 48 2B 44 DE 10     sub         rax,qword ptr [rsi+rbx*8+10h]
  000000014000A785: C6 04 10 4F        mov         byte ptr [rax+rdx],4Fh
  000000014000A789: 48 FF 44 DE 10     inc         qword ptr [rsi+rbx*8+10h]
  000000014000A78E: 41 0F B6 44 1D 00  movzx       eax,byte ptr [r13+rbx]
  000000014000A794: 83 F8 4F           cmp         eax,4Fh
  000000014000A797: 0F 85 F1 FE FF FF  jne         000000014000A68E
  000000014000A79D: 48 8B 44 24 08     mov         rax,qword ptr [rsp+8]
  000000014000A7A2: 4C 01 D9           add         rcx,r11
  000000014000A7A5: 48 2B 44 DE 18     sub         rax,qword ptr [rsi+rbx*8+18h]
  000000014000A7AA: C6 04 10 4F        mov         byte ptr [rax+rdx],4Fh
  000000014000A7AE: 48 FF 44 DE 18     inc         qword ptr [rsi+rbx*8+18h]
  000000014000A7B3: 0F B6 44 1D 00     movzx       eax,byte ptr [rbp+rbx]
  000000014000A7B8: 83 F8 4F           cmp         eax,4Fh
  000000014000A7BB: 0F 85 EE FE FF FF  jne         000000014000A6AF
  000000014000A7C1: 48 8B 84 24 B0 00  mov         rax,qword ptr [rsp+0B0h]
                    00 00
  000000014000A7C9: 4C 01 D9           add         rcx,r11
  000000014000A7CC: 48 2B 44 DE 20     sub         rax,qword ptr [rsi+rbx*8+20h]
  000000014000A7D1: C6 04 10 4F        mov         byte ptr [rax+rdx],4Fh
  000000014000A7D5: 48 FF 44 DE 20     inc         qword ptr [rsi+rbx*8+20h]
  000000014000A7DA: 48 8B 44 24 68     mov         rax,qword ptr [rsp+68h]
  000000014000A7DF: 0F B6 04 18        movzx       eax,byte ptr [rax+rbx]
  000000014000A7E3: 83 F8 4F           cmp         eax,4Fh
  000000014000A7E6: 0F 85 E8 FE FF FF  jne         000000014000A6D4
  000000014000A7EC: 48 8B 84 24 A8 00  mov         rax,qword ptr [rsp+0A8h]
                    00 00
  000000014000A7F4: 4C 01 D9           add         rcx,r11
  000000014000A7F7: 48 2B 44 DE 28     sub         rax,qword ptr [rsi+rbx*8+28h]
  000000014000A7FC: C6 04 10 4F        mov         byte ptr [rax+rdx],4Fh
  000000014000A800: 48 FF 44 DE 28     inc         qword ptr [rsi+rbx*8+28h]
  000000014000A805: 48 8B 44 24 70     mov         rax,qword ptr [rsp+70h]
  000000014000A80A: 0F B6 04 18        movzx       eax,byte ptr [rax+rbx]
  000000014000A80E: 83 F8 4F           cmp         eax,4Fh
  000000014000A811: 0F 85 E2 FE FF FF  jne         000000014000A6F9
  000000014000A817: 48 8B 84 24 A0 00  mov         rax,qword ptr [rsp+0A0h]
                    00 00
  000000014000A81F: 4C 01 D9           add         rcx,r11
  000000014000A822: 48 2B 44 DE 30     sub         rax,qword ptr [rsi+rbx*8+30h]
  000000014000A827: C6 04 10 4F        mov         byte ptr [rax+rdx],4Fh
  000000014000A82B: 48 FF 44 DE 30     inc         qword ptr [rsi+rbx*8+30h]
  000000014000A830: 48 8B 44 24 78     mov         rax,qword ptr [rsp+78h]
  000000014000A835: 0F B6 04 18        movzx       eax,byte ptr [rax+rbx]
  000000014000A839: 83 F8 4F           cmp         eax,4Fh
  000000014000A83C: 0F 84 AE FD FF FF  je          000000014000A5F0
  000000014000A842: 83 F8 23           cmp         eax,23h
  000000014000A845: 0F 85 BE FD FF FF  jne         000000014000A609
  000000014000A84B: 48 8B 44 24 20     mov         rax,qword ptr [rsp+20h]
  000000014000A850: C6 04 10 23        mov         byte ptr [rax+rdx],23h
  000000014000A854: 4C 89 4C DE 38     mov         qword ptr [rsi+rbx*8+38h],r9
  000000014000A859: E9 AB FD FF FF     jmp         000000014000A609
  000000014000A85E: 48 89 C8           mov         rax,rcx
  000000014000A861: 48 81 C4 D0 00 00  add         rsp,0D0h
                    00
  000000014000A868: 5B                 pop         rbx
  000000014000A869: 5D                 pop         rbp
  000000014000A86A: 5F                 pop         rdi
  000000014000A86B: 5E                 pop         rsi
  000000014000A86C: 41 5C              pop         r12
  000000014000A86E: 41 5D              pop         r13
  000000014000A870: 41 5E              pop         r14
  000000014000A872: 41 5F              pop         r15
  000000014000A874: C3                 ret
  000000014000A875: 66 66 2E 0F 1F 84  nop         word ptr cs:[rax+rax]
                    00 00 00 00 00