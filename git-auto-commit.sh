#!/usr/bin/env bash
set -euo pipefail

#
# git-auto-commit.sh [ブランチ名]
#

if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "Git リポジトリ内で実行してください" >&2
    exit 1
fi

BRANCH="${1:-$(git branch --show-current)}"

git switch "$BRANCH"

if git diff --staged --quiet; then
    echo "全ての変更をステージングします"
    git add -A

    if git diff --staged --quiet; then
        echo "コミットする変更がありません"
        exit 0
    fi
fi

git commit -m "$(date +'%F %T')"
git push origin "$BRANCH"