$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
Push-Location $root
try {
    & cargo build -p plugin --release --locked --target x86_64-pc-windows-msvc
    if ($LASTEXITCODE -ne 0) { throw 'Aetherment Rust core build failed.' }
    $native = Join-Path $root 'target/x86_64-pc-windows-msvc/release/aetherment_core.dll'
    if (!(Test-Path $native)) { throw 'Missing aetherment_core.dll; refusing a managed-only build.' }
} finally { Pop-Location }
