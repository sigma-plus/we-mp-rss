param(
    [switch]$Init
)

$ErrorActionPreference = 'Stop'

# Always run from repository root (script directory)
Set-Location -Path $PSScriptRoot

if (-not (Get-Command uv -ErrorAction SilentlyContinue)) {
    Write-Host "[ERROR] 'uv' is not installed or not in PATH." -ForegroundColor Red
    Write-Host "Install uv first: https://docs.astral.sh/uv/getting-started/installation/" -ForegroundColor Yellow
    exit 1
}

if ($Init) {
    uv run python main.py -job True -init True
} else {
    uv run python main.py -job True
}
