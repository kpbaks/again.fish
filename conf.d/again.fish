function _again_install --on-event again_install
    # Set universal variables, create bindings, and other initialization logic.
end

function _again_update --on-event again_update
	# Migrate resources, print warnings, and other update logic.
end

function _again_uninstall --on-event again_uninstall
	# Erase "private" functions, variables, bindings, and other uninstall logic.
end


set --query AGAIN_KEYBIND; or set --global AGAIN_KEYBIND \ea
set --query AGAIN_ENABLED_MESSAGE; or set --global --export "again enabled ($AGAIN_KEYBIND to disable) "
# set --query AGAIN_ENABLED_MESSAGE; or set --global --export "again enabled (alt+a to disable) "

# alt+a
# bind \ea 'again'
bind $AGAIN_KEYBIND 'again'
