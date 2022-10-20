wsl --export Debian D:\WSL\Debian\debian$(get-date -f yyyy-MM-dd).tar
Get-ChildItem –Path "D:\WSL\Debian" -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-30))} | Remove-Item