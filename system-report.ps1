$report = Join-Path $PSScriptRoot "system-report.txt"
try {
    $os   = Get-CimInstance Win32_OperatingSystem -ErrorAction Stop
    $cpu  = Get-CimInstance Win32_Processor -ErrorAction Stop
    $disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'" -ErrorAction Stop
    "Computer: $env:COMPUTERNAME" | Out-File $report
    "OS: $($os.Caption)"          | Out-File $report -Append
    "CPU: $($cpu.Name)"           | Out-File $report -Append
    ("Free space on C: {0:N1} GB" -f ($disk.FreeSpace / 1GB)) | Out-File $report -Append
    Write-Host "Report saved to $report" -ForegroundColor Green
} catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}