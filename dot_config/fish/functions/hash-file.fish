function hash-file --description "Hash file contents with hash-id"
    if test (count $argv) -eq 0
        echo "Usage: hash-file <file>"
        return 1
    end
    if not test -f $argv[1]
        echo "File not found: $argv[1]"
        return 1
    end
    hash-id --hash (string collect < $argv[1])
end
