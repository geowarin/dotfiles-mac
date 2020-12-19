# Change working directory to the top-most Finder window location
function cdf() { # short for `cdfinder`
	cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')";
}

# Helper function to manages brew bundle
function bb() {
	CMD="brew bundle --file=$XDG_CONFIG_HOME/brew/Brewfile"
	RED='\033[0;31m'
	BLUE='\033[0;34m'
	NC='\033[0m'
	case $1 in
        help)
			printf "Usage :\n\n"
			printf "${BLUE}bb diff${NC}: diffs currently installed program vs Brewfile\n"
			printf "${BLUE}bb update${NC}: Update installed brew packages\n"
			printf "${BLUE}bb commit${NC}: Commits all installed brew packages to Brewfile\n"
			printf "${BLUE}bb clean${NC}: Clean all packages in environment not found in Brewfile\n"
            ;;
        diff)
            diff -wy <(cat $XDG_CONFIG_HOME/brew/Brewfile) <(brew bundle dump dump --file=-)
            ;;
        update)
			pushd "$(brew --repo)"
			git prune && git gc
			popd
            brew update && eval "${CMD} install" && brew cleanup
            ;;
        commit)
            eval "${CMD} dump --force"
            ;;
        clean)
            eval "${CMD} cleanup --force"
            ;;
        *)
			printf "${RED}ERROR${NC}: unknown parameter ${1}\n\n"
            bb help
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
