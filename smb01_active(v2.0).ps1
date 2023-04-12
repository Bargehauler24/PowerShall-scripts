$ErrorActionPreference = "SilentlyContinue" #скрытие ошибок
$pcs = Get-ADComputer -Filter "OperatingSystem -notlike '*Server*'" | Where-Object {($_.Enabled -eq $true) } #командлит на выборку всех компов
foreach ($pc in $pcs){
    if (Test-Connection -ComputerName $pc.Name -Quiet -Count 1){
        $status =Get-Service -ComputerName $pc.Name mrxsmb10
        if($status.Status -eq 'Running'){
            Write-Host $pc.Name "служба SMB1: " $status.Status
        }else{
            Write-Host $pc.Name "служба SMB1 не найдена"}
       }
}