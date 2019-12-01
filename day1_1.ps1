$fuelSum = 0
[decimal[]]$inputs = Get-Content -Path .\input.txt
for ($i=0;$i -le $inputs.Length-1;$i++) {
    $inputs[$i] = [math]::Floor($inputs[$i]/3)-2
    $fuelSum += $inputs[$i]
}
$fuelSum
