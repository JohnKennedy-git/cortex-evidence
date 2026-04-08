$cacheRoot = Join-Path $env:LOCALAPPDATA "cortex"
$modelDir = Join-Path $cacheRoot "models"
$dummy = Join-Path $modelDir "dummy-yes-probe.txt"
New-Item -ItemType Directory -Force -Path $modelDir | Out-Null
Set-Content -Path $dummy -Value "demo"
"yes" | & 'C:\Users\mirac\OneDrive\Desktop\cortex\target\debug\Cortex.exe' cache clear --models
Test-Path $dummy
