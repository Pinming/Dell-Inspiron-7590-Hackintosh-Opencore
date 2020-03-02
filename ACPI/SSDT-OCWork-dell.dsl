//
DefinitionBlock("", "SSDT", 2, "ACDT", "OCWork", 0)
{
    External (_SB.ACOS, IntObj)
    External (_SB.ACSE, IntObj)
    
    Scope (\)
    {
        If (_OSI ("Darwin"))
        {
            \_SB.ACOS = 0x80 // Linux: 0x40, Win: 1
            \_SB.ACSE = 0x03 //ACSE=0:win7;ACSE=1:win8;ACSE=3:window10
        }
    }
}
//EOF
