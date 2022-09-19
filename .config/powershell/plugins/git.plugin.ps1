<# Aliases ZSH #>
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh

# Functions
function gsr {& git svn rebase $args }
function gsd {& git svn dcommit $args }

function git_current_branch() {
  $ref=$(git symbolic-ref --quiet HEAD) 2> $null
  if (!$?) {
    $ref=$(git rev-parse --short HEAD) 2> $null
    if(!$?){ return }
  }
  echo $ref.Replace('refs/heads/', '')
}

function git_develop_branch() {
  if(!(git rev-parse --git-dir 2> $null)) {return ''}
  $develop=(git show-ref -q --verify refs/heads/dev 2> $null && echo 'dev'); if($develop) { return $develop }
  $develop=(git show-ref -q --verify refs/heads/devel 2> $null && echo 'devel'); if($develop) { return $develop }
  $develop=(git show-ref -q --verify refs/heads/development 2> $null && echo 'development'); if($develop) { return $develop }
  echo develop
}

function git_main_branch() {
  if(!(git rev-parse --git-dir 2> $null)) {return ''}
  $master=(git show-ref -q --verify refs/heads/origin/main 2> $null && echo 'main'); if($master) { return $master }
  $master=(git show-ref -q --verify refs/heads/main 2> $null && echo 'main'); if($master) { return $master }
  $master=(git show-ref -q --verify refs/heads/trunk 2> $null && echo 'trunk'); if($master) { return $master }
  $master=(git show-ref -q --verify refs/remotes/origin/main 2> $null && echo 'main'); if($master) { return $master }
  $master=(git show-ref -q --verify refs/remotes/origin/trunk 2> $null && echo 'trunk'); if($master) { return $master }
  $master=(git show-ref -q --verify refs/remotes/upstream/main 2> $null && echo 'main'); if($master) { return $master }
  $master=(git show-ref -q --verify refs/remotes/upstream/trunk 2> $null && echo 'trunk'); if($master) { return $master }
  echo master
}

function g {& git $args }
function gf {& git fetch $args }

function ga {& git add $args}
function gaa {& git add --all $args}
function gapa {& git add --patch $args}
function gau {& git add --update $args}
function gav {& git add --verbose $args}
function gap {& git apply $args}
function gapt {& git apply --3way $args}

function gb {& git branch $args }
function gba {& git branch -a $args }
function gbd {& git branch -d $args }
# function gbda {& git branch --no-color --merged | grep -vE "^([+*]|\s*($(git_main_branch)|$(git_develop_branch))\s*$)" | xargs git branch -d 2>/dev/null $args}
function gbD {& git branch -D $args }
function gbl {& git blame -b -w $args }
function gbnm {& git branch --no-merged $args }
function gbr {& git branch --remote $args }
function gbs {& git bisect $args }
function gbsb {& git bisect bad $args }
function gbsg {& git bisect good $args }
function gbsr {& git bisect reset $args }
function gbss {& git bisect start $args }

del alias:gc -Force
function gc {& git commit -v $args }
function gc! {& git commit -v --amend $args} 
function gcn! {& git commit -v --no-edit --amend $args} 
function gca {& git commit -v -a $args} 
function gca! {& git commit -v -a --amend $args} 
function gcan! {& git commit -v -a --no-edit --amend $args} 
function gcans! {& git commit -v -a -s --no-edit --amend $args} 
function gcam {& git commit -a -m $args} 
function gcsm {& git commit -s -m $args} 
function gcas {& git commit -a -s $args} 
function gcasm {& git commit -a -s -m $args}
del alias:gcb -Force
function gcb {& git checkout -b $args} 
function gcf {& git config --list $args}

function gcl {& git clone --recurse-submodules $args }
function gclean {& git clean -id $args }
function gpristine {& git reset --hard && git clean -dffx $args }
del alias:gcm -Force
function gcm {& git checkout $(git_main_branch) $args }
function gcd {& git checkout $(git_develop_branch) $args }
function gcmsg {& git commit -m $args }
function gco {& git checkout $args }
function gcor {& git checkout --recurse-submodules $args }
function gcount {& git shortlog -sn $args }
function gcp {& git cherry-pick $args }
function gcpa {& git cherry-pick --abort $args }
function gcpc {& git cherry-pick --continue $args }
del alias:gcs -Force
function gcs {& git commit -S $args }
function gcss {& git commit -S -s $args }
function gcssm {& git commit -S -s -m $args }

function gd {& git diff $args }
function gdca {& git diff --cached $args }
function gdcw {& git diff --cached --word-diff $args }
function gdct {& git describe --tags $(git rev-list --tags --max-count=1) $args }
function gds {& git diff --staged $args }
function gdt {& git diff-tree --no-commit-id --name-only -r $args }
# function gdup {& git diff @{upstream} $args }
function gdw {& git diff --word-diff $args }

function ggpull {& git pull origin "$(git_current_branch)" $args }
function ggpush {& git push origin "$(git_current_branch)" $args }

function ggsup {& git branch --set-upstream-to=origin/$(git_current_branch) $args }
function gpsup {& git push --set-upstream origin $(git_current_branch) $args }

function ghh {& git help $args}

function gignore {& git update-index --assume-unchanged $args }
function gignored {& git ls-files -v | grep "^[[:lower:]]" $args }

del alias:gl -Force
function gl {& git pull $args }
function glg {& git log --stat $args }
function glgp {& git log --stat -p $args }
function glgg {& git log --graph $args }
function glgga {& git log --graph --decorate --all $args }
function glgm {& git log --graph --max-count=10 $args }
function glo {& git log --oneline --decorate $args }
function glol {& git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' $args }
function glols {& git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat $args }
function glod {& git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' $args }
function glods {& git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short $args }
function glola {& git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all $args }
function glog {& git log --oneline --decorate --graph $args }
function gloga {& git log --oneline --decorate --graph --all $args }

del alias:gm -Force
function gm {& git merge $args }
function gmom {& git merge origin/$(git_main_branch) $args }
function gmtl {& git mergetool --no-prompt $args }
function gmtlvim {& git mergetool --no-prompt --tool=vimdiff $args }
function gmum {& git merge upstream/$(git_main_branch) $args }
function gma {& git merge --abort $args }

del alias:gp -Force
function gp {& git push $args }
function gpd {& git push --dry-run $args }
function gpf {& git push --force-with-lease $args }
function gpf! {& git push --force $args }
function gpoat {& git push origin --all && git push origin --tags $args }
function gpr {& git pull --rebase $args }
function gpu {& git push upstream $args }
del alias:gpv -Force
function gpv {& git push -v $args }

function gr {& git remote $args }
function gra {& git remote add $args }
function grb {& git rebase $args }
function grba {& git rebase --abort $args }
function grbc {& git rebase --continue $args }
function grbd {& git rebase $(git_develop_branch) $args }
function grbi {& git rebase -i $args }
function grbm {& git rebase $(git_main_branch) $args }
function grbom {& git rebase origin/$(git_main_branch) $args }
function grbo {& git rebase --onto $args }
function grbs {& git rebase --skip $args }
function grev {& git revert $args }
function grh {& git reset $args }
function grhh {& git reset --hard $args }
function groh {& git reset origin/$(git_current_branch) --hard $args }
function grm {& git rm $args }
function grmc {& git rm --cached $args }
function grmv {& git remote rename $args }
function grrm {& git remote remove $args }
function grs {& git restore $args }
function grset {& git remote set-url $args }
function grss {& git restore --source $args }
function grst {& git restore --staged $args }
function grt {& cd "$(git rev-parse --show-toplevel || echo .)" $args }
function gru {& git reset -- $args }
function grup {& git remote update $args }
function grv {& git remote -v $args }

function gsb {& git status -sb $args }
function gsd {& git svn dcommit $args }
function gsh {& git show $args }
function gsi {& git submodule init $args }
function gsps {& git show --pretty=short --show-signature $args }
function gsr {& git svn rebase $args }
function gss {& git status -s $args }
function gst {& git status $args }

function gstaa {& git stash apply $args }
function gstc {& git stash clear $args }
function gstd {& git stash drop $args }
function gstl {& git stash list $args }
function gstp {& git stash pop $args }
function gsts {& git stash show --text $args }
function gstu {& gsta --include-untracked $args }
function gstall {& git stash --all $args }
function gsu {& git submodule update $args }
function gsw {& git switch $args }
function gswc {& git switch -c $args }
function gswm {& git switch $(git_main_branch) $args }
function gswd {& git switch $(git_develop_branch) $args }

function gts {& git tag -s $args }
function gtv {& git tag | sort -V $args }

function gunignore {& git update-index --no-assume-unchanged $args }
function gunwip {& git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1 $args }
function gup {& git pull --rebase $args }
function gupv {& git pull --rebase -v $args }
function gupa {& git pull --rebase --autostash $args }
function gupav {& git pull --rebase --autostash -v $args }
function glum {& git pull upstream $(git_main_branch) $args }

function gam {& git am $args }
function gamc {& git am --continue $args }
function gams {& git am --skip $args }
function gama {& git am --abort $args }
function gamscp {& git am --show-current-patch $args }