#Create Table of lines
$redLines = New-Object system.Data.DataTable “red”
$intersects = New-Object system.Data.DataTable "Intersects"
#Create columns
$redLines.columns.add("x", "int")
$redLines.columns.add("y", "int")
$intersects.columns.add("x", "int")
$intersects.columns.add("y", "int")

#Set primary key
[System.Data.DataColumn[]]$KeyColumn = ($redLines.Columns["x"],$redLines.Columns["y"])
$redLines.PrimaryKey=$KeyColumn

#start point
$x=0
$y=0

#Create a default row
$row = $redLines.NewRow()
$redLines.Rows.Add($x,$y)

#Read in values
$rawInput = Get-Content -Path .\input.txt 
$redInput = $rawInput[0].Split(",") -replace ',',"`n"
$greenInput = $rawInput[1].Split(",") -replace ',',"`n"


#insert the values of every traversed coordinate into the $redLines table
#try/catch is used to avoid primary key violation
for ($i = 0;$i -lt $redInput.Count;$i++) {
    $direction = $redInput[$i].Substring(0,1)
    [int]$distance = $redInput[$i].Substring(1,$redInput[$i].length-1)
    while ($distance -gt 0) {
        if ($direction -eq 'R') {
            $x+=1
            $row = $redLines.NewRow()
            try {$redLines.Rows.Add($x,$y)}
                catch{}
        }
        if ($direction -eq 'L') {
            $x-=1
            $row = $redLines.NewRow()
            try{$redLines.Rows.Add($x,$y)}
                catch{}
        }
    
        if ($direction -eq 'U') {
            $y+=1
            $row = $redLines.NewRow()
            try{$redLines.Rows.Add($x,$y)}
                catch{}
        }
        
        if ($direction -eq 'D') {
            $y-=1
            $row = $redLines.NewRow()
            try{$redLines.Rows.Add($x,$y)}
                catch{}
        }
        $distance--
    } 
}
$x=0
$y=0
#insert the values of every intersect based on primary key violation
#the catch block will insert the values into the intersects table instead of redLines
for ($i = 0;$i -lt $greenInput.Count;$i++) {
    $direction = $greenInput[$i].Substring(0,1)
    [int]$distance = $greenInput[$i].Substring(1,$greenInput[$i].length-1)
    while ($distance -gt 0) {
        if ($direction -eq 'R') {
            $x+=1
            try {$row = $redLines.NewRow()
                 $redLines.Rows.Add($x,$y)}
                catch {$row = $intersects.NewRow()
                       $intersects.Rows.Add($x,$y)}
        }

        if ($direction -eq 'L') {
            $x-=1
            try {$row = $redLines.NewRow()
                 $redLines.Rows.Add($x,$y)}
                catch {$row = $intersects.NewRow()
                       $intersects.Rows.Add($x,$y)}
        }
    
        if ($direction -eq 'U') {
            $y+=1
            try {$row = $redLines.NewRow()
                 $redLines.Rows.Add($x,$y)}
                catch {$row = $intersects.NewRow()
                       $intersects.Rows.Add($x,$y)}
        }
        
        if ($direction -eq 'D') {
            $y-=1
            try {$row = $redLines.NewRow()
                 $redLines.Rows.Add($x,$y)}
                catch {$row = $intersects.NewRow()
                       $intersects.Rows.Add($x,$y)}
        }

        $distance--
    } 
}
#find the manhattan distance from the intersects table
$minDist = 10000
for ($i=0;$i -lt $intersects.Rows.Count;$i++) {
    if ([Math]::Abs($intersects.Rows.x[$i]) + [Math]::Abs($intersects.Rows.y[$i]) -lt $minDist) {
        $minDist = [Math]::Abs($intersects.Rows.x[$i]) + [Math]::Abs($intersects.Rows.y[$i])
    }
}
$minDist
