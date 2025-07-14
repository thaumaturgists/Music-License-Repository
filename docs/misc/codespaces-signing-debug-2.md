```
git add .
```
```
git commit -S -m "Test cs signing"
```

==================================================
```
error: gpg failed to sign the data:
[GNUPG:] KEY_CONSIDERED 8003809B075B5D7B9DEB67AF1B340407FC199FCA 2
[GNUPG:] BEGIN_SIGNING H10
[GNUPG:] PINENTRY_LAUNCHED 11918 tty 1.2.1 - xterm-256color - - 1000/1000 -
gpg: signing failed: Operation cancelled
[GNUPG:] FAILURE sign 83886179
gpg: signing failed: Operation cancelled

fatal: failed to write commit object
```
==================================================

The error message you're encountering indicates that GPG (GNU Privacy Guard) failed to sign your data, which is often required for committing changes in Git when using signed commits. The specific error "Operation cancelled" suggests that the signing process was interrupted, likely due to an issue with the pinentry program, which is responsible for prompting you for your GPG passphrase.

Here are some steps you can take to troubleshoot and resolve this issue:

### 1. Check GPG Configuration
Ensure that your GPG is properly configured. You can check your GPG version and configuration with the following commands:

```bash
gpg --version
gpg --list-secret-keys
```

### 2. Ensure Pinentry is Installed
Make sure that you have a pinentry program installed. This program is necessary for entering your passphrase. You can install it using your package manager. For example, on Ubuntu, you can install it with:

```bash
sudo apt-get install pinentry
```

### 3. Set the Correct Pinentry Program
You may need to specify which pinentry program GPG should use. You can do this by adding the following line to your `~/.gnupg/gpg-agent.conf` file:

```plaintext
pinentry-program /usr/bin/pinentry-tty
```

Make sure to replace `/usr/bin/pinentry-tty` with the correct path to your pinentry program if it's different.

After making changes, restart the GPG agent:

```bash
gpgconf --kill gpg-agent
```

### 4. Check for GUI Issues
If you're using a graphical environment, ensure that the pinentry program is set to a GUI version (like `pinentry-gtk-2` or `pinentry-qt`). You can set this in the same `gpg-agent.conf` file:

```plaintext
pinentry-program /usr/bin/pinentry-gtk-2
```

### 5. Test Signing Manually
Try signing a file manually to see if the issue persists:

```bash
echo "test" | gpg --clearsign
```

If this works, the issue may be specific to your Git configuration.

### 6. Check Git Configuration
Ensure that your Git configuration is set to use GPG for signing commits. You can check this with:

```bash
git config --global user.signingkey <your-key-id>
git config --global commit.gpgSign true
```

### 7. Update GPG and Git
Make sure you are using the latest versions of GPG and Git, as bugs and issues are often fixed in newer releases.

### 8. Check for Environment Issues
If you're running this in a terminal multiplexer (like tmux or screen), try running the command in a regular terminal window to see if that resolves the issue.

### Conclusion
After trying these steps, attempt to sign your commit again. If the problem persists, consider checking the GPG documentation or forums for more specific troubleshooting related to your operating system and environment.

=========================================================
```
gpg --version
```
// It showed it was installed, Good.
```
gpg --list-secret-keys
```
// It listed the keys, Good.
```
sudo apt-get install pinentry
```
```
sudo apt-get install pinentry-tty
```
```
sudo nano  ~/.gnupg/gpg-agent.conf
```
// Make sure these are in
```plaintext
log-file /tmp/gpg-agent.log

pinentry-program /usr/bin/pinentry-tty
```
1. ctrl + x

   1.1 // To Exit

   1.2 // Press y to save, if changes were made
   
   1.3 // Press Enter to write to file
   
   1.4 // Good
```
gpgconf --kill gpg-agent
```
// Tells the gpg-agent restart
```
echo "test" | gpg --clearsign
```
// Test Failed

```
chmod 700 ~/.gnupg
chmod 600 ~/.gnupg/*
```
// Check permissions
```
echo "test" | gpg --clearsign
```
// Test Failed

```
gpg --list-secret-keys --keyid-format LONG
```
// Greab the string after the ``/`` it will be 16 characters long

// Put the 16 characters in ``<your-key-here>``
```
git config --global user.signingkey <your-key-here>
```
// set, Good.

```
```bash
export GPG_TTY=$(tty)
```
// This worked

==================================================
```
Why do I need to put in export GPG_TTY=$(tty)
every time I use my codespace in GitHub
```
==================================================

When you use `export GPG_TTY=$(tty)` in your GitHub Codespace (or any terminal environment), you're setting the `GPG_TTY` environment variable to ensure that GPG can correctly interact with the terminal for passphrase entry. Here are a few reasons why you might need to do this each time you start a new session in your Codespace:

### 1. **Session Isolation**
Each time you open a new terminal session or Codespace, the environment variables are reset. This means that any variables you set in a previous session (like `GPG_TTY`) will not persist. You need to set it again in each new session.

### 2. **Terminal Type Detection**
GPG needs to know which terminal to use for user input. By default, it may not automatically detect the correct terminal in some environments, especially in IDEs or cloud-based environments like GitHub Codespaces. Setting `GPG_TTY` explicitly helps GPG find the right terminal.

### 3. **Environment Configuration**
If your Codespace is configured in a way that doesn't automatically set `GPG_TTY`, you will need to do it manually. This is common in environments where the terminal is not a standard interactive shell.

### 4. **Automation**
To avoid having to set this variable manually every time, you can add the `export GPG_TTY=$(tty)` command to your shell's configuration file (like `.bashrc`, `.bash_profile`, or `.zshrc`, depending on your shell). This way, it will be set automatically every time you start a new terminal session.

### Example of Adding to Configuration File
If you're using Bash, you can add the following line to your `~/.bashrc` file:

```bash
echo 'export GPG_TTY=$(tty)' >> ~/.bashrc
```

After adding this line, run `source ~/.bashrc` to apply the changes immediately, or it will take effect the next time you open a terminal.

### Conclusion
By setting `GPG_TTY` each time, you ensure that GPG can prompt you for your passphrase correctly. Automating this process by adding it to your shell configuration file can save you time and make your workflow smoother.

==================================================
```
The updates in there too?
```
==================================================

If you want to manually add the command to set `GPG_TTY` in your `~/.bashrc` file and also include commands to update your system packages, you can do that, but it's important to note that the package update commands (`sudo apt-get update` and `sudo apt-get upgrade`) should not be placed directly in the `~/.bashrc` file. This is because `~/.bashrc` is executed every time a new terminal session starts, and running package updates every time you open a terminal is not practical and could lead to issues.

### Recommended Approach

Instead, you can add the `GPG_TTY` export command to your `~/.bashrc` and then run the update commands separately in the terminal. Here’s how to do it:

### Step 1: Manually Edit `~/.bashrc`

1. **Open the Terminal** in your GitHub Codespace.

2. **Open the `~/.bashrc` file** in a text editor:

   ```bash
   nano ~/.bashrc
   ```

3. **Add the following line** to the end of the file:

   ```bash
   export GPG_TTY=$(tty)
   ```

4. **Save and exit** the editor:
   - In `nano`, press `CTRL + X`, then `Y`, and then `Enter`.
   - In `vim`, press `Esc`, type `:wq`, and then press `Enter`.

5. **Apply the changes** immediately by running:

   ```bash
   source ~/.bashrc
   ```

### Step 2: Update System Packages

After updating your `~/.bashrc`, you can run the following commands in the terminal to update your system packages:

```bash
sudo apt-get update
sudo apt-get upgrade -y
```

### Summary

1. **Add `export GPG_TTY=$(tty)`** to your `~/.bashrc` file to ensure it is set in every new terminal session.
2. **Run the package update commands separately** in the terminal to keep your system up to date.

This approach keeps your environment configuration clean and avoids unnecessary package updates every time you open a terminal. If you have any further questions or need additional assistance, feel free to ask!

# Update

Make sure to update you system first everytime you start codespaces
```
sudo apt-get update
sudo apt-get upgrade -y
```

> -- If prompted to keep your local version, its your confg file, pick that.


