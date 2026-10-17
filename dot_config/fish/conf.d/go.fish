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
    for dependency in fd entr
        if not command -q $dependency
            echo "gotw: $dependency is not installed" >&2
            return 127
        end
    end

    set -l test_command go test -cover ./...
    if command -q gotestsum
        set test_command gotestsum -- -cover ./...
    end

    while true
        set -l watch_files (command fd --type f -E vendor -E gen -E dist '(\.go$|^go\.(mod|sum|work|work\.sum)$)')
        or return $status
        set -l watch_dirs (command fd --type d -E vendor -E gen -E dist)
        or return $status

        # Watch directories too, including an empty project, so new files and
        # source directories cause entr -d to exit 2 and rebuild this list.
        printf '%s\n' . $watch_dirs $watch_files | command entr -dc $test_command
        set -l watcher_status $pipestatus[-1]

        # A watched file can disappear before entr opens/reopens it, producing
        # exit 1 instead of the directory-change exit 2. Rescan only when an
        # enumerated path actually vanished; propagate other entr errors.
        if test $watcher_status -eq 1
            for watch_path in $watch_dirs $watch_files
                if not test -e "$watch_path"
                    set watcher_status 2
                    break
                end
            end
        end
        if test $watcher_status -ne 2
            return $watcher_status
        end
    end
end
alias goto='go tool'
alias gotoc='go tool compile'
alias gotod='go tool dist'
alias gotofx='go tool fix'
alias gov='go vet'
alias gove='go version'
alias gow='go work'
