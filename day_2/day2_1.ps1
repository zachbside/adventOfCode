$rawInput = Get-Content -Path .\input.txt -Delimiter ','
[int[]]$intcode = $rawInput -replace ',' -replace ''
$intcode[1] = 12
$intcode[2] = 2
$framestart = 0
while (0 -eq 0) {
    if ($intcode[$framestart] -eq 1) {
        $first = $intcode[$framestart+1]
        $second= $intcode[$framestart+2]
        $final = $intcode[$framestart+3]
        $intcode[$final] = $intcode[$first] + $intcode[$second]
    }
    if ($intcode[$framestart] -eq 2) {
        $first = $intcode[$framestart+1]
        $second= $intcode[$framestart+2]
        $final = $intcode[$framestart+3]
        $intcode[$final] = $intcode[$first] * $intcode[$second]
    }
    if ($intcode[$framestart] -eq 99){
        $intcode[0]
        exit
    }
    $framestart +=4
}
