
$Messages = Get-Content (Join-Path $PSScriptRoot day6.input) 



[hashtable[]]$MostCommon = @()
for ($i = 0; $i -lt $Messages[0].Length; $i++)
{

  $MostCommon += @{}
}

foreach ($InputLine in $Messages)
{
    $Characters = $InputLine.ToCharArray()
    for ($i = 0; $i -lt $Characters.Count; $i++)
    {
        if ($MostCommon[$i].Contains($Characters[$i]))
        {
            $MostCommon[$i][$Characters[$i]]++
        }
        else
        {
            $MostCommon[$i][$Characters[$i]] = 1
        }
    }


}

$Message1 = ""
$Message2 = ""

foreach ($Character in $MostCommon)
{
    $Message1 += $Character.GetEnumerator() | sort value -Descending | select -First 1 -expand name
    $Message2 += $Character.GetEnumerator() | sort value  | select -First 1 -expand name
}

Write-host "Solution 1: $Message1"
Write-host "Solution 2: $Message2"
