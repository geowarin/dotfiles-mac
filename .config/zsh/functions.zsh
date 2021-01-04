
# Create a new directory and enter it
function mkd() {
	mkdir -p "$@" && cd "$_";
}

# Determine size of a file or total size of a directory
function fs() {
	if du -b /dev/null > /dev/null 2>&1; then
		local arg=-sbh;
	else
		local arg=-sh;
	fi
	if [[ -n "$@" ]]; then
		du $arg -- "$@";
	else
		du $arg .[^.]* ./*;
	fi;
}

# Start an HTTP server from a directory, optionally specifying the port
function server() {
	local port="${1:-8000}";
	sleep 1 && open "http://localhost:${port}/" &
	# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
	# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
	python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port";
}

# Compare original and gzipped file size
function gz() {
	local origsize=$(wc -c < "$1");
	local gzipsize=$(gzip -c "$1" | wc -c);
	local ratio=$(echo "$gzipsize * 100 / $origsize" | bc -l);
	printf "orig: %d bytes\n" "$origsize";
	printf "gzip: %d bytes (%2.2f%%)\n" "$gzipsize" "$ratio";
}

# Shows real path of a binary, following symlinks
function w() {
	perl -MCwd -le 'print Cwd::abs_path(shift)' `which $@`
}

# Downloads a site completely with wget
function dl-site() {
	wget --mirror --convert-links --adjust-extension --page-requisites -U Mozilla --no-parent -e robots=off --wait=3 --random-wait --limit-rate=900k --no-check-certificate $@
}

# download a video from url
vlcd() {
	local FILENAME=$(echo $1 | rev | cut -d"/" -f1 | rev)
	echo "downloading to /tmp/${FILENAME}.mp4..."
	vlc -v $1 --sout file/ts:/tmp/${FILENAME}.mp4
}

# run in background and detach
bgh() { 
	"$@" &>/dev/null & 
}