function onetrainer --description 'Open OneTrainer'
    pushd ~/ai/OneTrainer >/dev/null
    or return 1

    ./start-ui.sh
    set -l exit_status $status

    popd >/dev/null
    return $exit_status
end
