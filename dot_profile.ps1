# Navigation
if (Get-Command eza -ErrorAction SilentlyContinue) {
  function ll { eza -lh --git @args }
  function la { eza -lha --git @args }
  function ls { eza @args }
}
else {
  function ll { Get-ChildItem -Force @args }
  function la { Get-ChildItem -Force -Hidden @args }
  Set-Alias ls Get-ChildItem
}

# Git shortcuts
### ——— Reset conflicting built-ins ———
foreach ($a in 'gc', 'gp', 'gl', 'gcm', 'gco', 'gcb', 'gst') {
  if (Test-Path Alias:$a) { Remove-Item Alias:$a -Force }
}

### ——— Core helper: g delegates to git ———
function g { git @args }

### ——— Status / diff ———
function gst { git status @args }
function gd { git diff @args }
function gdca { git diff --cached @args }
function gds { git diff --staged @args }

### ——— Add / restore ———
function ga { git add @args }
function gaa { git add --all @args }
function grs { git restore @args }

### ——— Commit ———
function gc { git commit -v @args }
function gcmsg { git commit -m @args }

### ——— Checkout / switch / branch ———
function gco { git checkout @args }
function gcb { git checkout -b @args }
function gsw { git switch @args }
function gb { git branch @args }

### ——— Fetch / pull / push ———
function gf { git fetch @args }
function gl { git pull @args }
function gp { git push @args }

# Utilities
Set-Alias cat "bat"
Set-Alias find "fd"
Set-Alias grep "rg"

# Quick JSON formatting
function json { param($path) Get-Content $path | jq '.' }

# Visual Studio Code
function vsc {
  param(
    [string]$target = "."
  )
  code $target
}

# Go
function gob { go build @args }
function goc { go clean @args }
function god { go doc @args }
function goe { go env @args }
function gof { go fmt @args }
function gofa { go fmt ./... @args }
function gofx { go fix @args }
function gog { go get @args }
function goga { go get ./... @args }
function goi { go install @args }
function gol { go list @args }
function gom { go mod @args }
function gomt { go mod tidy @args }

function gor { go run @args }
function got { go test @args }
function gota { go test ./... @args }
function gotc { go test ./... -cover --coverprofile coverage.out && gocovsh }
function goto { go tool @args }
function gotoc { go tool compile @args }
function gotod { go tool dist @args }
function gotofx { go tool fix @args }
function gov { go vet @args }
function gove { go version @args }
function gow { go work @args }

# Touch
function touch {
  param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$Path
  )

  if (Test-Path $Path) {
    # update modified timestamp
    (Get-Item $Path).LastWriteTime = Get-Date
  }
  else {
    # create empty file
    New-Item -Type File -Path $Path | Out-Null
  }
}

# Add to your PowerShell profile ($PROFILE)
function Winget-UpdateAll {
  winget source update        # (apt update equivalent)
  winget upgrade --all        # upgrade everything
}
Set-Alias wgu Winget-UpdateAll

# chezmoi
function cmu { chezmoi update @args }
function cma { chezmoi apply @args }
function cme { chezmoi edit @agrs }
