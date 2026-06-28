#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: scripts/update-raskraska-formula.sh vX.Y.Z" >&2
}

if [[ $# -ne 1 ]]; then
  usage
  exit 2
fi

tag="$1"
if [[ ! "${tag}" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "error: tag must match vX.Y.Z, got: ${tag}" >&2
  exit 2
fi

repo_url="https://github.com/benzolium/raskraska"
archive_url="${repo_url}/archive/refs/tags/${tag}.tar.gz"
formula="Formula/raskraska.rb"

if [[ ! -f "${formula}" ]]; then
  echo "error: run this script from the homebrew-tap repository root" >&2
  exit 1
fi

tmp_dir="$(mktemp -d)"
trap 'rm -rf "${tmp_dir}"' EXIT

archive="${tmp_dir}/raskraska-${tag}.tar.gz"
curl -fsSL "${archive_url}" -o "${archive}"
sha256="$(shasum -a 256 "${archive}" | awk '{ print $1 }')"

sed -i.bak -E \
  "s#^  url \".*\"#  url \"${archive_url}\"#" \
  "${formula}"
sed -i.bak -E \
  "s#^  sha256 \".*\"#  sha256 \"${sha256}\"#" \
  "${formula}"
rm -f "${formula}.bak"

echo "Updated ${formula} to ${tag}"
echo "SHA256: ${sha256}"
echo
echo "Next steps:"
echo "  brew style ${formula}"
echo "  git add ${formula}"
echo "  git commit -m \"Update raskraska to ${tag}\""
echo "  git push"
echo "  brew update"
echo "  brew audit --formula benzolium/tap/raskraska"
echo "  brew fetch benzolium/tap/raskraska"
echo "  brew install --build-from-source benzolium/tap/raskraska"
echo "  brew test benzolium/tap/raskraska"
