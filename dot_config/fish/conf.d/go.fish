alias gob='go build'
alias goc='go clean'
alias god='go doc'
alias goe='go env'
alias gof='go fmt'
alias gofa='go fmt ./...'
alias gofx='go fix'
alias gog='go get'
alias goga='go get ./...'
alias goi='go install'
alias gol='go list'
alias gom='go mod'
alias gomt='go mod tidy'
alias gopa='cd (go env GOPATH)'
alias gopb='cd (go env GOPATH)/bin'
alias gops='cd (go env GOPATH)/src'
alias gor='go run'
alias got='go test'
alias gota='go test ./...'
function gotc --description 'Run Go tests with coverage and open the report'
    go test ./... -cover --coverprofile=coverage.out $argv
    or return $status
    go tool cover -html=coverage.out
end
alias gote='go test -tags=e2e'
function gotw --description 'Watch Go files and rerun coverage tests'
    if not command -q entr
        echo 'gotw: entr is not installed' >&2
        return 127
    end

    if command -q gotestsum
        fd -e go -E vendor -E gen -E dist | entr -c gotestsum -- -cover ./...
    else
        fd -e go -E vendor -E gen -E dist | entr -c go test -cover ./...
    end
end
alias goto='go tool'
alias gotoc='go tool compile'
alias gotod='go tool dist'
alias gotofx='go tool fix'
alias gov='go vet'
alias gove='go version'
alias gow='go work'
