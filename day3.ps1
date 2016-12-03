process
{

    $Content = Get-Content .\day3.input -raw

    $TrianglePossibilities = $Content -split "`n"
    $ValidTriangles = 0
    $ValidTriangles2 = 0
    
    for ($i = 0; $i -lt $TrianglePossibilities.Count; $i++)
    {
        $Triangle = $TrianglePossibilities[$i].Trim()
        $Sides = ($Triangle -replace '(\s+)',"`t") -split "`t"

        #part 1
        $a = [int]$Sides[0]
        $b = [int]$Sides[1]
        $c = [int]$Sides[2]
        if (($a + $b -gt $c) -and ($b + $c -gt $a) -and ($c + $a -gt $b)) 
        {
            $ValidTriangles++
        }


        #part 2
        if ($i -lt $TrianglePossibilities.Count-2 -and $i % 3 -eq 0)
        {
            $Triangle2 = $TrianglePossibilities[$i+1].Trim()
            $Sides2 = ($Triangle2 -replace '(\s+)',"`t") -split "`t"
            $Triangle3 = $TrianglePossibilities[$i+2].Trim()
            $Sides3 = ($Triangle3 -replace '(\s+)',"`t") -split "`t"

            for ($j = 0; $j -lt 3; $j++)
            {
                $a = [int]$Sides[$j]
                $b = [int]$Sides2[$j]
                $c = [int]$Sides3[$j]
                if (($a + $b -gt $c) -and ($b + $c -gt $a) -and ($c + $a -gt $b)) 
                {
                    $ValidTriangles2++
                }
            }

        }
        
    }
    Write-Host "Solution 1: $ValidTriangles"
    Write-Host "Solution 2: $ValidTriangles2"


}
