DefinitionBlock("", "SSDT", 2, "ACDT", "PTSWAK", 0)
{  
    External(ZPTS, MethodObj)
    External(ZWAK, MethodObj)
    External(EXT1, MethodObj)
    External(EXT2, MethodObj)
    External(EXT3, MethodObj)
    External(EXT4, MethodObj)
    External (_SB_.PCI0.PEG0.PEGP._OFF, MethodObj)    // 0 Arguments (from opcode)  
    
    Scope (_SB)
    {
        Device (PCI9)
        {
            Name (_ADR, Zero)
            Name (FNOK, Zero)
            Name (MODE, Zero)
        }
    }   
    
    Method (_PTS, 1, NotSerialized) //Method (_PTS, 1, Serialized)
    {
        If (_OSI ("Darwin"))
        {
            if(\_SB.PCI9.FNOK ==1)
            {
                Arg0 = 3
            }
            If (CondRefOf(EXT1))
            {
                EXT1(Arg0)
            }
            If (CondRefOf(EXT2))
            {
                EXT2(Arg0)
            }
        }

        ZPTS(Arg0)
    }
    
    Method (_WAK, 1, NotSerialized) //Method (_WAK, 1, Serialized)
    {   
        If (_OSI ("Darwin"))
        {
            if(\_SB.PCI9.FNOK ==1)
            {
                \_SB.PCI9.FNOK =0
                Arg0 = 3
            }
            If (CondRefOf(EXT3))
            {
                EXT3(Arg0)
            }
            If (CondRefOf(EXT4))
            {
                EXT4(Arg0)
            }
            // Disabled dGPU after wake up
            \_SB.PCI0.PEG0.PEGP._OFF ()
        }

        Local0 = ZWAK(Arg0)
        Return (Local0)
    }
}