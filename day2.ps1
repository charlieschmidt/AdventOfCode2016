function day2
{
    param($NumberPad,[int]$x,[int]$y,$content)

    process
    {
        $Lines = $Content -split "`n"
        
        foreach ($Line in $Lines)
        {
            foreach ($Move in $Line.ToCharArray())
            {
                switch ($Move)
                {
                    "U" {
                        if ($NumberPad[$y-1][$x] -ne 0)
                        {
                            $y--
                        }
                    }
                    "D" {
                        if ($NumberPad[$y+1][$x] -ne 0)
                        {
                            $y++
                        }
                    }
                    "L" {
                        if ($NumberPad[$y][$x-1] -ne 0)
                        {
                            $x--
                        }
                    }
                    "R" {
                        if ($NumberPad[$y][$x+1] -ne 0)
                        {
                            $x++
                        }
                    }
                }
            }
            Write-Host $NumberPad[$y][$x]
        }
    }
}

$Content = Get-Content .\day2.input -raw



$NumberPad = @(
                @(0,0,0,0,0),
                @(0,1,2,3,0),
                @(0,4,5,6,0),
                @(0,7,8,9,0),
                @(0,0,0,0,0)
            )

$x = [int]2;
$y = [int]2;

write-host "Solution 1:"
day2 $NumberPad $x $y $Content

$NumberPad = @(
                @(0,0,0,0,0,0,0),
                @(0,0,0,1,0,0,0),
                @(0,0,2,3,4,0,0),
                @(0,5,6,7,8,9,0),
                @(0,0,'A','B','C',0,0),
                @(0,0,0,'D',0,0,0),
                @(0,0,0,0,0,0,0)
            )
$x = [int]1;
$y = [int]3;

write-host "Solution 2:"
day2 $NumberPad $x $y $Content