git-gutter+.el
==============

View, stage and revert Git changes straight from the buffer.

(This package is inspired by the [GitGutter](https://github.com/jisaacks/GitGutter)
plugin for Sublime Text. It contains patches that haven't yet been added
to [Git-Gutter](https://github.com/syohex/emacs-git-gutter).)

![git-gutter](images/stage-and-commit-animation.gif)

[Changelog](#changelog-1)
-----------
Jump to [Changelog](#changelog-1).

Get Started
-----------

Use the predefined [use-package setup](#use-package-setup) or follow these steps:

* Install with package.el

  Add [MELPA](https://melpa.org/#/getting-started) as a package source.
  Run `M-x package-install git-gutter+`

* Add the following to your .emacs file

        (global-git-gutter+-mode)

  If you want to disable git-gutter+ for some modes, set the variable
  `git-gutter+-disabled-modes`.

  As an alternative to `global-git-gutter+-mode` you can enable git-gutter+ only for
  specific modes, like this:

        (add-hook 'ruby-mode-hook 'git-gutter+-mode)
        (add-hook 'python-mode-hook 'git-gutter+-mode)

* Add keybindings

        (global-set-key (kbd "C-x g") 'git-gutter+-mode) ; Turn on/off in the current buffer
        (global-set-key (kbd "C-x G") 'global-git-gutter+-mode) ; Turn on/off globally

        (eval-after-load 'git-gutter+
          '(progn
             ;;; Jump between hunks
             (define-key git-gutter+-mode-map (kbd "C-x n") 'git-gutter+-next-hunk)
             (define-key git-gutter+-mode-map (kbd "C-x p") 'git-gutter+-previous-hunk)

             ;;; Act on hunks
             (define-key git-gutter+-mode-map (kbd "C-x v =") 'git-gutter+-show-hunk)
             (define-key git-gutter+-mode-map (kbd "C-x r") 'git-gutter+-revert-hunks)
             ;; Stage hunk at point.
             ;; If region is active, stage all hunk lines within the region.
             (define-key git-gutter+-mode-map (kbd "C-x t") 'git-gutter+-stage-hunks)
             (define-key git-gutter+-mode-map (kbd "C-x c") 'git-gutter+-commit)
             (define-key git-gutter+-mode-map (kbd "C-x C") 'git-gutter+-stage-and-commit)
             (define-key git-gutter+-mode-map (kbd "C-x C-y") 'git-gutter+-stage-and-commit-whole-buffer)
             (define-key git-gutter+-mode-map (kbd "C-x U") 'git-gutter+-unstage-whole-buffer)))


[git-gutter-fringe+.el](https://github.com/nonsequitur/git-gutter-fringe-plus)
-----------------------

![git-gutter-fringe-minimal](https://raw.github.com/nonsequitur/git-gutter-fringe-plus/master/images/git-gutter-fringe-minimal.png)

*(git-gutter-fringe+ with minimal skin)*

[git-gutter-fringe+.el](https://github.com/nonsequitur/git-gutter-fringe-plus) uses
the fringe to display diff markers, instead of the buffer margin.

These are the differences to the default margin display mode in git-gutter+:

|                          | git-gutter+.el | git-gutter-fringe+.el |
|:-------------------------|:-------------:|:--------------------:|
| Works in tty frame       | +             | -                    |
| Works with linum-mode    | -             | +                    |
| Gutter on the right side | -             | +                    |

Enable git-gutter-fringe+ like this:

    M-x package-install git-gutter-fringe+
    (require 'git-gutter-fringe+)

    ;; Optional: Activate minimal skin
    (git-gutter-fr+-minimal)

To interactively disable/enable the fringe display mode, run
`M-x git-gutter+-toggle-fringe`.

Commands
--------

#### `git-gutter+-mode`
Enable/disable git-gutter+ in the current buffer.

#### `global-git-gutter+-mode`
Globally enable/disable git-gutter+ for all file buffers.

#### `git-gutter+-next-hunk`

Jump to the next hunk.

#### `git-gutter+-previous-hunk`

Jump to the previous hunk.

#### `git-gutter+-show-hunk`

Show detailed diff for the hunk at point.

The hunk info is updated when you call
`git-gutter+-next-hunk` and `git-gutter+-previous-hunk`.

#### `git-gutter+-show-hunk-inline-at-point`

An alternative to `git-gutter+-show-hunk`.
Shows the diff by expanding it at point, without opening a new buffer.

#### `git-gutter+-revert-hunks`

Revert hunk at point. If region is active, revert all hunks
within the region.

#### `git-gutter+-stage-hunks`

Stage hunk at point. If region is active, stage all hunk
lines within the region.

#### `git-gutter+-commit`

Commit staged changes.
If nothing is staged, ask to stage the current buffer.

#### `git-gutter+-stage-and-commit`

Calls `git-gutter+-stage-hunks` followed by `git-gutter+-commit`.

#### `git-gutter+-stage-and-commit-whole-buffer`

Stages and commits the whole buffer.

#### `git-gutter+-unstage-whole-buffer`

Unstages all changes in the current buffer.
Use this to undo any effects caused by `git-gutter+-stage-hunks`.

Committing
----------

The commit message buffer is based on
[git-commit](https://github.com/magit/magit/blob/master/lisp/git-commit.el).
Besides the default `git-commit-mode` bindings, the following bindings
are provided:

* `C-c C-a` toggles the option to amend the previous commit.

* `C-c C-e` toggles the option to allow an empty commit that
  includes no changes.

* `C-c C-u` toggles the option to edit the commit author.

* `C-c C-d` toggles the option to edit the commit date.

* `M-p`/`M-n` insert previous/next history commit message.

`git-commit-ack` is re-bound to `C-c C-b`.

Changelog
---------
### 0.4
  * 2 enhancements:
    * Added `git-gutter+-show-hunk-inline-at-point`
    * The Readme now contains a `use-package` quick-start setup
  * 2 fixes:
    * Fixed `git-gutter+-unstage-whole-buffer` to only unstage changes from the current buffer
    * Various code cleanups

### 0.3
  * 3 fixes:
    * Fixed staging and committing with Tramp
    * Fixed errors with symlinked files
    * Support the latest version of `git-commit'

### 0.2
  * 2 enhancements:
    * New interactive functions `git-gutter+-stage-and-commit-whole-buffer` and
      `git-gutter+-unstage-whole-buffer`
    * Refresh gutter when a buffer is staged or unstaged in Magit
  * 4 fixes:
    * `M-p` is now guaranteed to insert the message of the previous commit
    * Fixed compatibility with current versions of `git-commit-mode`
    * `git-gutter+-diff-args` is now properly handled as a list of strings
    * Fixed extraneous window splits that occured when displaying staged changes
      before committing

### 0.1
  * New commit interface based on git-commit-mode.
    See section 'Committing' to learn more.
  * Added `git-gutter+-mode-map`.
    Consider migrating some of your global git-gutter+ bindings to the local
    keymap.
    See section 'Add keybindings' for an example.
  * Properly support narrowed buffers
  * Revert hunks within region (or hunk at point) with `git-gutter+-revert-hunks`
    Please update your key binding.
    (The old name 'git-gutter+-revert-hunk' is still accessible by an alias.)
  * Renamed `git-gutter+-popup-hunk` to `git-gutter+-show-hunk`
    Please update your key binding.
    (The old name is still accessible by an alias.)
  * Added customizable variable 'git-gutter+-git-executable'
  * Package git-gutter-fringe+:
    Added `git-gutter+-toggle-fringe` to enable/disable the fringe display mode.

### 0.02 (Changes since [Git-Gutter](https://github.com/syohex/emacs-git-gutter) 0.42)
  * Improved performance
  * Staging and committing hunks
  * A bug-free `git-gutter-fringe.el` and other fixes
  * The following interactive commands have been removed.
    They are superseded by `git-gutter+-mode`.
    * git-gutter
    * git-gutter-toggle
    * git-gutter-clear
  * Removed mode-on/off-hook variables
  * Renamed `git-gutter-diff-option` to `git-gutter-diff-options`

Requirements
------------

* Emacs 23 or higher
* [Git](http://git-scm.com/) 1.7.0 or higher

Tramp
-----

Git-Gutter supports TRAMP for remote file support.

Use-Package Setup
-----------------------

    (use-package git-gutter+
      :ensure t
      :init (global-git-gutter+-mode)
      :config (progn
                (define-key git-gutter+-mode-map (kbd "C-x n") 'git-gutter+-next-hunk)
                (define-key git-gutter+-mode-map (kbd "C-x p") 'git-gutter+-previous-hunk)
                (define-key git-gutter+-mode-map (kbd "C-x v =") 'git-gutter+-show-hunk)
                (define-key git-gutter+-mode-map (kbd "C-x r") 'git-gutter+-revert-hunks)
                (define-key git-gutter+-mode-map (kbd "C-x t") 'git-gutter+-stage-hunks)
                (define-key git-gutter+-mode-map (kbd "C-x c") 'git-gutter+-commit)
                (define-key git-gutter+-mode-map (kbd "C-x C") 'git-gutter+-stage-and-commit)
                (define-key git-gutter+-mode-map (kbd "C-x C-y") 'git-gutter+-stage-and-commit-whole-buffer)
                (define-key git-gutter+-mode-map (kbd "C-x U") 'git-gutter+-unstage-whole-buffer))
      :diminish (git-gutter+-mode . "gg"))

This section of the manual hasn't yet been cleaned up. (But it's factually correct.)
------------------------------------------------------------------------------------

## Customize

### Look and feel

![git-gutter-multichar](images/git-gutter-multichar.png)

You can change the signs and those faces.

```elisp
(setq git-gutter+-modified-sign "  ") ;; two space
(setq git-gutter+-added-sign "++")    ;; multiple character is OK
(setq git-gutter+-deleted-sign "--")

(set-face-background 'git-gutter+-modified "purple") ;; background color
(set-face-foreground 'git-gutter+-added "green")
(set-face-foreground 'git-gutter+-deleted "red")
```

You can change minor-mode name in mode-line to set `git-gutter+-lighter`.
Default is " GitGutter"

```elisp
;; first character should be a space
(setq git-gutter+-lighter " GG")
```


### Using full width characters

![git-gutter-fullwidth](images/git-gutter-fullwidth.png)

Emacs has `char-width` function which returns character width.
`git-gutter+.el` uses it for calculating character length of the signs.
But `char-width` does not work for some full-width characters.
So you should explicitly specify window width, if you use full-width
character.

```elisp
(setq git-gutter+-window-width 2)
(setq git-gutter+-modified-sign "☁")
(setq git-gutter+-added-sign "☀")
(setq git-gutter+-deleted-sign "☂")
```

### Disabled modes

If you use `global-git-gutter+-mode`, you may want some modes to disable
`git-gutter+-mode`. You can make it by setting `git-gutter+-disabled-modes`
to `non-nil`.

```elisp
;; inactivate git-gutter+-mode in asm-mode and image-mode
(setq git-gutter+-disabled-modes '(asm-mode image-mode))
```

Default is `nil`.

### Show Unchanged Information

![git-gutter-unchanged](images/git-gutter-unchanged.png)

`git-gutter+.el` can view unchanged information by setting `git-gutter+-unchanged-sign`.
Like following.

```elisp
(setq git-gutter+-unchanged-sign " ")
(set-face-background 'git-gutter+-unchanged "yellow")
```

Default value of `git-gutter+-unchanged-sign` is `nil`.

### Show a separator column

![git-gutter-separator](images/git-gutter-separator.png)

`git-gutter+.el` can display an additional separator character at the right of the changed
signs. This is mostly useful when running emacs in a console.

```elisp
(setq git-gutter+-separator-sign "|")
(set-face-foreground 'git-gutter+-separator "yellow")
```

Default value of `git-gutter+-separator-sign` is `nil`.

### Hide gutter if there are no changes

Hide gutter when there are no changes if `git-gutter+-hide-gutter` is non-nil.
(Default is nil)

```elisp
(setq git-gutter+-hide-gutter t)
```

### Extra arguments for 'git diff'

You can force extra arguments to be passed to `git diff` by setting
`git-gutter+-diff-options`.

```elisp
;; Ignore all spaces
(setq git-gutter+-diff-options '("-w"))
```

## See Also

### [GitGutter](https://github.com/jisaacks/GitGutter)

GitGutter is Sublime Text plugin.

### [diff-hl](https://github.com/dgutov/diff-hl)

`diff-hl` has more features than `git-gutter+.el`.

### [vim-gitgutter](https://github.com/airblade/vim-gitgutter)

Vim version of GitGutter
