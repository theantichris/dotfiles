function peek --description 'List archive contents without extracting'
    if test (count $argv) -ne 1
        echo 'Usage: peek ARCHIVE' >&2
        return 2
    end

    if not type -q 7z
        echo 'peek: 7z is not installed' >&2
        return 127
    end

    if not test -f $argv[1]
        echo "peek: archive not found: $argv[1]" >&2
        return 1
    end

    command 7z l $argv[1]
end
