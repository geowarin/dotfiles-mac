
# Create a new directory and enter it
function mkd() {
	mkdir -p "$@" && cd "$_";
}

# Change working directory to the top-most Finder window location
function cdf() { # short for `cdfinder`
	cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')";
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

# Helper function to manages brew bundle
function bb() {
	CMD="brew bundle --file=$XDG_CONFIG_HOME/brew/Brewfile"
	case $1 in
        help)
            echo "bb diff: diffs currently installed program vs Brewfile"
            echo "bb update: Update isntalled brew packages"
            echo "bb commit: Commits all installed brew packages to Brewfile"
            echo "bb clean: Clean all packages in environment not found in Brewfile"
            ;;
        diff)
            diff -wy <(cat $XDG_CONFIG_HOME/brew/Brewfile) <(brew bundle dump dump --file=-)
            ;;
        update)
            brew update && eval "${CMD} install" && brew cleanup
            ;;
        commit)
            eval "${CMD} dump --force"
            ;;
        clean)
            eval "${CMD} cleanup --force"
            ;;
        *)
            echo "ERROR: unknown parameter \"$1\""
            ;;
	esac
}

jdk() {
	if [ $# -ne 0 ]; then
		removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'
		if [ -n "${JAVA_HOME+x}" ]; then
			removeFromPath $JAVA_HOME
		fi
		export JAVA_HOME=`/usr/libexec/java_home -v $@`
		export PATH=$JAVA_HOME/bin:$PATH
	fi
}


removeFromPath() {
	export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
}
	