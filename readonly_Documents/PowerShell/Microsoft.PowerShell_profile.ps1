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
function gapa { git add --patch @args }
function grs { git restore @args }
function grss { git restore --staged @args }

### ——— Commit ———
function gc { git commit -v @args }
function gc! { git commit -v --amend @args }
function gca { git commit -v -a @args }
function gca! { git commit -v -a --amend @args }
function gcan! { git commit -v -a --no-edit --amend @args }
function gcans! { git commit -v -a -s --no-edit --amend @args }
function gcam { git commit -a -m @args }
function gcmsg { git commit -m @args }
function gcs { git commit -S @args }
function gcsm { git commit -s -m @args }

### ——— Checkout / switch / branch ———
function gco { git checkout @args }
function gcor { git checkout --recurse-submodules @args }
function gcb { git checkout -b @args }
function gsw { git switch @args }
function gswc { git switch -c @args }
function gb { git branch @args }
function gba { git branch -a @args }
function gbnm { git branch --no-merged @args }

# Main/develop helpers (OMZ uses helpers to detect main branch)
function gcm { git checkout $(git symbolic-ref --short refs/remotes/origin/HEAD | ForEach-Object { $_.Split('/')[-1] }) }
function gcd { git checkout develop }

### ——— Log ———
function gl { git log --oneline --graph --decorate @args }
function glg { git log --stat @args }
function glgg { git log --graph --max-count=10 @args }
function glgga { git log --graph --decorate --all @args }
function glgp { git log --stat -p @args }
function glgs { git log --stat --since="1 day ago" @args }

### ——— Fetch / pull / push ———
function gfa { git fetch --all --prune @args }
function gf { git fetch @args }
function gpl { git pull @args }
function gps { git push @args }
function gpsup {
  $b = git rev-parse --abbrev-ref HEAD
  git push --set-upstream origin $b @args
}

### ——— Stash ———
function gsta { git stash push @args }
function gstaa { git stash apply @args }
function gstp { git stash pop @args }
function gstd { git stash drop @args }
function gstl { git stash list @args }

### ——— Cherry-pick / reset / clean ———
function gcp { git cherry-pick @args }
function gcpa { git cherry-pick --abort @args }
function gcpc { git cherry-pick --continue @args }
function grh { git reset --hard @args }
function gpristine { git reset --hard; git clean -dffx }
function gclean { git clean -id @args }

### ——— Clone ———
function gcl { git clone --recurse-submodules @args }
function gccd {
  git clone --recurse-submodules @args;
  if ($LASTEXITCODE -eq 0) {
    $n = ($args[-1] -replace '.git$', '');
    Set-Location (Split-Path -Leaf $n)
  }
}

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

# GOPATH navigation (use Go env instead of hardcoding)
function gopa { Set-Location (go env GOPATH) }
function gopb { Set-Location (Join-Path (go env GOPATH) bin) }
function gops { Set-Location (Join-Path (go env GOPATH) src) }

function gor { go run @args }
function got { go test @args }
function gota { go test ./... @args }
function goto { go tool @args }
function gotoc { go tool compile @args }
function gotod { go tool dist @args }
function gotofx { go tool fix @args }
function gov { go vet @args }
function gove { go version @args }
function gow { go work @args }
