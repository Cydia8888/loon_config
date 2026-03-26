/*
 * SSDT-IGPU.dsl
 * 适用于：HP ProBook 450 G1
 * 核显：Intel HD 4600 (Haswell)
 * 功能：修复睡眠唤醒后重启黑屏问题
 */

DefinitionBlock ("SSDT-IGPU.aml", "SSDT", 2, "HACK", "IGPU", 0x00000000)
{
    External (_SB_.PCI0, DeviceObj)
    External (_SB_.PCI0.GFX0, DeviceObj)
    External (_SB_.PCI0.GFX0.DD02, DeviceObj)

    Scope (\_SB.PCI0.GFX0)
    {
        Method (_INI, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                If (CondRefOf (\_SB.PCI0.GFX0.DD02))
                {
                    \_SB.PCI0.GFX0.DD02._OFF ()
                    Sleep (200)
                    \_SB.PCI0.GFX0.DD02._ON ()
                }
            }
        }

        Method (_PS0, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Notify (\_SB.PCI0.GFX0, 0x00)
                Sleep (100)
                Notify (\_SB.PCI0.GFX0, 0x80)
            }
        }

        Method (_PS3, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Notify (\_SB.PCI0.GFX0, 0x81)
            }
        }
    }

    Scope (\_SB.PCI0)
    {
        Method (GPRW, 2, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                If (LEqual (Arg0, 0x6D))
                {
                    Return (Package (0x02)
                    {
                        0x6D,
                        0x00
                    })
                }
            }
            Return (Package (0x02)
            {
                Arg0,
                Arg1
            })
        }
    }
}