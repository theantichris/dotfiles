function comfyui --description 'Open ComfyUI'
    pushd ~/ai/ComfyUI >/dev/null
    or return 1

    ./.venv/bin/python main.py --auto-launch $argv
    set -l exit_status $status

    popd >/dev/null
    return $exit_status
end
