function nb --wraps=nb
    if test (count $argv) -gt 0; and test "$argv[1]" = list -o "$argv[1]" = ls
        command nb $argv[1] -f $argv[2..]
    else
        command nb $argv
    end
end
