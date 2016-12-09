
$Commands = Get-Content (Join-Path $PSScriptRoot day8.input) 
$MaxX = 50
$MaxY = 6

$Pixels = @(0) * $MaxY

for ($y = 0; $y -lt $MaxY; $y++)
{
    $Pixels[$y] = @(0) * $MaxX

    for ($x = 0; $x -lt $MaxX; $x++)
    {
        $Pixels[$y][$x] = " "
    }
}

foreach ($Command in $Commands)
{
    write-host $Command
    if ($Command -match "rect (?<x>\d+)x(?<y>\d+)")
    {
        for ($x = 0; $x -lt $matches.x; $x++)
        {
            for ($y = 0; $y -lt $matches.y; $y++)
            {
                $Pixels[$y][$x] = "#"
            }
        }
    }
    elseif ($Command -match "rotate column x=(?<x>\d+) by (?<d>\d+)")
    {
        $x = $matches.x
        $d = $matches.d
        $column = @()
        for ($y = 0; $y -lt $MaxY; $y++)
        {
            $column += $Pixels[$y][$x]
        }
        $column = $column[($MaxY-$d)..$MaxY] + $column[0..($MaxY-$d-1)]
        for ($y = 0; $y -lt $MaxY; $y++)
        {
            $Pixels[$y][$x] = $column[$y]
        }
    }
    elseif ($Command -match "rotate row y=(?<y>\d+) by (?<d>\d+)")
    {
        $y = $matches.y
        $d = $matches.d
        $Pixels[$y] = $Pixels[$y][($MaxX-$d)..$MaxX] + $Pixels[$y][0..($MaxX-$d-1)]
    }

    for ($y = 0; $y -lt 6; $y++)
    {
        $Line = ""
        for ($x = 0; $x -lt $MaxX; $x += 5)
        {
            $Line += $Pixels[$y][$x..($x+4)] -join ""
            $Line += " "
        }
        $Line
    }
}


$PixelsOn = 0
for ($y = 0; $y -lt $MaxY; $y++)
{
    for ($x = 0; $x -lt $MaxX; $x++)
    {
        if ($Pixels[$y][$x] -eq "#")
        {
            $PixelsOn++
        }
    }
}

Write-Host "Solution 1: $PixelsOn"