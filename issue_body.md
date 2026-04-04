### Project
cortex

### Description
The `cortex lock` command ignores the `CORTEX_HOME` environment variable and always writes the session lock file to the default `~/.cortex/session_locks.json` location. When a user sets a custom `CORTEX_HOME` to isolate their Cortex profile, the lock commands should respect that setting and store locks within the active profile.

### Error Message
None.

### Debug Logs
None.

### System Information
- OS: Windows 11
- Cortex version: `cortex 0.0.7 (7954d02 2026-03-30)`

### Screenshots
Evidence text file showing the bug:
https://raw.githubusercontent.com/princewillis/cortex-evidence/main/cortex_lock_cortex_home_bug_20260404_104633.txt

Terminal output showing the bug:
```
==========================================
REPRODUCING: cortex lock ignores CORTEX_HOME
==========================================

PS> $env:CORTEX_HOME = 'C:\temp\test_cortex_home'
PS> cortex lock add abcdef12 --reason 'Test lock'
Locked 1 session(s).

PS> Test-Path "$env:CORTEX_HOME\.cortex\session_locks.json"
False

PS> Test-Path "$env:USERPROFILE\.cortex\session_locks.json"
True

BUG: Lock file written to DEFAULT location instead of CORTEX_HOME!
```

### Steps to Reproduce
1. Set a custom CORTEX_HOME: `$env:CORTEX_HOME = "C:\temp\test_cortex_home"`
2. Create the directory: `New-Item -ItemType Directory -Force -Path "$env:CORTEX_HOME\.cortex"`
3. Add a session lock: `cortex lock add abcdef12 --reason "Test lock"`
4. Check if lock file exists in CORTEX_HOME: `Test-Path "$env:CORTEX_HOME\.cortex\session_locks.json"` - returns **False**
5. Check if lock file exists in default location: `Test-Path "$env:USERPROFILE\.cortex\session_locks.json"` - returns **True**

### Expected Behavior
The `cortex lock` command should write the `session_locks.json` file to `$CORTEX_HOME/.cortex/session_locks.json` when `CORTEX_HOME` is set, respecting the active profile like other cortex commands do.

### Actual Behavior
The `cortex lock` command always writes the lock file to `~/.cortex/session_locks.json` regardless of the `CORTEX_HOME` environment variable setting.

### Additional Context
This bug affects all lock subcommands (`add`, `remove`, `list`, `check`) since they all use the same `get_lock_file_path()` function which directly calls `dirs::home_dir()` instead of respecting `CORTEX_HOME`.
