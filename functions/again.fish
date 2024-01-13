function again -d "After executing a command, put it back in the command line"
    set -l options h/help
    if not argparse $options -- $argv
        eval (status function) --help
        return 2
    end

    if set --query _flag_help
        set -l reset (set_color normal)
        set -l bold (set_color bold)
        set -l red (set_color red)
        set -l green (set_color green)
        set -l yellow (set_color yellow)
        printf "%sAfter executing a command, put it back in the command line%s\n" $bold $reset >&2
        printf "\n" >&2
        printf "%sUSAGE:%s %s%s%s [enabled]\n" $yellow $reset (set_color $fish_color_command) (status function) $reset >&2
        return 0
    end

    if not status is-interactive
        printf "%serror%s: %s is only available in interactive mode\n" (set_color red) (set_color normal) (status function) >&2
        return 1
    end

    if test (count $argv) -eq 1
        switch $argv[1]
            case enabled
                set --query AGAIN_ENABLED
                return $status
            case '*'
                printf "%serror%s: invalid argument '%s'\n" (set_color red) (set_color normal) $argv[1] >&2
                eval (status function) --help
                return 2
        end
    end

    set -l buffer (commandline)
    set -l cursor (commandline --cursor)

    if set --query AGAIN_ENABLED
        functions --query again_postexec_handler; and functions --erase again_postexec_handler
        set --unexport AGAIN_ENABLED
        set --erase AGAIN_ENABLED
    else if string match --regex --quiet '^\s*$' $buffer
        # Do nothing
    else
        set -g again_command $buffer
        set -g again_cursor $cursor
        function again_postexec_handler --on-event fish_postexec
            commandline --replace $again_command
            commandline --cursor $again_cursor
        end

        # Even though the value of the variable is not used, in this function
        # we are setting it, such that starship.rs (or other prompt) can use it.
        # set --global --export AGAIN_ENABLED "again enabled (alt+a to disable) "
        set --global --export AGAIN_ENABLED $AGAIN_ENABLED_MESSAGE

    end

    commandline --function repaint
end
