while (0 -eq 0) {
    $rawInput = Get-Content -Path .\input.txt -Delimiter ','
    [int[]]$intcode = $rawInput -replace ',' -replace ''
    $intcode[1] = Get-Random -Minimum 0 -Maximum 99
    $intcode[2] = Get-Random -Minimum 0 -Maximum 99
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
            if ($intcode[0] -eq 19690720) {
                100 * $intcode[1] + $intcode[2]
                exit
            }
            $rawInput = Get-Content -Path .\input.txt -Delimiter ','
            [int[]]$intcode = $rawInput -replace ',' -replace ''
            $intcode[1] = Get-Random -Minimum 0 -Maximum 99
            $intcode[2] = Get-Random -Minimum 0 -Maximum 99
            $framestart = 0
        }
    $framestart +=4
    }
}
