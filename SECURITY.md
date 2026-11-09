# Security

Report a vulnerability privately, through GitHub's private vulnerability
reporting: the repository's **Security** tab, then **Report a vulnerability**.
Don't open a public issue for it.

Practices is Markdown and one shell script, `load.sh`, which every opted-in
session runs from `main`. A change that would make `load.sh` do more than print
the rules is in scope.
