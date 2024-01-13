# again.fish

TODO create video screencast

## Installation
```fish
fisher install kpbaks/again.fish
```

## Prompt Integration

### [starship.rs](https://starship.rs/)

https://starship.rs/config/#environment-variable


## Customization

The following variables can be changed to customize the plugin:

| Variable                  | Default   | Description                                                                                                                                 | Constraints                                                                        |
| ------------------------- | --------- | ------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| `AGAIN_KEYBIND`            | `\ea` <kbd>alt+a</kbd>       | The keybind used to toggle the again "submode"                                                                                                      | Must match the keybind format expected by the `bind` builtin                                                            |
| `AGAIN_ENABLED_MESSAGE` |  `again enabled ($AGAIN_KEYBIND to disable) ` | The value of the `$AGAIN_ENABLED` variable, used to see if the again "submode" is enabled. The value is only relevant for any kind of prompt (see [](#customization)) |  |
