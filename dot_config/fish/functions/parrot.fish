function parrot --description 'Start Parrot if needed and open its desktop'
    set -l uri qemu:///system
    set -l state (env LC_ALL=C virsh --connect $uri domstate htb-parrot)
    or return 1

    # Normalize trailing whitespace and empty lines before comparing the state.
    set state (string trim -- "$state")

    if test "$state" = 'shut off'
        command virsh --connect $uri start htb-parrot
        or return 1
    else if test "$state" != running
        printf 'Parrot is %s; not opening the viewer.\n' "$state" >&2
        return 1
    end

    # Attach through libvirt and leave the terminal free for other commands.
    command virt-viewer --connect $uri --attach htb-parrot &
    disown $last_pid
end
