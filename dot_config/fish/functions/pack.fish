function pack --description 'Create a 7z archive'
    if test (count $argv) -lt 2
        echo 'Usage: pack ARCHIVE.7z FILE...' >&2
        return 2
    end

    if not type -q 7z
        echo 'pack: 7z is not installed' >&2
        return 127
    end

    set -l archive $argv[1]
    set -l inputs $argv[2..-1]

    command 7z a $archive $inputs
end
