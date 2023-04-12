$app_name = Read-Host "Enter program name" # Kullanıcıdan program adını alınır
$pids = @()
Get-Process | ForEach-Object {
    if ($_.ProcessName -eq $app_name) {
        $pids += $_.Id
    }
}

if ($pids.Count -eq 0) {
    Write-Host "No running processes with name $($app_name)"
} else {
    $pids | Out-File "pids.txt"
    Write-Host "$($pids.Count) running processes with name $($app_name) found."
    Write-Host "PID's written to file: pids.txt"
}

# prodump'u çağırmak için cmd ekranı aç
Start-Process -FilePath "cmd.exe" -Verb RunAs

# pids.txt dosyasını oku ve prodump'u çağır
$prodump_path = "C:\PidDump\procdump.exe" # procdump.exe'nin yolunu belirt
$file_path = "C:\PidDump\pids.txt" # pids.txt dosyasının yolunu belirt

if (!(Test-Path $file_path)) {
    Write-Host "File not found: $($file_path)"
} else {
    $pids = Get-Content $file_path
    foreach ($process_id in $pids) {
        $file_name = "spool-8_$process_id.dmp"
        $args = "$process_id -s 30 -m 10 C:\PidDump\$file_name"
        Start-Process -FilePath $prodump_path -ArgumentList $args -Verb RunAs
    }
}
