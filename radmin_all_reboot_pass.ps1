#$z = Get-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Radmin\v3.0\Server\Parameters\Radmin Security\1"
#Set-Content C:\admin.txt $z.1
$reg =gc D:\test4.txt
$ErrorActionPreference = "SilentlyContinue" #скрытие ошибок
$pcs = Get-ADComputer -Filter "OperatingSystem -notlike '*Server*'" | Where-Object {($_.Enabled -eq $true) } #командлит на выборку всех компов
foreach ($pc in $pcs){
    if (Test-Connection -ComputerName $pc.Name -Quiet -Count 1){
        Invoke-Command -ComputerName $pc.Name -ScriptBlock {Remove-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Radmin\v3.0\Server\Parameters\Radmin Security\1" -Name 1}
        Invoke-Command -ComputerName $pc.Name -ScriptBlock {New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Radmin\v3.0\Server\Parameters\Radmin Security\1" -Name 1 -PropertyType Binary -Value $using:reg }
        Write-Host $pc.Name "смена пароля произошла успешна"
    } else {
        Write-Host $pc.Name "не подключился"
    }

}