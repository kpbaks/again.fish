function _again_install --on-event again_install
    # Set universal variables, create bindings, and other initialization logic.
end

function _again_update --on-event again_update
    # Migrate resources, print warnings, and other update logic.
end

function _again_uninstall --on-event again_uninstall
    # Erase "private" functions, variables, bindings, and other uninstall logic.
end


set --query AGAIN_KEYBIND; or set --global AGAIN_KEYBIND \ea # alt+a
# set --query AGAIN_ENABLED_MESSAGE; or set --global --export AGAIN_ENABLED_MESSAGE "again enabled ($AGAIN_KEYBIND to disable) "
set --query AGAIN_ENABLED_MESSAGE; or set --global --export AGAIN_ENABLED_MESSAGE "again enabled (alt+a to disable) "
# set --query AGAIN_DYNAMIC_KEYBIND; or set --global AGAIN_DYNAMIC_KEYBIND \eA # alt+A
# set --query AGAIN_DYNAMIC_ENABLED_MESSAGE; or set --global --export AGAIN_DYNAMIC_ENABLED_MESSAGE "again-dynamic enabled ($AGAIN_DYNAMIC_KEYBIND to disable) "
# set --query AGAIN_DYNAMIC_ENABLED_MESSAGE; or set --global --export AGAIN_DYNAMIC_ENABLED_MESSAGE "again-dynamic enabled (alt+A to disable) "

# bind \ea 'again'
bind $AGAIN_KEYBIND 'again --mode=static'

# bind \eA 'again dynamic'
# bind $AGAIN_DYNAMIC_KEYBIND 'again --mode=dynamic'
