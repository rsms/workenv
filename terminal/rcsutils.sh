# RCS utilities living in ~/.bash-rcsutils
if [ "$(which pygmentize)" != "" ] ;then
  pyglessfilter() {
    pygmentize -l diff -O bg=dark -P encoding=utf-8 | /usr/bin/less --no-lessopen -R --line-numbers
  }
else
  alias pyglessfilter='cat'
fi

pull() {
  if [ -d .hg ] || [ -d ../.hg ] || [ -d ../../.hg ] || [ -d ../../../.hg ]; then
    hg pull -u $*
  elif [ -d .git ] || [ -d ../.git ] || [ -d ../../.git ] || [ -d ../../../.git ]; then
    git pull origin $*
  elif [ -d .svn ]; then
    svn up $* | perl -we 'local $endpiece=""; local @conflicts=(); while(<>){
      if(m/^A/) { print "\033[1;32m"; }
      elsif(m/^D/) { print "\033[1;31m"; }
      elsif(m/^U/) { print "\033[1;36m"; }
      elsif(m/^C/) { print "\033[1;33m"; push(@conflicts, $_); }
      elsif(m/^G/) { print "\033[1m"; }
      elsif(m/^(?:Fetching external item)/) {
        print "\033[1;30m";
        s/\'"'"'(.[^\'"'"']+)\'"'"'\n/\033[m$1\033[1;30m/gm;
      }
      elsif(m/^(?:Fetching external item|External at revision)/) {
        print "\033[1;30m";
        s/External at revision (\d+).\n/ at revision \033[m$1\033[1;30m/gm;
        $endpiece = "\n";
      }
      print ;
      print "\033[0m";
    }
    print $endpiece;
    if(@conflicts) {
      print "$endpiece\033[1m\033[41mConflicts:\033[0m \n", @conflicts;
}'
  else
    echo 'No git or hg repository here' >&2
  fi
}

alias pu=pull
alias svnup=pull

st() {
  if [ -d .hg ] || [ -d ../.hg ] || [ -d ../../.hg ] || [ -d ../../../.hg ]; then
    hg -v status $*
  elif [ -d .git ] || [ -d ../.git ] || [ -d ../../.git ] || [ -d ../../../.git ]; then
    git status $*
  elif [ -d .svn ]; then
    svn ci -m $* | perl -we 'local $endpiece=""; local @conflicts=(); while(<>){
      if(m/^X/) { print "\033[1;30m"; }
      elsif(m/^[D!~]/) { print "\033[1;31m"; }
      elsif(m/^A/) { print "\033[1;32m"; }
      elsif(m/^[MR]/) { print "\033[1;36m"; }
      elsif(m/^ M/) { print "\033[36m"; }
      elsif(m/^(?:C|.C)/) { print "\033[1;33m"; push(@conflicts, $_); }
      elsif(m/^[IP]erforming status on external item/) {
        print "\033[1;30m";
        s/\'"'"'(.[^\'"'"']+)\'"'"'\n/\033[m$1\033[1;30m/gm;
        $endpiece = "\n";
      }
      if(m/^..L/) { s/^(..)L/$1\033[40mL/; }
      print ;
      print "\033[0m";
    };
    print $endpiece;
    if(@conflicts) {
      print "$endpiece\033[1m\033[41mConflicts:\033[0m \n", @conflicts;
    }'
  else
    echo 'No git, hg or svn repository here' >&2
  fi
}

df() {
  if [ -d .hg ] || [ -d ../.hg ] || [ -d ../../.hg ] || [ -d ../../../.hg ]; then
    hg diff -p $* | pyglessfilter
  elif [ -d .git ] || [ -d ../.git ] || [ -d ../../.git ] || [ -d ../../../.git ]; then
    git diff $*
  elif [ -d .svn ]; then
    svn diff -x -u -x -b $* | pyglessfilter
  else
    echo 'No git, hg or svn repository here' >&2
  fi
}

alias hgdiff=df

ci() {
  if [ -d .hg ] || [ -d ../.hg ] || [ -d ../../.hg ] || [ -d ../../../.hg ]; then
    hg -v ci -m $*
  elif [ -d .git ] || [ -d ../.git ] || [ -d ../../.git ] || [ -d ../../../.git ]; then
    git commit -m $*
  elif [ -d .svn ]; then
    svn ci -m $* | perl -we 'local $endpiece=""; local @conflicts=(); while(<>){
      if(m/^X/) { print "\033[1;30m"; }
      elsif(m/^[D!~]/) { print "\033[1;31m"; }
      elsif(m/^A/) { print "\033[1;32m"; }
      elsif(m/^[MR]/) { print "\033[1;36m"; }
      elsif(m/^ M/) { print "\033[36m"; }
      elsif(m/^(?:C|.C)/) { print "\033[1;33m"; push(@conflicts, $_); }
      elsif(m/^[IP]erforming status on external item/) {
        print "\033[1;30m";
        s/\'"'"'(.[^\'"'"']+)\'"'"'\n/\033[m$1\033[1;30m/gm;
        $endpiece = "\n";
      }
      if(m/^..L/) { s/^(..)L/$1\033[40mL/; }
      print ;
      print "\033[0m";
    };
    print $endpiece;
    if(@conflicts) {
      print "$endpiece\033[1m\033[41mConflicts:\033[0m \n", @conflicts;
    }'
  else
    echo 'No git, hg or svn repository here' >&2
  fi
}

push() {
  if [ -d .hg ] || [ -d ../.hg ] || [ -d ../../.hg ] || [ -d ../../../.hg ]; then
    hg push $*
  elif [ -d .git ] || [ -d ../.git ] || [ -d ../../.git ] || [ -d ../../../.git ]; then
    git push origin master $*
  else
    echo 'No git or hg repository here' >&2
  fi
}



#alias up="if [ -d .git ]; then git pull; elif [ -d .svn ]; then LANG=en_US.utf-8 svn up; elif [ -d CVS ]; then cvs -q up -d; else svk pull; fi"
#alias st="if [ -d .git ]; then git status; elif [ -d .svn ]; then LANG=en_US.utf-8 svn st -u; elif [ -d CVS ]; then cvs -q up -d -n; else svk st; fi"
