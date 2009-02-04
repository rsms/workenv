#!/bin/sh
# Install in ~/bin/less-colorize.sh or something
case "$1" in
 # add all extensions you want to handle here
 *.awk|*.groff|*.java|*.js|*.m4|*.php|*.pl|*.pm|*.pod|*.sh|\
 *.ad[asb]|*.asm|*.inc|*.[ch]|*.[ch]pp|*.[ch]xx|*.cc|*.hh|\
 *.lsp|*.l|*.pas|*.p|*.xml|*.xps|*.xsl|*.axp|*.ppd|*.pov|\
 *.diff|*.patch|*.py|*.rb|*.sql|*.ebuild|*.eclass)
    pygmentize -O bg=dark "$1" ;;
 *.plist|*.xspf)
    pygmentize -O bg=dark -l xml "$1" ;;
 *) exit 0;;
esac