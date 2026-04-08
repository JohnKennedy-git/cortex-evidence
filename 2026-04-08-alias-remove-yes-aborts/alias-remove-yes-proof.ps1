$aliasName = "demo510john"
$aliasesPath = Join-Path $HOME '.cortex\aliases.toml'
if (Test-Path $aliasesPath) {
  $raw = Get-Content $aliasesPath -Raw
  $pattern = '(?ms)^\[aliases\.' + [regex]::Escape($aliasName) + '\]\r?\nname = "' + [regex]::Escape($aliasName) + '"\r?\ncommand = "stats"\r?\n?'
  $updated = [regex]::Replace($raw, $pattern, '')
  Set-Content $aliasesPath $updated
}
& 'C:\Users\mirac\OneDrive\Desktop\cortex\target\debug\Cortex.exe' alias set $aliasName 'stats'
"yes" | & 'C:\Users\mirac\OneDrive\Desktop\cortex\target\debug\Cortex.exe' alias remove $aliasName
& 'C:\Users\mirac\OneDrive\Desktop\cortex\target\debug\Cortex.exe' alias show $aliasName
