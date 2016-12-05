

#$Input = "abc"

$Input = "abbhdwsy"

$MD5 = new-object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
$UTF8 = new-object -TypeName System.Text.UTF8Encoding

$PasskeyPart1 = ""
$PasskeyPart2 = @('-','-','-','-','-','-','-','-')

[uint64]$I = 1

while ($PasskeyPart1.Length -lt 8 -or $PasskeyPart2.Contains('-'))
{
    $Try = $Input+$I
    $Hash = [System.BitConverter]::ToString($MD5.ComputeHash($UTF8.GetBytes($Try)))

    if ($I % 10000 -eq 0)
    {
        Write-Host "$I - '$PasskeyPart1' / '$($PasskeyPart2 -Join '')'"
    }

    if ($Hash.Substring(0,7) -eq '00-00-0')
    {
        if ($PasskeyPart1.Length -lt 8)
        {
            $PasskeyPart1 += $Hash[7]
        }

        [int]$Position = (([int]$Hash[7])-48)

        if ($Position -lt 8 -and $PasskeyPart2[$Position] -eq '-')
        {
            $PasskeyPart2[$Position] = $Hash[9]
        }
    }
    
    $I++
}

Write-Host "Solution 1: $PasskeyPart1"
Write-Host "Solution 2: " ($PasskeyPart2 -Join '')
