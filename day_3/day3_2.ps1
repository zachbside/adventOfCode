#Create Table of lines
$redLines = New-Object system.Data.DataTable “red”
$intersects = New-Object system.Data.DataTable "Intersects"
#Create columns
$redLines.columns.add("x", "int")
$redLines.columns.add("y", "int")
$redLines.columns.add("steps", "int")
$intersects.columns.add("x", "int")
$intersects.columns.add("y", "int")
$intersects.columns.add("steps", "int")

#Set primary key
[System.Data.DataColumn[]]$KeyColumn = ($redLines.Columns["x"],$redLines.Columns["y"])
$redLines.PrimaryKey=$KeyColumn

#Set primary key
[System.Data.DataColumn[]]$KeyColumn = ($intersects.Columns["x"],$intersects.Columns["y"])
$intersects.PrimaryKey=$KeyColumn

#start point
$x=0
$y=0
$steps=0
#Create a row
$row = $redLines.NewRow()
$redLines.Rows.Add($x,$y,$steps)

#Read in values
$rawInput = Get-Content -Path .\input2.txt 
$redInput = $rawInput[0].Split(",") -replace ',',"`n"
$greenInput = $rawInput[1].Split(",") -replace ',',"`n"


#insert the values of every traversed coordinate into the $lines table
for ($i = 0;$i -lt $redInput.Count;$i++) {
    $direction = $redInput[$i].Substring(0,1)
    [int]$distance = $redInput[$i].Substring(1,$redInput[$i].length-1)
    while ($distance -gt 0) {
        if ($direction -eq 'R') {
            $x+=1
            $row = $redLines.NewRow()
            $redLines.Rows.Add($x,$y,$steps)
        }
        if ($direction -eq 'L') {
            $x-=1
            $row = $redLines.NewRow()
            $redLines.Rows.Add($x,$y,$steps)
        }
    
        if ($direction -eq 'U') {
            $y+=1
            $row = $redLines.NewRow()
            $redLines.Rows.Add($x,$y,$steps)
        }
        
        if ($direction -eq 'D') {
            $y-=1
            $row = $redLines.NewRow()
            $redLines.Rows.Add($x,$y,$steps)
        }
        $steps++
        $distance--
    } 
}
$x=0
$y=0
$steps=0

#insert the values of every traversed coordinate into the $lines table
for ($i = 0;$i -lt $greenInput.Count;$i++) {
    $direction = $greenInput[$i].Substring(0,1)
    [int]$distance = $greenInput[$i].Substring(1,$greenInput[$i].length-1)
    while ($distance -gt 0) {
        
        if ($direction -eq 'R') {
            $x+=1
            try {$row = $redLines.NewRow()
                 $redLines.Rows.Add($x,$y)}
                catch {$row = $intersects.NewRow()
                    $stepsAdded = $redLines.Rows.Find(@($x,$y)) | select "steps"
                       $intersects.Rows.Add($x,$y,$steps+$stepsAdded.steps)}
        }

        if ($direction -eq 'L') {
            $x-=1
            try {$row = $redLines.NewRow()
                 $redLines.Rows.Add($x,$y)}
                catch {$row = $intersects.NewRow()
                    $stepsAdded = $redLines.Rows.Find(@($x,$y)) | select "steps"
                       $intersects.Rows.Add($x,$y,$steps+$stepsAdded.steps)}
        }
    
        if ($direction -eq 'U') {
            $y+=1
            try {$row = $redLines.NewRow()
                 $redLines.Rows.Add($x,$y)}
                catch {$row = $intersects.NewRow()
                    $stepsAdded = $redLines.Rows.Find(@($x,$y)) | select "steps"
                       $intersects.Rows.Add($x,$y,$steps+$stepsAdded.steps)}
        }
        
        if ($direction -eq 'D') {
            $y-=1
            try {$row = $redLines.NewRow()
                 $redLines.Rows.Add($x,$y)}
                catch {$row = $intersects.NewRow()
                    $stepsAdded = $redLines.Rows.Find(@($x,$y)) | select "steps"
                       $intersects.Rows.Add($x,$y,$steps+$stepsAdded.steps)}
        }
        $steps++
        $distance--
    } 
}

$stepsTotal

$intersects.Select("steps IS NOT NULL","steps ASC")
