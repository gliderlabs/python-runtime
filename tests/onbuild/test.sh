
testOnbuild() {
	local testdir="$(dirname $BASH_SOURCE)"
	local image="test-$(basename $testdir)"
	for version in $VERSIONS; do
		echo $version
		echo "FROM python-runtime:$version" > "$testdir/Dockerfile"
		docker build -q -t "$image" "$testdir" > /dev/null

		local output="$(docker run --rm $image which wget)"
		assertEquals "wget is not installed" \
			"/usr/bin/wget" "$output"
		
		docker rmi "$image" > /dev/null
	done
}
