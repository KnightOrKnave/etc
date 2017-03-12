$mem=Get-WmiObject Win32_OperatingSystem | %{(($_.TotalVisibleMemorySize - $_.FreePhysicalMemory)/$_.TotalVisibleMemorySize) * 100}
echo "memory: ${mem}"

echo "CPU"

$cpuinfo = New-Object -TypeName PSCustomObject
$cpu = Get-WmiObject Win32_PerfFormattedData_PerfOS_Processor | ?{$_.Name -match "^[0-9]+$"}
foreach($c in $cpu)
{
    $cpuinfo | Add-Member -MemberType NoteProperty -Name $c.Name -Value $c.PercentProcessorTime 
}
$cpuinfo | Format-List


echo "Disk"
Get-WmiObject Win32_PerfFormattedData_PerfDisk_LogicalDisk | select Name,PercentFreeSpace | Format-List
