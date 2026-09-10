function parrot-stop --description 'Request a graceful shutdown of the Parrot VM'
    command virsh --connect qemu:///system shutdown htb-parrot
end
