set -x
sake --file=$project_root_dir/Sakefile foo.txt

set +x

echo -n "file touched " $(($(date +%s) - $(date +%s -r foo.txt))) " seconds ago"
echo
