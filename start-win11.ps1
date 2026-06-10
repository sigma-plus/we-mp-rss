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

# Ensure Playwright browsers match the venv's playwright version
Write-Host "[INFO] Checking Playwright browsers..." -ForegroundColor Cyan
$check = uv run python -c @"
from playwright.sync_api import sync_playwright
try:
    with sync_playwright() as p:
        b = p.webkit.launch(headless=True)
        b.close()
    print('ok')
except Exception as e:
    print('fail:' + str(e))
"@ 2>&1

if ($check -notmatch 'ok') {
    Write-Host "[INFO] Playwright browsers missing or mismatched. Installing..." -ForegroundColor Yellow
    uv run playwright install
    Write-Host "[INFO] Playwright browsers installed." -ForegroundColor Green
} else {
    Write-Host "[INFO] Playwright browsers OK." -ForegroundColor Green
}

if ($Init) {
    uv run python main.py -job True -init True
} else {
    uv run python main.py -job True
}
