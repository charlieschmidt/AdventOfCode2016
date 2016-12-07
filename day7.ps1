
$Messages = Get-Content (Join-Path $PSScriptRoot day7.input) 

$SupportTLS = 0
$SupportSSL = 0

foreach ($Message in $Messages)
{
    $TLSValid = $null
    $Outside = $true
    for ($i = 0; $i -lt $Message.Length - 3; $i++)
    {
        $Abba = $Message.Substring($i,4)
        if ($Abba[0] -eq '[')
        {
            $Outside = $false
            continue
        }
        if ($Abba[0] -eq ']')
        {
            $Outside = $true
            continue
        }
        if ($Abba[0] -eq $Abba[3] -and $Abba[1] -eq $Abba[2] -and $Abba[0] -ne $Abba[1])
        {
            if ($Outside)
            {
                $TLSValid = $true
            }
            else
            {
                $TLSValid = $false
                $i = $Message.Length
            }
        }
    }
    if ($TLSValid)
    {
        $SupportTLS++
    }




    $Outside = $true
    $InsideABAs = @()
    $OutsideABAs = @()
    for ($i = 0; $i -lt $Message.Length - 2; $i++)
    {
        $ABA = $Message.Substring($i,3)
        if ($Aba[0] -eq '[')
        {
            $Outside = $false
            continue
        }
        if ($Aba[0] -eq ']')
        {
            $Outside = $true
            continue
        }

        if ($ABA[0] -eq $ABA[2] -and $ABA[0] -ne $ABA[1])
        {
            if ($Outside)
            {
                $OutsideABAs += "{0}{1}{0}" -f $ABA[1],$ABA[0]
            }
            else
            {
                $InsideABAs += $ABA
            }

        }
    }
    if ($InsideABAs | Where-Object {$OutsideABAs -contains $_})
    {
        $SupportSSL++
    }
}

Write-Host "Solution 1: $SupportTLS"
Write-Host "Solution 2: $SupportSSL"