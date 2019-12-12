[int[]]$start = 3,7,2,0,3,7
[int[]]$end = 9,0,5,1,5,7

[int]$startNum=[string]$start[0]+$start[1]+$start[2]+$start[3]+$start[4]+$start[5]
[int]$endNum=[string]$end[0]+$end[1]+$end[2]+$end[3]+$end[4]+$end[5]

$iterations= $endNum-$startNum
$correctPasswords = 0

function Is-Doubled ($arrayInput) {
    for($i=0;$i -lt $arrayInput.Count; $i++) {
        if($arrayInput[$i] -eq $arrayInput[$i+1]) {
           if (($arrayInput[$i] -ne $arrayInput[$i+2]) -AND ($arrayInput[$i-1] -ne $arrayInput[$i])) {
                Return $True
           }
        }
    }
    Return $False
}

function Is-Increasing ($arrayInput) {
    for($i=0;$i -lt $arrayInput.Count-1; $i++) {
        if($arrayInput[$i] -gt $arrayInput[$i+1]) {
            Return $False
        }
    }
    Return $True
}

function Increase-Number ($arrayInput) {
    $arrayInput[5]+=1
    for($i=$arrayInput.Count-1;$i -gt 0;$i--) {
        if ($arrayInput[$i] -eq 10) {
            $arrayInput[$i] = 0
            $arrayInput[$i-1]+=1
        }
    }
}

for($i=0;$i -lt $iterations;$i++) {
    if((Is-Doubled($start) -eq $True) -AND (Is-Increasing($start) -eq $True)) {
        $correctPasswords++
    }
    Increase-Number($start)
}
$correctPasswords
