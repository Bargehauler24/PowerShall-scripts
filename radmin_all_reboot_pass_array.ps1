$reg =gc D:\test4.txt
$mass = gc D:\tr.txt
$ErrorActionPreference = "SilentlyContinue" #скрытие ошибок
$array = $mass
#$pcs = Get-ADComputer -Filter "OperatingSystem -notlike '*Server*'" | Where-Object {($_.Enabled -eq $true) } #командлит на выборку всех компов
foreach ($pc in $array){
    if (Test-Connection -ComputerName $pc -Quiet -Count 1){
        Invoke-Command -ComputerName $pc -ScriptBlock {Remove-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Radmin\v3.0\Server\Parameters\Radmin Security\1" -Name 1}
        Invoke-Command -ComputerName $pc -ScriptBlock {New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Radmin\v3.0\Server\Parameters\Radmin Security\1" -Name 1 -PropertyType Binary -Value $using:reg }
        Write-Host $pc "смена пароля произошла успешна"
    } else {
        Write-Host $pc "не подключился"
    }

}