opt_ex.aocloop_do_work_2:
  push        r15
  push        r14
  push        rsi
  push        rdi
  push        rbx
  mov         r11,qword ptr [14003FFD8h]
                    
  test        r11,r11
  jle         0000000140009EEA
  mov         r9,qword ptr [140040000h]
                    
  mov         r10d,r11d
  and         r10d,7
  cmp         r11,8
  jae         0000000140009EF1
  xor         r8d,r8d
  xor         ecx,ecx
  test        r10,r10
  jne         000000014000A2E4
  jmp         000000014000A367
  xor         ecx,ecx
  jmp         000000014000A367
  mov         rsi,qword ptr [14003FFD0h]
                    
  mov         rdi,qword ptr [14003FFE0h]
                    
  mov         rbx,qword ptr [14003FFF0h]
                    
  and         r11,0FFFFFFFFFFFFFFF8h
  mov         r8d,7
  xor         ecx,ecx
  neg         r11
  jmp         0000000140009F5B
  nop         word ptr [rax+rax]
                    
  mov         rax,r8
  cqo
  idiv        rax,r9
  mov         r14,qword ptr [rbx+rdx*8]
  mov         r15,rdx
  imul        r15,r9
  add         r15,r9
  not         r14
  add         r15,r14
  mov         byte ptr [rdi+r15],4Fh
  inc         qword ptr [rbx+rdx*8]
  add         rcx,rax
  lea         rax,[r11+r8+8]
  add         r8,8
  cmp         rax,7
  je          000000014000A2D7
  movzx       edx,byte ptr [rsi+r8-7]
  lea         rax,[r8-7]
  cmp         edx,23h
  je          000000014000A120
  cmp         edx,4Fh
  jne         0000000140009F98
  cqo
  idiv        rax,r9
  mov         r14,qword ptr [rbx+rdx*8]
  mov         r15,rdx
  imul        r15,r9
  add         r15,r9
  not         r14
  add         r15,r14
  mov         byte ptr [rdi+r15],4Fh
  inc         qword ptr [rbx+rdx*8]
  add         rcx,rax
  movzx       edx,byte ptr [rsi+r8-6]
  lea         rax,[r8-6]
  cmp         edx,4Fh
  je          000000014000A157
  cmp         edx,23h
  jne         0000000140009FD4
  cqo
  idiv        rax,r9
  mov         r14,rdx
  imul        r14,r9
  add         r14,r9
  mov         r15,rax
  not         r15
  inc         rax
  add         r14,r15
  mov         byte ptr [rdi+r14],23h
  mov         qword ptr [rbx+rdx*8],rax
  movzx       edx,byte ptr [rsi+r8-5]
  lea         rax,[r8-5]
  cmp         edx,4Fh
  je          000000014000A18F
  cmp         edx,23h
  jne         000000014000A010
  cqo
  idiv        rax,r9
  mov         r14,rdx
  imul        r14,r9
  add         r14,r9
  mov         r15,rax
  not         r15
  inc         rax
  add         r14,r15
  mov         byte ptr [rdi+r14],23h
  mov         qword ptr [rbx+rdx*8],rax
  movzx       edx,byte ptr [rsi+r8-4]
  lea         rax,[r8-4]
  cmp         edx,4Fh
  je          000000014000A1C7
  cmp         edx,23h
  jne         000000014000A04C
  cqo
  idiv        rax,r9
  mov         r14,rdx
  imul        r14,r9
  add         r14,r9
  mov         r15,rax
  not         r15
  inc         rax
  add         r14,r15
  mov         byte ptr [rdi+r14],23h
  mov         qword ptr [rbx+rdx*8],rax
  movzx       edx,byte ptr [rsi+r8-3]
  lea         rax,[r8-3]
  cmp         edx,4Fh
  je          000000014000A1FF
  cmp         edx,23h
  jne         000000014000A088
  cqo
  idiv        rax,r9
  mov         r14,rdx
  imul        r14,r9
  add         r14,r9
  mov         r15,rax
  not         r15
  inc         rax
  add         r14,r15
  mov         byte ptr [rdi+r14],23h
  mov         qword ptr [rbx+rdx*8],rax
  movzx       edx,byte ptr [rsi+r8-2]
  lea         rax,[r8-2]
  cmp         edx,4Fh
  je          000000014000A237
  cmp         edx,23h
  jne         000000014000A0C4
  cqo
  idiv        rax,r9
  mov         r14,rdx
  imul        r14,r9
  add         r14,r9
  mov         r15,rax
  not         r15
  inc         rax
  add         r14,r15
  mov         byte ptr [rdi+r14],23h
  mov         qword ptr [rbx+rdx*8],rax
  movzx       edx,byte ptr [rsi+r8-1]
  lea         rax,[r8-1]
  cmp         edx,4Fh
  je          000000014000A26F
  cmp         edx,23h
  jne         000000014000A100
  cqo
  idiv        rax,r9
  mov         r14,rdx
  imul        r14,r9
  add         r14,r9
  mov         r15,rax
  not         r15
  inc         rax
  add         r14,r15
  mov         byte ptr [rdi+r14],23h
  mov         qword ptr [rbx+rdx*8],rax
  movzx       eax,byte ptr [rsi+r8]
  cmp         eax,4Fh
  jne         000000014000A2A2
  jmp         0000000140009F20
  nop         word ptr cs:[rax+rax]
                    
                    
  cqo
  idiv        rax,r9
  mov         r14,rdx
  imul        r14,r9
  add         r14,r9
  mov         r15,rax
  not         r15
  inc         rax
  add         r14,r15
  mov         byte ptr [rdi+r14],23h
  mov         qword ptr [rbx+rdx*8],rax
  movzx       edx,byte ptr [rsi+r8-6]
  lea         rax,[r8-6]
  cmp         edx,4Fh
  jne         0000000140009FAB
  cqo
  idiv        rax,r9
  mov         r14,qword ptr [rbx+rdx*8]
  mov         r15,rdx
  imul        r15,r9
  add         r15,r9
  not         r14
  add         r15,r14
  mov         byte ptr [rdi+r15],4Fh
  inc         qword ptr [rbx+rdx*8]
  add         rcx,rax
  movzx       edx,byte ptr [rsi+r8-5]
  lea         rax,[r8-5]
  cmp         edx,4Fh
  jne         0000000140009FE7
  cqo
  idiv        rax,r9
  mov         r14,qword ptr [rbx+rdx*8]
  mov         r15,rdx
  imul        r15,r9
  add         r15,r9
  not         r14
  add         r15,r14
  mov         byte ptr [rdi+r15],4Fh
  inc         qword ptr [rbx+rdx*8]
  add         rcx,rax
  movzx       edx,byte ptr [rsi+r8-4]
  lea         rax,[r8-4]
  cmp         edx,4Fh
  jne         000000014000A023
  cqo
  idiv        rax,r9
  mov         r14,qword ptr [rbx+rdx*8]
  mov         r15,rdx
  imul        r15,r9
  add         r15,r9
  not         r14
  add         r15,r14
  mov         byte ptr [rdi+r15],4Fh
  inc         qword ptr [rbx+rdx*8]
  add         rcx,rax
  movzx       edx,byte ptr [rsi+r8-3]
  lea         rax,[r8-3]
  cmp         edx,4Fh
  jne         000000014000A05F
  cqo
  idiv        rax,r9
  mov         r14,qword ptr [rbx+rdx*8]
  mov         r15,rdx
  imul        r15,r9
  add         r15,r9
  not         r14
  add         r15,r14
  mov         byte ptr [rdi+r15],4Fh
  inc         qword ptr [rbx+rdx*8]
  add         rcx,rax
  movzx       edx,byte ptr [rsi+r8-2]
  lea         rax,[r8-2]
  cmp         edx,4Fh
  jne         000000014000A09B
  cqo
  idiv        rax,r9
  mov         r14,qword ptr [rbx+rdx*8]
  mov         r15,rdx
  imul        r15,r9
  add         r15,r9
  not         r14
  add         r15,r14
  mov         byte ptr [rdi+r15],4Fh
  inc         qword ptr [rbx+rdx*8]
  add         rcx,rax
  movzx       edx,byte ptr [rsi+r8-1]
  lea         rax,[r8-1]
  cmp         edx,4Fh
  jne         000000014000A0D7
  cqo
  idiv        rax,r9
  mov         r14,qword ptr [rbx+rdx*8]
  mov         r15,rdx
  imul        r15,r9
  add         r15,r9
  not         r14
  add         r15,r14
  mov         byte ptr [rdi+r15],4Fh
  inc         qword ptr [rbx+rdx*8]
  add         rcx,rax
  movzx       eax,byte ptr [rsi+r8]
  cmp         eax,4Fh
  je          0000000140009F20
  cmp         eax,23h
  jne         0000000140009F48
  mov         rax,r8
  cqo
  idiv        rax,r9
  mov         r14,rdx
  imul        r14,r9
  add         r14,r9
  mov         r15,rax
  not         r15
  inc         rax
  add         r14,r15
  mov         byte ptr [rdi+r14],23h
  mov         qword ptr [rbx+rdx*8],rax
  jmp         0000000140009F48
  add         r8,0FFFFFFFFFFFFFFF9h
  test        r10,r10
  je          000000014000A367
  mov         r11,qword ptr [14003FFD0h]
                    
  mov         rsi,qword ptr [14003FFE0h]
                    
  mov         rdi,qword ptr [14003FFF0h]
                    
  jmp         000000014000A330
  nop         dword ptr [rax+rax]
  mov         rax,r8
  cqo
  idiv        rax,r9
  mov         rbx,qword ptr [rdi+rdx*8]
  mov         r14,rdx
  imul        r14,r9
  add         r14,r9
  not         rbx
  add         r14,rbx
  mov         byte ptr [rsi+r14],4Fh
  inc         qword ptr [rdi+rdx*8]
  add         rcx,rax
  inc         r8
  dec         r10
  je          000000014000A367
  movzx       eax,byte ptr [r11+r8]
  cmp         eax,4Fh
  je          000000014000A300
  cmp         eax,23h
  jne         000000014000A328
  mov         rax,r8
  cqo
  idiv        rax,r9
  mov         rbx,rdx
  imul        rbx,r9
  add         rbx,r9
  mov         r14,rax
  not         r14
  inc         rax
  add         rbx,r14
  mov         byte ptr [rsi+rbx],23h
  mov         qword ptr [rdi+rdx*8],rax
  jmp         000000014000A328
  mov         rax,rcx
  pop         rbx
  pop         rdi
  pop         rsi
  pop         r14
  pop         r15
  ret
  nop         word ptr cs:[rax+rax]
                    
                    