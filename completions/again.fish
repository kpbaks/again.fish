set -l c complete -c again

$c -s h -l help
$c -n "not __fish_seen_subcommand_from enabled" -a enabled -d "Check if again-mode is enabled"
