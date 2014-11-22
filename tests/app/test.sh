
use-ip() {
	if which boot2docker > /dev/null; then
		boot2docker ip 2> /dev/null
	else
		echo "127.0.0.1"
	fi
}

testApp() {
	local testdir="$(dirname $BASH_SOURCE)"
	local image="test-$(basename $testdir)"
	for version in $VERSIONS; do
		echo $version
		echo "FROM python-runtime:$version" > "$testdir/Dockerfile"
		docker build -q -t "$image" "$testdir" > /dev/null
		
		local id="$(docker run -d -P $image)"
		sleep 1
		local addr="$(docker port $id 8080)"
		local output="$(curl -s ${addr/0.0.0.0/$(use-ip)})"
		docker rm -f "$id" > /dev/null 2>&1
		assertEquals "curl response not expected: $output" \
			"Hello World!" "$output"

		docker rmi "$image" > /dev/null 2>&1
	done
}
