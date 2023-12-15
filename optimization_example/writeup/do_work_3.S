opt_ex.aocloop_do_work_3:
  push        r15
  push        r14
  push        r13
  push        r12
  push        rsi
  push        rdi
  push        rbp
  push        rbx
  sub         rsp,0D0h
                    
  mov         rax,qword ptr [14003FFD8h]
                    
  mov         r8,qword ptr [140040000h]
                    
  xor         ecx,ecx
  cqo
  idiv        rax,r8
  mov         qword ptr [rsp+90h],rax
                    
  test        rax,rax
  jle         000000014000A85E
  test        r8,r8
  jle         000000014000A85E
  mov         rdx,qword ptr [14003FFE0h]
                    
  mov         eax,r8d
  and         eax,7
  lea         rcx,[r8*8]
                    
  lea         rdi,[r8+r8*2]
  mov         r10,qword ptr [14003FFD0h]
                    
  mov         rsi,qword ptr [14003FFF0h]
                    
  mov         r15,r8
  and         r15,0FFFFFFFFFFFFFFF8h
  mov         qword ptr [rsp+80h],rax
                    
  mov         qword ptr [rsp+88h],r15
                    
  mov         qword ptr [rsp+0C8h],rcx
                    
  lea         r9,[rdx+r8*4]
  lea         rax,[rdx+r8]
  lea         r11,[rdx+r8*2]
  lea         r12,[rdx+rdi]
  lea         rbx,[rdx+rdi*2]
  mov         qword ptr [rsp+0C0h],rdx
                    
  mov         qword ptr [rsp+60h],rdx
  lea         rbp,[r10+4]
  lea         r13,[r10+3]
  lea         r14,[r10+2]
  lea         rdi,[r10+1]
  mov         qword ptr [rsp],r10
  mov         qword ptr [rsp+18h],rax
  mov         rax,rcx
  sub         rax,r8
  mov         qword ptr [rsp+0B8h],r12
                    
  mov         qword ptr [rsp+48h],r12
  lea         rcx,[r10+7]
  mov         qword ptr [rsp+8],r9
  lea         r9,[r8+r8*4]
  add         rax,rdx
  mov         qword ptr [rsp+10h],r11
  lea         r11,[rdx+r8*8]
  mov         qword ptr [rsp+78h],rcx
  lea         rcx,[r10+6]
  mov         qword ptr [rsp+0A8h],rbx
                    
  mov         qword ptr [rsp+30h],rbx
  mov         r12,qword ptr [rsp+8]
  mov         qword ptr [rsp+70h],rcx
  lea         rcx,[r10+5]
  mov         qword ptr [rsp+0A0h],rax
                    
  mov         qword ptr [rsp+28h],rax
  add         r9,rdx
  mov         rdx,qword ptr [rsp+18h]
  mov         qword ptr [rsp+68h],rcx
  xor         ecx,ecx
  mov         qword ptr [rsp+98h],r11
                    
  mov         qword ptr [rsp+20h],r11
  xor         r11d,r11d
  mov         qword ptr [rsp+0B0h],r9
                    
  mov         qword ptr [rsp+38h],r9
  mov         qword ptr [rsp+40h],r12
  mov         qword ptr [rsp+58h],rdx
  mov         rdx,qword ptr [rsp+10h]
  mov         qword ptr [rsp+50h],rdx
  jmp         000000014000A558
  nop         word ptr cs:[rax+rax]
                    
                    
  add         qword ptr [rsp+78h],r8
  dec         qword ptr [rsp+20h]
  add         qword ptr [rsp+70h],r8
  dec         qword ptr [rsp+28h]
  add         qword ptr [rsp+68h],r8
  dec         qword ptr [rsp+30h]
  dec         qword ptr [rsp+38h]
  dec         qword ptr [rsp+40h]
  dec         qword ptr [rsp+48h]
  dec         qword ptr [rsp+50h]
  dec         qword ptr [rsp+58h]
  dec         qword ptr [rsp+60h]
  add         qword ptr [rsp],r8
  mov         r15,qword ptr [rsp+88h]
                    
  add         rbp,r8
  add         r13,r8
  add         r14,r8
  add         rdi,r8
  add         r10,r8
  mov         r11,r9
  cmp         r9,qword ptr [rsp+90h]
                    
  je          000000014000A85E
  lea         r9,[r11+1]
  cmp         r8,8
  jae         000000014000A5E0
  xor         ebx,ebx
  cmp         qword ptr [rsp+80h],0
                    
  je          000000014000A4F0
  lea         rax,[rbx+1]
  lea         rdx,[rsi+rbx*8]
  add         rbx,qword ptr [rsp]
  xor         r15d,r15d
  imul        rax,r8
  dec         rax
  jmp         000000014000A5BC
  nop
  mov         r12,qword ptr [rsp+0C0h]
                    
  add         rcx,r11
  sub         r12,qword ptr [rdx+r15*8]
  mov         byte ptr [r12+rax],4Fh
  inc         qword ptr [rdx+r15*8]
  inc         r15
  add         rax,r8
  cmp         qword ptr [rsp+80h],r15
                    
  je          000000014000A4F0
  movzx       r12d,byte ptr [rbx+r15]
  cmp         r12d,4Fh
  je          000000014000A590
  cmp         r12d,23h
  jne         000000014000A5A8
  mov         r12,qword ptr [rsp+60h]
  mov         byte ptr [r12+rax],23h
  mov         qword ptr [rdx+r15*8],r9
  jmp         000000014000A5A8
  nop         dword ptr [rax]
  mov         rdx,0FFFFFFFFFFFFFFFFh
                    
  xor         ebx,ebx
  jmp         000000014000A61E
  nop         dword ptr [rax+rax]
  mov         rax,qword ptr [rsp+98h]
                    
  add         rcx,r11
  sub         rax,qword ptr [rsi+rbx*8+38h]
  mov         byte ptr [rax+rdx],4Fh
  inc         qword ptr [rsi+rbx*8+38h]
  add         rdx,qword ptr [rsp+0C8h]
                    
  add         rbx,8
  cmp         r15,rbx
  je          000000014000A568
  movzx       eax,byte ptr [r10+rbx]
  cmp         eax,4Fh
  je          000000014000A730
  cmp         eax,23h
  jne         000000014000A63E
  mov         rax,qword ptr [rsp+58h]
  mov         byte ptr [rax+rdx],23h
  mov         qword ptr [rsi+rbx*8],r9
  movzx       eax,byte ptr [rdi+rbx]
  cmp         eax,4Fh
  je          000000014000A751
  cmp         eax,23h
  jne         000000014000A65E
  mov         rax,qword ptr [rsp+50h]
  mov         byte ptr [rax+rdx],23h
  mov         qword ptr [rsi+rbx*8+8],r9
  movzx       eax,byte ptr [r14+rbx]
  cmp         eax,4Fh
  je          000000014000A775
  cmp         eax,23h
  jne         000000014000A67F
  mov         rax,qword ptr [rsp+48h]
  mov         byte ptr [rax+rdx],23h
  mov         qword ptr [rsi+rbx*8+10h],r9
  movzx       eax,byte ptr [r13+rbx]
  cmp         eax,4Fh
  je          000000014000A79D
  cmp         eax,23h
  jne         000000014000A6A1
  mov         rax,qword ptr [rsp+40h]
  mov         byte ptr [rax+rdx],23h
  mov         qword ptr [rsi+rbx*8+18h],r9
  movzx       eax,byte ptr [rbp+rbx]
  cmp         eax,4Fh
  je          000000014000A7C1
  cmp         eax,23h
  jne         000000014000A6C2
  mov         rax,qword ptr [rsp+38h]
  mov         byte ptr [rax+rdx],23h
  mov         qword ptr [rsi+rbx*8+20h],r9
  mov         rax,qword ptr [rsp+68h]
  movzx       eax,byte ptr [rax+rbx]
  cmp         eax,4Fh
  je          000000014000A7EC
  cmp         eax,23h
  jne         000000014000A6E7
  mov         rax,qword ptr [rsp+30h]
  mov         byte ptr [rax+rdx],23h
  mov         qword ptr [rsi+rbx*8+28h],r9
  mov         rax,qword ptr [rsp+70h]
  movzx       eax,byte ptr [rax+rbx]
  cmp         eax,4Fh
  je          000000014000A817
  cmp         eax,23h
  jne         000000014000A70C
  mov         rax,qword ptr [rsp+28h]
  mov         byte ptr [rax+rdx],23h
  mov         qword ptr [rsi+rbx*8+30h],r9
  mov         rax,qword ptr [rsp+78h]
  movzx       eax,byte ptr [rax+rbx]
  cmp         eax,4Fh
  jne         000000014000A842
  jmp         000000014000A5F0
  nop         word ptr cs:[rax+rax]
                    
                    
  mov         rax,qword ptr [rsp+18h]
  add         rcx,r11
  sub         rax,qword ptr [rsi+rbx*8]
  mov         byte ptr [rax+rdx],4Fh
  inc         qword ptr [rsi+rbx*8]
  movzx       eax,byte ptr [rdi+rbx]
  cmp         eax,4Fh
  jne         000000014000A64B
  mov         rax,qword ptr [rsp+10h]
  add         rcx,r11
  sub         rax,qword ptr [rsi+rbx*8+8]
  mov         byte ptr [rax+rdx],4Fh
  inc         qword ptr [rsi+rbx*8+8]
  movzx       eax,byte ptr [r14+rbx]
  cmp         eax,4Fh
  jne         000000014000A66C
  mov         rax,qword ptr [rsp+0B8h]
                    
  add         rcx,r11
  sub         rax,qword ptr [rsi+rbx*8+10h]
  mov         byte ptr [rax+rdx],4Fh
  inc         qword ptr [rsi+rbx*8+10h]
  movzx       eax,byte ptr [r13+rbx]
  cmp         eax,4Fh
  jne         000000014000A68E
  mov         rax,qword ptr [rsp+8]
  add         rcx,r11
  sub         rax,qword ptr [rsi+rbx*8+18h]
  mov         byte ptr [rax+rdx],4Fh
  inc         qword ptr [rsi+rbx*8+18h]
  movzx       eax,byte ptr [rbp+rbx]
  cmp         eax,4Fh
  jne         000000014000A6AF
  mov         rax,qword ptr [rsp+0B0h]
                    
  add         rcx,r11
  sub         rax,qword ptr [rsi+rbx*8+20h]
  mov         byte ptr [rax+rdx],4Fh
  inc         qword ptr [rsi+rbx*8+20h]
  mov         rax,qword ptr [rsp+68h]
  movzx       eax,byte ptr [rax+rbx]
  cmp         eax,4Fh
  jne         000000014000A6D4
  mov         rax,qword ptr [rsp+0A8h]
                    
  add         rcx,r11
  sub         rax,qword ptr [rsi+rbx*8+28h]
  mov         byte ptr [rax+rdx],4Fh
  inc         qword ptr [rsi+rbx*8+28h]
  mov         rax,qword ptr [rsp+70h]
  movzx       eax,byte ptr [rax+rbx]
  cmp         eax,4Fh
  jne         000000014000A6F9
  mov         rax,qword ptr [rsp+0A0h]
                    
  add         rcx,r11
  sub         rax,qword ptr [rsi+rbx*8+30h]
  mov         byte ptr [rax+rdx],4Fh
  inc         qword ptr [rsi+rbx*8+30h]
  mov         rax,qword ptr [rsp+78h]
  movzx       eax,byte ptr [rax+rbx]
  cmp         eax,4Fh
  je          000000014000A5F0
  cmp         eax,23h
  jne         000000014000A609
  mov         rax,qword ptr [rsp+20h]
  mov         byte ptr [rax+rdx],23h
  mov         qword ptr [rsi+rbx*8+38h],r9
  jmp         000000014000A609
  mov         rax,rcx
  add         rsp,0D0h
                    
  pop         rbx
  pop         rbp
  pop         rdi
  pop         rsi
  pop         r12
  pop         r13
  pop         r14
  pop         r15
  ret
  nop         word ptr cs:[rax+rax]
                    