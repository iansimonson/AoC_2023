opt_ex.aocloop_do_work_1:
  push        r15
  push        r14
  push        r12
  push        rsi
  push        rdi
  push        rbp
  push        rbx
  mov         rsi,qword ptr [14003FFD8h]
                    
  test        rsi,rsi
  jle         0000000140009ACD
  mov         r10,qword ptr [140040000h]
                    
  mov         r11d,esi
  and         r11d,7
  cmp         rsi,8
  jae         0000000140009AD4
  xor         r8d,r8d
  xor         ecx,ecx
  test        r11,r11
  jne         0000000140009E20
  jmp         0000000140009E9F
  xor         ecx,ecx
  jmp         0000000140009E9F
  mov         rdi,qword ptr [14003FFD0h]
                    
  mov         rbx,qword ptr [14003FFE0h]
                    
  mov         r14,qword ptr [14003FFF0h]
                    
  and         rsi,0FFFFFFFFFFFFFFF8h
  xor         r9d,r9d
  xor         ecx,ecx
  jmp         0000000140009B2C
  nop         word ptr cs:[rax+rax]
                    
  mov         r15,qword ptr [r14+rdx*8]
  mov         r12,rdx
  inc         r12
  add         rcx,rax
  imul        r12,r10
  not         r15
  add         r12,r15
  mov         byte ptr [rbx+r12],4Fh
  inc         qword ptr [r14+rdx*8]
  inc         r9
  cmp         r9,rsi
  je          0000000140009E17
  mov         r8,r9
  mov         rax,r8
  cqo
  movzx       r9d,byte ptr [rdi+r9]
  idiv        rax,r10
  cmp         r9d,23h
  je          0000000140009B70
  cmp         r9d,4Fh
  jne         0000000140009B8F
  mov         r9,qword ptr [r14+rdx*8]
  mov         r15,rdx
  inc         r15
  add         rcx,rax
  imul        r15,r10
  not         r9
  add         r15,r9
  mov         byte ptr [rbx+r15],4Fh
  inc         qword ptr [r14+rdx*8]
  jmp         0000000140009B8F
  nop         word ptr [rax+rax]
  mov         r9,rdx
  imul        r9,r10
  mov         r15,rax
  not         r15
  inc         rax
  add         r9,r10
  add         r9,r15
  mov         byte ptr [rbx+r9],23h
  mov         qword ptr [r14+rdx*8],rax
  lea         r9,[r8+1]
  movzx       ebp,byte ptr [rdi+r8+1]
  mov         rax,r9
  cqo
  idiv        rax,r10
  cmp         ebp,4Fh
  je          0000000140009BD0
  cmp         ebp,23h
  jne         0000000140009BF0
  mov         r15,rdx
  imul        r15,r10
  mov         r12,rax
  not         r12
  inc         rax
  add         r15,r10
  add         r15,r12
  mov         byte ptr [rbx+r15],23h
  mov         qword ptr [r14+rdx*8],rax
  jmp         0000000140009BF0
  nop         dword ptr [rax]
  mov         r15,qword ptr [r14+rdx*8]
  mov         r12,rdx
  inc         r12
  add         rcx,rax
  imul        r12,r10
  not         r15
  add         r12,r15
  mov         byte ptr [rbx+r12],4Fh
  inc         qword ptr [r14+rdx*8]
  inc         r9
  movzx       ebp,byte ptr [rdi+r8+2]
  mov         rax,r9
  cqo
  idiv        rax,r10
  cmp         ebp,4Fh
  je          0000000140009C30
  cmp         ebp,23h
  jne         0000000140009C50
  mov         r15,rdx
  imul        r15,r10
  mov         r12,rax
  not         r12
  inc         rax
  add         r15,r10
  add         r15,r12
  mov         byte ptr [rbx+r15],23h
  mov         qword ptr [r14+rdx*8],rax
  jmp         0000000140009C50
  nop         dword ptr [rax]
  mov         r15,qword ptr [r14+rdx*8]
  mov         r12,rdx
  inc         r12
  add         rcx,rax
  imul        r12,r10
  not         r15
  add         r12,r15
  mov         byte ptr [rbx+r12],4Fh
  inc         qword ptr [r14+rdx*8]
  inc         r9
  movzx       ebp,byte ptr [rdi+r8+3]
  mov         rax,r9
  cqo
  idiv        rax,r10
  cmp         ebp,4Fh
  je          0000000140009C90
  cmp         ebp,23h
  jne         0000000140009CB0
  mov         r15,rdx
  imul        r15,r10
  mov         r12,rax
  not         r12
  inc         rax
  add         r15,r10
  add         r15,r12
  mov         byte ptr [rbx+r15],23h
  mov         qword ptr [r14+rdx*8],rax
  jmp         0000000140009CB0
  nop         dword ptr [rax]
  mov         r15,qword ptr [r14+rdx*8]
  mov         r12,rdx
  inc         r12
  add         rcx,rax
  imul        r12,r10
  not         r15
  add         r12,r15
  mov         byte ptr [rbx+r12],4Fh
  inc         qword ptr [r14+rdx*8]
  inc         r9
  movzx       ebp,byte ptr [rdi+r8+4]
  mov         rax,r9
  cqo
  idiv        rax,r10
  cmp         ebp,4Fh
  je          0000000140009CF0
  cmp         ebp,23h
  jne         0000000140009D10
  mov         r15,rdx
  imul        r15,r10
  mov         r12,rax
  not         r12
  inc         rax
  add         r15,r10
  add         r15,r12
  mov         byte ptr [rbx+r15],23h
  mov         qword ptr [r14+rdx*8],rax
  jmp         0000000140009D10
  nop         dword ptr [rax]
  mov         r15,qword ptr [r14+rdx*8]
  mov         r12,rdx
  inc         r12
  add         rcx,rax
  imul        r12,r10
  not         r15
  add         r12,r15
  mov         byte ptr [rbx+r12],4Fh
  inc         qword ptr [r14+rdx*8]
  inc         r9
  movzx       ebp,byte ptr [rdi+r8+5]
  mov         rax,r9
  cqo
  idiv        rax,r10
  cmp         ebp,4Fh
  je          0000000140009D50
  cmp         ebp,23h
  jne         0000000140009D70
  mov         r15,rdx
  imul        r15,r10
  mov         r12,rax
  not         r12
  inc         rax
  add         r15,r10
  add         r15,r12
  mov         byte ptr [rbx+r15],23h
  mov         qword ptr [r14+rdx*8],rax
  jmp         0000000140009D70
  nop         dword ptr [rax]
  mov         r15,qword ptr [r14+rdx*8]
  mov         r12,rdx
  inc         r12
  add         rcx,rax
  imul        r12,r10
  not         r15
  add         r12,r15
  mov         byte ptr [rbx+r12],4Fh
  inc         qword ptr [r14+rdx*8]
  inc         r9
  movzx       ebp,byte ptr [rdi+r8+6]
  mov         rax,r9
  cqo
  idiv        rax,r10
  cmp         ebp,4Fh
  je          0000000140009DB0
  cmp         ebp,23h
  jne         0000000140009DD0
  mov         r15,rdx
  imul        r15,r10
  mov         r12,rax
  not         r12
  inc         rax
  add         r15,r10
  add         r15,r12
  mov         byte ptr [rbx+r15],23h
  mov         qword ptr [r14+rdx*8],rax
  jmp         0000000140009DD0
  nop         dword ptr [rax]
  mov         r15,qword ptr [r14+rdx*8]
  mov         r12,rdx
  inc         r12
  add         rcx,rax
  imul        r12,r10
  not         r15
  add         r12,r15
  mov         byte ptr [rbx+r12],4Fh
  inc         qword ptr [r14+rdx*8]
  inc         r9
  movzx       ebp,byte ptr [rdi+r8+7]
  mov         rax,r9
  cqo
  idiv        rax,r10
  cmp         ebp,4Fh
  je          0000000140009B00
  cmp         ebp,23h
  jne         0000000140009B20
  mov         r15,rdx
  imul        r15,r10
  mov         r12,rax
  not         r12
  inc         rax
  add         r15,r10
  add         r15,r12
  mov         byte ptr [rbx+r15],23h
  mov         qword ptr [r14+rdx*8],rax
  jmp         0000000140009B20
  add         r8,8
  test        r11,r11
  je          0000000140009E9F
  mov         r9,qword ptr [14003FFD0h]
                    
  mov         rsi,qword ptr [14003FFE0h]
                    
  mov         rdi,qword ptr [14003FFF0h]
                    
  jmp         0000000140009E68
  nop         word ptr [rax+rax]
                    
  mov         rbx,qword ptr [rdi+rdx*8]
  mov         r14,rdx
  inc         r14
  add         rcx,rax
  imul        r14,r10
  not         rbx
  add         r14,rbx
  mov         byte ptr [rsi+r14],4Fh
  inc         qword ptr [rdi+rdx*8]
  inc         r8
  dec         r11
  je          0000000140009E9F
  mov         rax,r8
  cqo
  movzx       ebx,byte ptr [r9+r8]
  idiv        rax,r10
  cmp         ebx,4Fh
  je          0000000140009E40
  cmp         ebx,23h
  jne         0000000140009E60
  mov         rbx,rdx
  imul        rbx,r10
  mov         r14,rax
  not         r14
  inc         rax
  add         rbx,r10
  add         rbx,r14
  mov         byte ptr [rsi+rbx],23h
  mov         qword ptr [rdi+rdx*8],rax
  jmp         0000000140009E60
  mov         rax,rcx
  pop         rbx
  pop         rbp
  pop         rdi
  pop         rsi
  pop         r12
  pop         r14
  pop         r15
  ret
  nop         dword ptr [rax]