swappp:
        addiu   $sp,$sp,-24
        sw      $fp,20($sp)
        move    $fp,$sp
        sw      $4,24($fp)
        sw      $5,28($fp)
        sw      $6,32($fp)
        lw      $2,28($fp)
        nop
        sll     $2,$2,2
        lw      $3,24($fp)
        nop
        addu    $2,$3,$2
        lw      $2,0($2)
        nop
        sw      $2,8($fp)
        lw      $2,32($fp)
        nop
        sll     $2,$2,2
        lw      $3,24($fp)
        nop
        addu    $3,$3,$2
        lw      $2,28($fp)
        nop
        sll     $2,$2,2
        lw      $4,24($fp)
        nop
        addu    $2,$4,$2
        lw      $3,0($3)
        nop
        sw      $3,0($2)
        lw      $2,32($fp)
        nop
        sll     $2,$2,2
        lw      $3,24($fp)
        nop
        addu    $2,$3,$2
        lw      $3,8($fp)
        nop
        sw      $3,0($2)
        nop
        move    $sp,$fp
        lw      $fp,20($sp)
        addiu   $sp,$sp,24
        jr      $31
        nop

indexMinimummmm
        addiu   $sp,$sp,-32
        sw      $fp,28($sp)
        move    $fp,$sp
        sw      $4,32($fp)
        sw      $5,36($fp)
        sw      $6,40($fp)
        lw      $2,36($fp)
        nop
        sw      $2,16($fp)
        lw      $2,36($fp)
        nop
        sll     $2,$2,2
        lw      $3,32($fp)
        nop
        addu    $2,$3,$2
        lw      $2,0($2)
        nop
        sw      $2,12($fp)
        lw      $2,36($fp)
        nop
        addiu   $2,$2,1
        sw      $2,8($fp)
        b       $L3
        nop

$L5:
        lw      $2,8($fp)
        nop
        sll     $2,$2,2
        lw      $3,32($fp)
        nop
        addu    $2,$3,$2
        lw      $2,0($2)
        lw      $3,12($fp)
        nop
        slt     $2,$2,$3
        beq     $2,$0,$L4
        nop

        lw      $2,8($fp)
        nop
        sw      $2,16($fp)
        lw      $2,8($fp)
        nop
        sll     $2,$2,2
        lw      $3,32($fp)
        nop
        addu    $2,$3,$2
        lw      $2,0($2)
        nop
        sw      $2,12($fp)
$L4:
        lw      $2,8($fp)
        nop
        addiu   $2,$2,1
        sw      $2,8($fp)
$L3:
        lw      $3,8($fp)
        lw      $2,40($fp)
        nop
        slt     $2,$2,$3
        beq     $2,$0,$L5
        nop

        lw      $2,16($fp)
        move    $sp,$fp
        lw      $fp,28($sp)
        addiu   $sp,$sp,32
        jr      $31
        nop

selectionSorttt
        addiu   $sp,$sp,-40
        sw      $31,36($sp)
        sw      $fp,32($sp)
        move    $fp,$sp
        sw      $4,40($fp)
        sw      $5,44($fp)
        sw      $0,24($fp)
        b       $L8
        nop

$L9:
        lw      $2,44($fp)
        nop
        addiu   $2,$2,-1
        move    $6,$2
        lw      $5,24($fp)
        lw      $4,40($fp)
        jal     indexMinimummmm
        nop

        sw      $2,28($fp)
        lw      $6,28($fp)
        lw      $5,24($fp)
        lw      $4,40($fp)
        jal     swappp
        nop

        lw      $2,24($fp)
        nop
        addiu   $2,$2,1
        sw      $2,24($fp)
$L8:
        lw      $2,44($fp)
        nop
        addiu   $2,$2,-1
        lw      $3,24($fp)
        nop
        slt     $2,$3,$2
        bne     $2,$0,$L9
        nop

        nop
        nop
        move    $sp,$fp
        lw      $31,36($sp)
        lw      $fp,32($sp)
        addiu   $sp,$sp,40
        jr      $31
        nop

$LC0:
        .ascii  "Insert the array size\000"
$LC1:
        .ascii  "Insert the array elements, one per line\000"
$LC2:
        .ascii  "The sorted array is:\000"
main:
        addiu   $sp,$sp,-48
        sw      $31,44($sp)
        sw      $fp,40($sp)
        move    $fp,$sp
        lui     $2,%hi($LC0)
        addiu   $5,$2,%lo($LC0)
        lui     $2,%hi(_ZSt4cout)
        addiu   $4,$2,%lo(_ZSt4cout)
        jal     std::basic_ostream<char, std::char_traits<char> >& std::operator<< <std::char_traits<char> >(std::basic_ostream<char, std::char_traits<char> >&, char const*)
        nop

        move    $3,$2
        lui     $2,%hi(_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_)
        addiu   $5,$2,%lo(_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_)
        move    $4,$3
        jal     std::basic_ostream<char, std::char_traits<char> >::operator<<(std::basic_ostream<char, std::char_traits<char> >& (*)(std::basic_ostream<char, std::char_traits<char> >&))
        nop

        addiu   $2,$fp,32
        move    $5,$2
        lui     $2,%hi(_ZSt3cin)
        addiu   $4,$2,%lo(_ZSt3cin)
        jal     std::basic_istream<char, std::char_traits<char> >::operator>>(int&)
        nop

        lw      $2,32($fp)
        li      $3,536870912                        # 0x20000000
        sltu    $3,$2,$3
        beq     $3,$0,$L11
        nop

        sll     $2,$2,2
        move    $4,$2
        jal     operator new[](unsigned int)
        nop

        sw      $2,28($fp)
        lui     $2,%hi($LC1)
        addiu   $5,$2,%lo($LC1)
        lui     $2,%hi(_ZSt4cout)
        addiu   $4,$2,%lo(_ZSt4cout)
        jal     std::basic_ostream<char, std::char_traits<char> >& std::operator<< <std::char_traits<char> >(std::basic_ostream<char, std::char_traits<char> >&, char const*)
        nop

        move    $3,$2
        lui     $2,%hi(_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_)
        addiu   $5,$2,%lo(_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_)
        move    $4,$3
        jal     std::basic_ostream<char, std::char_traits<char> >::operator<<(std::basic_ostream<char, std::char_traits<char> >& (*)(std::basic_ostream<char, std::char_traits<char> >&))
        nop

        sw      $0,24($fp)
        b       $L13
        nop

$L11:
        jal     __cxa_throw_bad_array_new_length
        nop

$L14:
        lw      $2,24($fp)
        nop
        sll     $2,$2,2
        lw      $3,28($fp)
        nop
        addu    $2,$3,$2
        move    $5,$2
        lui     $2,%hi(_ZSt3cin)
        addiu   $4,$2,%lo(_ZSt3cin)
        jal     std::basic_istream<char, std::char_traits<char> >::operator>>(int&)
        nop

        lw      $2,24($fp)
        nop
        addiu   $2,$2,1
        sw      $2,24($fp)
$L13:
        lw      $2,32($fp)
        lw      $3,24($fp)
        nop
        slt     $2,$3,$2
        bne     $2,$0,$L14
        nop

        lw      $2,32($fp)
        nop
        move    $5,$2
        lw      $4,28($fp)
        jal     selectionSort(int*, int)
        nop

        lui     $2,%hi($LC2)
        addiu   $5,$2,%lo($LC2)
        lui     $2,%hi(_ZSt4cout)
        addiu   $4,$2,%lo(_ZSt4cout)
        jal     std::basic_ostream<char, std::char_traits<char> >& std::operator<< <std::char_traits<char> >(std::basic_ostream<char, std::char_traits<char> >&, char const*)
        nop

        move    $3,$2
        lui     $2,%hi(_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_)
        addiu   $5,$2,%lo(_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_)
        move    $4,$3
        jal     std::basic_ostream<char, std::char_traits<char> >::operator<<(std::basic_ostream<char, std::char_traits<char> >& (*)(std::basic_ostream<char, std::char_traits<char> >&))
        nop

        sw      $0,24($fp)
        b       $L15
        nop

$L16:
        lw      $2,24($fp)
        nop
        sll     $2,$2,2
        lw      $3,28($fp)
        nop
        addu    $2,$3,$2
        lw      $2,0($2)
        nop
        move    $5,$2
        lui     $2,%hi(_ZSt4cout)
        addiu   $4,$2,%lo(_ZSt4cout)
        jal     std::basic_ostream<char, std::char_traits<char> >::operator<<(int)
        nop

        move    $3,$2
        lui     $2,%hi(_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_)
        addiu   $5,$2,%lo(_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_)
        move    $4,$3
        jal     std::basic_ostream<char, std::char_traits<char> >::operator<<(std::basic_ostream<char, std::char_traits<char> >& (*)(std::basic_ostream<char, std::char_traits<char> >&))
        nop

        lw      $2,24($fp)
        nop
        addiu   $2,$2,1
        sw      $2,24($fp)
$L15:
        lw      $2,32($fp)
        lw      $3,24($fp)
        nop
        slt     $2,$3,$2
        bne     $2,$0,$L16
        nop

        move    $2,$0
        move    $sp,$fp
        lw      $31,44($sp)
        lw      $fp,40($sp)
        addiu   $sp,$sp,48
        jr      $31
        nop

__static_initialization_and_destruction_0(int, int):
        addiu   $sp,$sp,-32
        sw      $31,28($sp)
        sw      $fp,24($sp)
        move    $fp,$sp
        sw      $4,32($fp)
        sw      $5,36($fp)
        lw      $3,32($fp)
        li      $2,1                        # 0x1
        bne     $3,$2,$L20
        nop

        lw      $3,36($fp)
        li      $2,65535                    # 0xffff
        bne     $3,$2,$L20
        nop

        lui     $2,%hi(_ZStL8__ioinit)
        addiu   $4,$2,%lo(_ZStL8__ioinit)
        jal     std::ios_base::Init::Init() [complete object constructor]
        nop

        lui     $2,%hi(__dso_handle)
        addiu   $6,$2,%lo(__dso_handle)
        lui     $2,%hi(_ZStL8__ioinit)
        addiu   $5,$2,%lo(_ZStL8__ioinit)
        lui     $2,%hi(_ZNSt8ios_base4InitD1Ev)
        addiu   $4,$2,%lo(_ZNSt8ios_base4InitD1Ev)
        jal     __cxa_atexit
        nop

$L20:
        nop
        move    $sp,$fp
        lw      $31,28($sp)
        lw      $fp,24($sp)
        addiu   $sp,$sp,32
        jr      $31
        nop

_GLOBAL__sub_I_swappp:
        addiu   $sp,$sp,-32
        sw      $31,28($sp)
        sw      $fp,24($sp)
        move    $fp,$sp
        li      $5,65535                    # 0xffff
        li      $4,1                        # 0x1
        jal     __static_initialization_and_destruction_0(int, int)
        nop

        move    $sp,$fp
        lw      $31,28($sp)
        lw      $fp,24($sp)
        addiu   $sp,$sp,32
        jr      $31
        nop