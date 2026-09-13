function unpack --description 'Extract an archive into its own directory'
    if test (count $argv) -lt 1 -o (count $argv) -gt 2
        echo 'Usage: unpack ARCHIVE [DESTINATION]' >&2
        return 2
    end

    if not type -q 7z
        echo 'unpack: 7z is not installed' >&2
        return 127
    end

    set -l archive $argv[1]
    if not test -f $archive
        echo "unpack: archive not found: $archive" >&2
        return 1
    end

    if test (count $argv) -eq 2
        set -l destination $argv[2]
    else
        set -l archive_dir (path dirname -- $archive)
        set -l archive_name (path basename -- $archive)
        set -l folder_name (string replace -r '\.7z$' '' -- $archive_name)

        if test $folder_name = $archive_name
            set folder_name (string replace -r '\.[^.]+$' '' -- $archive_name)
        end

        set -l destination "$archive_dir/$folder_name"
    end

    mkdir -p -- $destination
    or return 1

    command 7z x $archive "-o$destination"
end
