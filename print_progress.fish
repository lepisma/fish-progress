set -g progress_version 0.1.0

function __progress_build_info -a total current -d "Build string showing completion info"
    set -l done_str (string repeat -n (math (string length $total) - (string length $current)) " ")" "$current
    echo ":: "$done_str" / "$total" "
end

function print_progress -a total current -d "Print one state of progress bar"
    set -l done_ratio (math $current / $total)

    set -l info_str (__progress_build_info $total $current)

    set -l width (math (tput cols) - (string length $info_str))
    set -l n_done (math "floor("$done_ratio" * "$width")")

    echo -ne $info_str
    echo -ne (string repeat -n $n_done "█")
    echo -ne (string repeat -n (math $width - $n_done) "—")
end
