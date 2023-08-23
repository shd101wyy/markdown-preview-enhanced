#!/bin/sh
#
# https://jloh.co/posts/bulk-migrate-issues-github-cli/
gh issue list -s all -L 500 --json number | \
    jq -r '.[] | .number' | \
    xargs -I% gh issue transfer % https://github.com/shd101wyy/vscode-markdown-preview-enhanced
