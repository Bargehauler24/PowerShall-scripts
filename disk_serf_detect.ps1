$ErrorActionPreference = "SilentlyContinue" #скрытие ошибок
$pcs = Get-ADComputer -Filter "OperatingSystem -notlike '*Server*'" | Where-Object {($_.Enabled -eq $true) } #командлит на выборку всех компов
foreach ($pc in $pcs){
    if (Test-Connection -ComputerName $pc.Name -Quiet -Count 1){
        $disk = Invoke-Command -ComputerName $pc.Name -ScriptBlock{Get-PSDrive -name R}
        if($disk.Description -eq 'ЭЦП'){
            Write-Host $pc.Name "есть диск " $disk.Name $disk.Description}
       }
}