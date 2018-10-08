set -x
sake --file=$project_root_dir/Sakefile 
c=$?
echo =================================
echo exit code: {$c};
