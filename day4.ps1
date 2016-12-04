

$Content = Get-Content .\day4.input -raw

$Rooms = $Content -split "`n"
$ValidRoomSectorIDSum = 0

foreach ($RoomLine in $Rooms)
{
    $ActualRoomName = ""

    if ($RoomLine -match '([-a-z]+)-([0-9]+)\[([a-z]*)\]')
    {
        $RoomName = $Matches[1]
        $SectorID = [int]$Matches[2]
        $Checksum = $Matches[3]
        $CharacterFrequency = @{}

        foreach ($Character in $RoomName.ToCharArray())
        {  
            if ($Character -eq "-")
            {
                $ActualRoomName += " "
                continue
            }
            else
            {
                $CharacterCode = [convert]::ToInt32($Character)
                $ShiftedCharacterCode = ((($CharacterCode - 97) + $SectorId) % 26) + 97
                $ActualRoomName += [convert]::ToChar($ShiftedCharacterCode)
            }
            if ($CharacterFrequency.Contains($Character))
            {
                $CharacterFrequency[$Character]++
            }
            else
            {
                $CharacterFrequency[$Character] = 1
            }

        }

        $ActualChecksum = ""
        $CharacterFrequency.GetEnumerator() | Sort-Object @{expression="Value";Descending=$true},@{expression="Key";Ascending=$true} | Select-Object -First 5 | Foreach-Object {$ActualChecksum += $_.Key}
        
        if ($Checksum -eq $ActualChecksum)
        {
            $ValidRoomSectorIDSum += $SectorId
        }

        if ($ActualRoomName -ilike "*object*")
        {
            Write-Host "$ActualRoomName $SectorID"
        }

    }
    else 
    {
        write-host "No match for $RoomLine"
    }
}


Write-host "Solution 1: $ValidRoomSectorIDSum"