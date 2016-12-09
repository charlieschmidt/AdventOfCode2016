
$Encrypted = Get-Content (Join-Path $PSScriptRoot day9.input)

#$Encrypted = '(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN'

$LengthPart1 = 0
$LengthPart2 = 0

function Decrypt($Encrypted,$Recurse)
{
    [long]$Length = 0
    while ($Encrypted.IndexOf("(") -ne -1)
    {
        $i = 0
        $NextOpenParen = $Encrypted.IndexOf("(")
        

        $Length += $NextOpenParen
        $i += $NextOpenParen
    
        $NextClosedParen = $Encrypted.IndexOf(")")
    
        $Command = $Encrypted.Substring($NextOpenParen + 1, $NextClosedParen - $NextOpenParen - 1)
        $i += $Command.Length + 2
        if ($Command -match "(?<l>\d+)x(?<x>\d+)")
        {
            [long]$l = $matches.l
            [long]$x = $Matches.x
            if ($Recurse -eq $true)
            {
                $v = $Encrypted.Substring($NextClosedParen + 1, $l)
                $Length += ((Decrypt ($v) $Recurse) * $x)
            }
            else
            {
                $Length += ($l * $x)
            }

            $i += $l
        }

        $Encrypted = $Encrypted.Substring($i,$Encrypted.Length-$i)
      
    }
    
    $Length += $Encrypted.Length
    

    $Length | Write-Output
}

$Encrypted1 = $Encrypted
$LengthPart1 = Decrypt ($Encrypted1) $false    

$Encrypted2 = $Encrypted
$LengthPart2 = Decrypt ($Encrypted2) $true    

write-host "Solution 1: $($LengthPart1)"
write-host "Solution 2: $($LengthPart2)"