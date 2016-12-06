process
{

    $Content = Get-Content (Join-Path $PSScriptRoot day1.input)  -raw
    $Moves = $Content -split ","
    [int]$x = 0
    [int]$y = 0
    $facing = "N"
    $VisitedLocations = @{"0,0" = 1}
    $HeadQuartersX = $null
    $HeadQuartersY = $null

    foreach ($Move in $Moves)
    {
        $Move = $Move.Trim();
        $TurnDirection = $Move.Substring(0,1)
        $Distance = [int]$Move.Substring(1,$Move.Length-1);

        switch ($Facing+$TurnDirection)
        {
            "NR" { $Facing = "E"; }
            "NL" { $Facing = "W"; }
            "ER" { $Facing = "S"; }
            "EL" { $Facing = "N"; }
            "SR" { $Facing = "W"; }
            "SL" { $Facing = "E"; }
            "WR" { $Facing = "N"; }
            "WL" { $Facing = "S"; }
        }

        switch ($Facing)
        {
            "E" {
                while ($Distance -gt 0)
                {
                    $x++
                    $Distance--
                    if ($null -eq $HeadQuartersX -and $VisitedLocations.Contains("$x,$y"))
                    {
                        $HeadQuartersX = $x
                        $HeadQuartersY = $y
                    }
                    else 
                    {
                        $VisitedLocations["$x,$y"] = 1;
                    }
                }
            }    
            "W" {
                while ($Distance -gt 0)
                {
                    $x--
                    $Distance--
                    if ($null -eq $HeadQuartersX -and $VisitedLocations.Contains("$x,$y"))
                    {
                        $HeadQuartersX = $x
                        $HeadQuartersY = $y
                    }
                    else 
                    {
                        $VisitedLocations["$x,$y"] = 1;
                    }
                }
            }
            "N" {
                while ($Distance -gt 0)
                {
                    $y++
                    $Distance--
                    if ($null -eq $HeadQuartersX -and $VisitedLocations.Contains("$x,$y"))
                    {
                        $HeadQuartersX = $x
                        $HeadQuartersY = $y
                    }
                    else 
                    {
                        $VisitedLocations["$x,$y"] = 1;
                    }
                }
            }
            "S" {
                while ($Distance -gt 0)
                {
                    $y--
                    $Distance--
                    if ($null -eq $HeadQuartersX -and $VisitedLocations.Contains("$x,$y"))
                    {
                        $HeadQuartersX = $x
                        $HeadQuartersY = $y
                    }
                    else 
                    {
                        $VisitedLocations["$x,$y"] = 1;
                    }
                }
            }
        }
    }

    if ($x -lt 0) { $x = $x * -1}
    if ($y -lt 0) { $y = $y * -1}
    Write-Host "Solution 1: $($x+$y)"

    if ($HeadQuartersX -lt 0) { $HeadQuartersX = $HeadQuartersX * -1}
    if ($HeadQuartersY -lt 0) { $HeadQuartersY = $HeadQuartersY * -1}
    Write-Host "Solution 2: $($HeadQuartersX + $HeadQuartersY)"

}
