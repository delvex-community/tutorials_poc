# Making Variables, Aliases, and Shell Configurations Permanent in Linux

Learn how to make variables, aliases, and shell configurations (like `PATH`, `SHELL`, `PS1`, etc.) permanent in a Linux shell by adding them to shell initialization files like `.bashrc`, `.bash_profile`, or other similar files depending on your shell.

## 1. Understanding Shell Initialization Files

When you start a shell session, certain files are read to configure the environment. The files used depend on whether the shell is a **login shell** or a **non-login shell**.

### For Bash:

- **Login Shell**:
    - Reads `/etc/profile` (system-wide).
    - Reads `~/.bash_profile`, `~/.bash_login`, or `~/.profile` (user-specific, in that order).

- **Non-Login Shell**:
    - Reads `/etc/bash.bashrc` (system-wide).
    - Reads `~/.bashrc` (user-specific).

### For Other Shells:

- **Zsh**:
    - Uses `~/.zshrc` for non-login shells and `~/.zprofile` for login shells.

- **Fish**:
    - Uses `~/.config/fish/config.fish`.

## 2. Making Variables Permanent

To make variables like `PATH`, `SHELL`, or custom variables permanent, add them to the appropriate shell initialization file.

### Example: Setting `PATH` Permanently

1. Open `~/.bashrc` (or `~/.bash_profile` for login shells):

     ```bash
     nano ~/.bashrc
     ```

2. Add the following line to append a directory to `PATH`:

     ```bash
     export PATH="$PATH:/your/custom/path"
     ```

3. Save and exit the file.

4. Reload the file to apply changes:

     ```bash
     source ~/.bashrc
     ```

### Example: Setting a Custom Variable

1. Open `~/.bashrc`:

     ```bash
     nano ~/.bashrc
     ```

2. Add the following line:

     ```bash
     export MY_VAR="Hello, World!"
     ```

3. Save, exit, and reload:

     ```bash
     source ~/.bashrc
     ```

## 3. Making Aliases Permanent

Aliases are shortcuts for commands. To make them permanent, add them to `~/.bashrc` or `~/.bash_profile`.

### Example: Creating a Permanent Alias

1. Open `~/.bashrc`:

     ```bash
     nano ~/.bashrc
     ```

2. Add the following line:

     ```bash
     alias ll='ls -la'
     ```

3. Save, exit, and reload:

     ```bash
     source ~/.bashrc
     ```

## 4. Customizing the Prompt (`PS1`)

The `PS1` variable controls the appearance of the shell prompt. You can customize it to display useful information like the current directory, username, hostname, etc.

### Example: Customizing `PS1`

1. Open `~/.bashrc`:

     ```bash
     nano ~/.bashrc
     ```

2. Add the following line:

     ```bash
     export PS1="\u@\h:\w\$ "
     ```

     - `\u`: Username.
     - `\h`: Hostname.
     - `\w`: Current directory.
     - `\$`: Displays `#` for root and `$` for regular users.

3. Save, exit, and reload:

     ```bash
     source ~/.bashrc
     ```

### Advanced `PS1` Customization

You can add colors and other features to `PS1`:

```bash
export PS1="\[\e[32m\]\u@\h\[\e[0m\]:\[\e[34m\]\w\[\e[0m\]\$ "
```

- `\[\e[32m\]`: Start green color.
- `\[\e[34m\]`: Start blue color.
- `\[\e[0m\]`: Reset color.

## 5. Making `SHELL` Variable Permanent

The `SHELL` variable stores the path to the current shell. It is usually set automatically, but you can override it if needed.

### Example: Setting `SHELL`

1. Open `~/.bashrc`:

     ```bash
     nano ~/.bashrc
     ```

2. Add the following line:

     ```bash
     export SHELL=/bin/bash
     ```

3. Save, exit, and reload:

     ```bash
     source ~/.bashrc
     ```

## 6. Using `.bash_profile` vs `.bashrc`

- **`.bash_profile`**:
    - Executed for login shells (e.g., when you log in via SSH or a terminal emulator).
    - Use this file for environment variables and commands that should run once per session.

- **`.bashrc`**:
    - Executed for non-login shells (e.g., when you open a new terminal tab).
    - Use this file for aliases, functions, and configurations that should apply to every shell instance.

### Best Practice:

Source `.bashrc` from `.bash_profile` to ensure consistency:

```bash
if [ -f ~/.bashrc ]; then
        source ~/.bashrc
fi
```

## 7. System-Wide Configuration

To make variables or aliases available to all users, add them to system-wide files:

- `/etc/profile` (for login shells).
- `/etc/bash.bashrc` (for non-login shells).

### Example: System-Wide `PATH`

1. Open `/etc/profile`:

     ```bash
     sudo nano /etc/profile
     ```

2. Add the following line:

     ```bash
     export PATH="$PATH:/usr/local/custom/bin"
     ```

3. Save and exit. Changes will apply after users log in again.

## 8. Reloading Shell Configurations

After modifying shell initialization files, reload them for the changes to take effect:

- For `~/.bashrc`:

    ```bash
    source ~/.bashrc
    ```

- For `~/.bash_profile`:

    ```bash
    source ~/.bash_profile
    ```

## 9. Debugging Shell Initialization

If something isn’t working as expected, debug which files are being executed:

1. Add `echo` statements to your shell files:

     ```bash
     echo "Loading ~/.bashrc"
     ```

2. Check the order of execution:

     ```bash
     bash -l -x
     ```

## 10. Summary of Files and Their Uses

| File               | Purpose                                                                 |
|--------------------|-------------------------------------------------------------------------|
| `~/.bashrc`        | Non-login shell configuration (aliases, functions, prompt customization). |
| `~/.bash_profile`  | Login shell configuration (environment variables, startup commands).    |
| `~/.profile`       | Fallback for `~/.bash_profile` (used if `~/.bash_profile` doesn’t exist). |
| `/etc/profile`     | System-wide login shell configuration.                                 |
| `/etc/bash.bashrc` | System-wide non-login shell configuration.                             |