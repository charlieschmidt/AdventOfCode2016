
$Commands = Get-Content (Join-Path $PSScriptRoot day10.input) 

$BotValues = @{}
$BotInstructions = @{}
$OutputBins = @{}


foreach ($Command in $Commands)
{
    if ($Command -match "value (?<value>\d+) goes to bot (?<bot>\d+)")
    {
        $BotValues[[int]$matches.bot] += @([int]$matches.value)
    }
    elseif ($Command -match "bot (?<source>\d+) gives low to (?<low>\w+) (?<lowdest>\d+) and high to (?<high>\w+) (?<highdest>\d+)")
    {
        $BotInstructions[[int]$matches.source] = @{
            "low" = @{
                "type" = $matches.low
                "destination" = [int]$matches.lowdest
            }
            "high" = @{
                "type" = $matches.high
                "destination" = [int]$matches.highdest
            }
        }
    }
}


$Solution1 = -1

do
{
    $ABotHasTwo = $false
        
    foreach ($b in $BotInstructions.Keys)
    {
        if ($BotValues[$b].Length -eq 2)
        {
            $High = $BotValues[$b] | Sort-Object -Descending | Select-Object -First 1
            $Low = $BotValues[$b] | Sort-Object | Select-Object -First 1
            
            if ($High -eq 61 -and $Low -eq 17)
            {
                $Solution1 = $b
            }
            if ($BotInstructions[$b]["low"]["type"] -eq "bot")
            {
                $BotValues[$BotInstructions[$b]["low"]["destination"]] += @($Low)
            }
            else 
            {
                $OutputBins[$BotInstructions[$b]["low"]["destination"]] += @($Low)
            }

            if ($BotInstructions[$b]["high"]["type"] -eq "bot")
            {
                $BotValues[$BotInstructions[$b]["high"]["destination"]] += @($High)
            }
            else 
            {
                $OutputBins[$BotInstructions[$b]["high"]["destination"]] += @($High)
            }

            $BotValues[$b] = @()
        }
    }

    foreach ($V in $BotValues.Values)
    {
        if ($V.Length -eq 2)
        {
            $ABotHasTwo = $true
        }
    }


} while ($ABotHasTwo -eq $true)


Write-Host "Solution 1: $Solution1"

Write-Host "Solution 2: $($OutputBins[0][0] * $OutputBins[1][0] * $OutputBins[2][0])"