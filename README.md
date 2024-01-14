# again.fish

A [fish](https://fishshell.com/) plugin that prepopulates the next prompt with the contents and cursor position of the previous prompt.

## Example Scenario
Say you wanted to search for several different things in a directory using `grep`. Then you
would have to type out the command and press enter. To search for the next thing you would have
to press <kbd>up</kbd> in order to get the previous prompt. And then move your cursor to the previous
query, delete it and the retype it. This becomes tedious very quickly. But with `again.fish` this
type of scenario can be handled effortlessly!

Say you had the following prompt, where the `|` character is the cursor position.

```fish
grep --perl-regexp "|" **.fish
```

Press <kbd>alt+a</kbd>, and then type something like

```fish
grep --perl-regexp "set -g|" **.fish
```

Press <kbd>enter</kbd> to execute the prompt. Then the next prompt will already be prepulated like this

```fish
grep --perl-regexp "|" **.fish
```
Simply press <kbd>alt+a</kbd> to disable again when you are done.

<!-- TODO create video screencast -->

## Installation
```fish
fisher install kpbaks/again.fish
```

## Prompt Integration

To make it easier to notice that the again "submode" has been activated I suggest you to configure your prompt to show this.
The plugin exposes a *global exported* variable called `AGAIN_ENABLED` when the again "submode" is active.

### [starship.rs](https://starship.rs/)

`starship` has a [module](https://starship.rs/config/#environment-variable) for showing environment variables, dependent on whether
the variable is defined or not. Using the following snippet in `~/.config/starship.toml`

```toml
format = """
${env_var.AGAIN_ENABLED}
... rest of your format string
"""

[env_var.AGAIN_ENABLED]
style = "bold fg:red"
default = ""
format = "[$env_value]($style)"
description = "again.fish"
disabled = false
```

adds the leftmost red segment, when again is active:

![image](https://github.com/kpbaks/again.fish/assets/57013304/d5682ed6-f014-44bc-9801-cd7277e92274)

## Customization

The following variables can be changed to customize the plugin:

| Variable                  | Default   | Description                                                                                                                                 | Constraints                                                                        |
| ------------------------- | --------- | ------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| `AGAIN_KEYBIND`            | `\ea` <kbd>alt+a</kbd>       | The keybind used to toggle the again "submode"                                                                                                      | Must match the keybind format expected by the `bind` builtin.                                                            |
| `AGAIN_ENABLED_MESSAGE` |  `again enabled ($AGAIN_KEYBIND to disable) ` | The value of the `$AGAIN_ENABLED` variable, used to see if the again "submode" is enabled. The value is only relevant for any kind of [prompt integration](#prompt-integration)). |  |
