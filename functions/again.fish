function again -d "After executing a command, put it back in the command line"
    set -l options h/help (fish_opt --short=m --long=mode --required-val)
    if not argparse $options -- $argv
        eval (status function) --help
        return 2
    end

    if set --query _flag_help
        set -l reset (set_color normal)
        set -l bold (set_color --bold)
        set -l red (set_color red)
        set -l green (set_color green)
        set -l yellow (set_color yellow)
        printf "%sAfter executing a command, put it back in the command line%s\n" $bold $reset >&2
        printf "\n" >&2
        printf "%sUSAGE:%s %s%s%s [enabled]\n" $yellow $reset (set_color $fish_color_command) (status function) $reset >&2
        # TODO: mention flags
        return 0
    end

    if not status is-interactive
        printf "%serror%s: %s is only available in interactive mode\n" (set_color red) (set_color normal) (status function) >&2
        return 1
    end

    if test (count $argv) -eq 1
        switch $argv[1]
            case enabled
                set --query AGAIN_ENABLED; or set --query AGAIN_DYNAMIC_ENABLED
                return $status
            case '*'
                printf "%serror%s: invalid argument '%s'\n" (set_color red) (set_color normal) $argv[1] >&2
                eval (status function) --help
                return 2
        end
    end

    if not set --query _flag_mode
        set -l reset (set_color normal)
        printf "%serror%s: %s-m%s, %s--mode%s MODE not specified\n" (set_color red) $reset (set_color $fish_color_param) $reset (set_color $fish_color_param) $reset
        return 2
    else
        if not contains -- $_flag_mode static dynamic
            set -l reset (set_color normal)
            printf "%serror%s: unknown mode: %s%s%s. valid modes are: %s%s%s\n" (set_color red) $reset (set_color red) $_flag_mode $reset (set_color --bold) (string join ", " static dynamic) $reset
            return 2
        end
    end

    if set --query AGAIN_ENABLED
        # Disable (static) again mode
        functions --query again_postexec_handler; and functions --erase again_postexec_handler
        set --unexport AGAIN_ENABLED
        set --erase AGAIN_ENABLED
        set --function again_disabled_this_function_call

    else if set --query AGAIN_DYNAMIC_ENABLED
        # Disable (dynamic) again
        functions --query again_postexec_handler; and functions --erase again_postexec_handler
        functions --query again_preexec_handler; and functions --erase again_preexec_handler
        set --unexport AGAIN_DYNAMIC_ENABLED
        set --erase AGAIN_DYNAMIC_ENABLED
        set --function again_dynamic_disabled_this_function_call
    end

    if string match --regex --quiet '^\s*$' $buffer
        # Do nothing
        return
    end

    switch $_flag_mode
        case static
            if not set --query again_disabled_this_function_call
                set -g again_command (commandline)
                set -g again_cursor (commandline --cursor)
                function again_postexec_handler --on-event fish_postexec
                    commandline --replace $again_command
                    commandline --cursor $again_cursor
                end

                # Even though the value of the variable is not used, in this function
                # we are setting it, such that starship.rs (or other prompt) can use it.
                # set --global --export AGAIN_ENABLED "again enabled (alt+a to disable) "
                set --global --export AGAIN_ENABLED $AGAIN_ENABLED_MESSAGE
            end
        case dynamic
            if not set --query again_dynamic_disabled_this_function_call
                set -g again_command (commandline)
                set -g again_cursor (commanline --cursor)
                function again_postexec_handler --on-event fish_postexec
                    commandline --replace $again_command
                    commandline --cursor $again_cursor
                end
                # FIX: does not work, maybe have to fix in fish-shell source
                function again_preexec_handler --on-event fish_preexec
                    set -g again_command (commandline)
                    set -g again_cursor (commandline --cursor)
                end
                # Even though the value of the variable is not used, in this function
                # we are setting it, such that starship.rs (or other prompt) can use it.
                set --global --export AGAIN_DYNAMIC_ENABLED $AGAIN_DYNAMIC_ENABLED_MESSAGE
            end
    end
    commandline --function repaint
end
