# Prints the standards at practices' main: a header naming the commit, core.md,
# and the skills' index. Run by a repository's .agents/practices.sh as
# `sh -c "$load" load.sh <cache>`, where <cache>/repo.git is a bare clone of
# practices.
set -eu

cache=$1
repo=$cache/repo.git
commit=$(git -C "$repo" rev-parse --verify 'main^{commit}')
date=$(git -C "$repo" show -s --format=%cs "$commit")
tree=$cache/trees/$commit

# Each commit is extracted once, into a staging directory that is renamed into
# place, so a session never reads a half-written tree.
if [ ! -d "$tree" ]; then
  staging=$cache/trees/.staging.$$
  index=$staging.index
  # Another session may publish the same commit first. mv then fails, or moves
  # this staging directory inside that tree, where the trap removes it.
  trap 'rm -rf "$staging" "$index" "$tree/${staging##*/}"' EXIT
  mkdir -p "$staging"
  GIT_INDEX_FILE=$index git -C "$repo" read-tree "$commit"
  GIT_INDEX_FILE=$index git --git-dir="$repo" --work-tree="$staging" checkout-index -a
  [ -d "$tree" ] || mv "$staging" "$tree" 2>/dev/null || [ -d "$tree" ] ||
    { echo "practices: could not create $tree" >&2; exit 1; }
fi

printf '%s\n' "practices $commit, $date. Where they differ, this repository's AGENTS.md wins over what follows, and the approved issue wins over both; no layer weakens a check to merge."
printf '\n'
cat "$tree/core.md"
[ ! -d "$tree/skills" ] || printf '\n%s\n' 'Skills. Read the file before doing the activity:'
for skill in "$tree"/skills/*/SKILL.md; do
  [ -f "$skill" ] || continue
  name=$(sed -n '2,/^---$/s/^name:[[:space:]]*//p' "$skill")
  description=$(sed -n '2,/^---$/s/^description:[[:space:]]*//p' "$skill")
  printf -- '- %s: %s %s\n' "$name" "${description%.}." "$skill"
done
