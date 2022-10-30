# variables
$Path = "D:\WSL\Debian"
$Date = (Get-Date).AddDays(-30)

# export
wsl --export Debian $Path\debian$(get-date -f yyyy-MM-dd).tar
# remove older than 30 days
Get-ChildItem -Path $Path -Recurse -Force | Where-Object {$_.LastWriteTime -lt $Date} | Remove-Item -Recurse