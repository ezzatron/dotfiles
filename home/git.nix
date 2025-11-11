{ config, ... }:
{
  programs.git = {
    enable = true;

    signing = {
      signByDefault = true;
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKRaKzNLwVvprRZIs3q+ZSU1mnvyvTr/YM04/pAc9r7S";
    };

    ignores = [
      # files created by macOS
      ".DS_Store"
      ".AppleDouble"
      ".LSOverride"
      ".Spotlight-V100"
      ".nfs.*"

      # editor configuration files
      ".idea/"
      ".vs/"
      ".vscode/"
      "*.xcuser*"

      # environment configuration files
      ".envrc"
      ".env.local"
      ".env.*.local"
      "go.work"
      "go.work.sum"
    ];

    attributes = [
      # don't diff lock files
      "go.sum binary"
      "package-lock.json binary"
      "pnpm-lock.yaml binary"
      "yarn.lock binary"
    ];

    includes = [
      { path = "${config.home.homeDirectory}/.config/git/private.gitconfig"; }
    ];

    settings = {
      user = {
        email = "contact@erin.id.au";
        name = "Erin Millard-Wright";
      };

      alias = {
        # better blame
        credit = "blame -w -M -C -C -C";
        # character diff
        diff-chars = "diff -w --word-diff --word-diff-regex='[^[:space:]]'";
        # shows the diff against the latest tag
        diff-release = "!git diff '$(git describe --abbrev=0)..'";
        # diff against the upstream branch
        diff-upstream = "diff @{upstream}";
        # word diff
        diff-words = "diff -w --word-diff";
        # list branches that are ahead of or behind their upstream
        diverged-branches = "!git for-each-ref --format='%(refname:short) %(upstream:track)' refs/heads/ | awk '/ahead|behind/'";
        # list local branches without a remote
        local-branches = "!git branch --format '%(refname:short) %(upstream:short)' | awk '{if (!$2) print $1;}'";
        # shows the log since the latest tag
        log-release = "!git -P log '$(git describe --abbrev=0)~1..'";
        # better force push
        push-force = "push --force-with-lease --force-if-includes";
        # push tags and associated commits atomically
        push-tags = "!git push --follow-tags --atomic";
        # step through each commit in a range and show the diff
        # close the pager to go to the next commit, or use control-C to exit
        show-all = "!f() { git log --reverse --pretty=format:%h \"$1\" | xargs -n1 -I% sh -c 'git -P -c color.ui=always show % | tail -n +1 | less --tabs 1,3'; }; f";
        # create a tag in a way that allows for Markdown headings
        tag-md = "!git tag --annotate --cleanup=whitespace --edit --message \"$1\"";
        # customize git show pretty format - needs paired git function
        x-show = "!git show --pretty='%C(cyan dim)%h%C(reset)%C(cyan)%d%C(reset) %C(yellow)|%C(reset) %C(bold white)%s%C(reset) %C(dim)by %an — %ar%C(reset)%n%n%C(dim)Author:%C(reset)  %an %C(dim)<%ae>%C(reset)%n         %C(dim)%ad — %ar%C(reset)%n%n%C(dim)Commit:%C(reset)  %C(cyan)%h%C(reset) — %C(cyan dim)%H%C(reset)%n         %cn %C(dim)<%ce>%C(reset)%n         %C(dim)%cd — %cr%C(reset)%n%n%C(dim)Parents:%C(reset) %C(cyan)%p%C(reset) — %C(cyan dim)%P%C(reset)%n%n%w(,4,4)%-b%-'";
      };

      branch = {
        # sort branches by committer date
        sort = "-committerdate";
      };

      commit = {
        # the "scissors" cleanup mode is nice for entering markdown in commit messages
        cleanup = "scissors";
        # sign commit messages
        gpgsign = true;
        # show diffs in commit editors
        verbose = true;
      };

      core = {
        # convert Windows-style line endings to *nix-style when adding to the index
        autocrlf = "input";
        # use VSCode as the editor
        editor = "code --wait";
      };

      credential = {
        # cache credentials when using non-SSH repo clones
        helper = "cache --timeout=43200"; # 12 hours
      };

      diff = {
        # use a better diff algorithm
        algorithm = "histogram";
        # use better coloring for moved lines
        colorMoved = "plain";
        # use meaningful prefixes in diff headers instead of a/ and b/
        mnemonicPrefix = true;
        # increase the max number of files to consider when detecting renamed files
        renameLimit = 2000;
        # detect renames and copies
        renames = "copies";
        # use a visual diff tool when using the "git difftool" command
        tool = "vscode";
      };

      difftool = {
        # skip prompting on every invocation of the diff tool
        prompt = false;

        "vscode" = {
          # specify the correct arguments for VSCode to act as a visual diff tool
          cmd = "code --wait --diff $LOCAL $REMOTE";
        };
      };

      fetch = {
        # before fetching, remove any branches that were deleted upstream
        prune = true;
        # before fetching, remove any tags that were deleted upstream
        pruneTags = true;
      };

      format = {
        # produce nice-looking logs
        pretty = "%C(cyan dim)%h%C(reset)%C(cyan)%d%C(reset) %C(yellow)|%C(reset) %s %C(dim)by %an — %ar%C(reset)";
      };

      gpg = {
        # sign with an SSH key instead of GPG
        format = "ssh";

        "ssh" = {
          # this must be configured in order to verify SSH signatures on commits
          allowedSignersFile = "${config.home.homeDirectory}/.ssh/allowed_signers";
        };
      };

      init = {
        # use "main" as the default branch name for new repos
        defaultBranch = "main";
      };

      log = {
        # format dates in strict ISO-8601 format
        date = "iso-strict";
      };

      merge = {
        # show more context in conflict markers
        conflictstyle = "zdiff3";
        # only use fast-forward merges unless --no-ff is explicitly specified
        ff = "only";
      };

      pull = {
        # stop Git from automatically trying to merge outdated branches when pulling
        ff = "only";
      };

      push = {
        # automatically set upstream branches when pushing
        autoSetupRemote = true;
        # push only the current branch to a branch of the same name
        # this means that pushing new branches upstream is as simple as "git push -u"
        default = "current";
      };

      rebase = {
        # enable autosquashing by default
        autoSquash = true;
        # stash before rebasing
        autoStash = true;
        # update "stacked" branches when rebasing
        updateRefs = true;
      };

      rerere = {
        # enable the reuse recorded resolution feature
        enabled = true;
      };

      stash = {
        # show untracked content when using "git stash show"
        showIncludeUntracked = true;
        # show the actual content when using "git stash show"
        showPatch = true;
        # don't show the stat summary when using "git stash show"
        showStat = false;
      };

      tag = {
        # sort tags by version when using "git tag" to list tags
        sort = "-version:refname";
      };

      url = {
        # always use SSH for GitHub URLs
        "ssh://git@github.com" = {
          insteadOf = "https://github.com";
        };
      };
    };
  };
}
