$fuelSum = 0
[decimal[]]$inputs = Get-Content -Path .\input.txt
for ($i=0;$i -le $inputs.Length-1;$i++) {
    [decimal]$recurFuel = 0
    $recurFuelSum =0
    $inputs[$i] = [math]::Floor($inputs[$i]/3)-2
    $fuelSum += $inputs[$i]
    $recurFuel = $inputs[$i]
    while ($recurFuel -ge 9) {
        $recurFuel = [math]::Floor($recurFuel/3)-2
        $recurFuelSum += $recurFuel
    }
    $fuelSum += $recurFuelSum
}
$fuelSum
