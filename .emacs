; Change go-to-line shortcut
(global-set-key "\M-g" 'goto-line)

; Allow overwriting of highlighted text
(delete-selection-mode 1)

; Line numbering
(global-linum-mode 1)
(setq linum-format "%2d \u2502")

; Tabs
(setq-default indent-tabs-mode nil)
(setq tab-width 4)

; Show matching parentheses
(show-paren-mode 1)

; Show unique file path names
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

; For .m files
(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))

; Define ctag functionality (not yet working)
(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
   (format "ctags %s"(directory-file-name dir-name)))
;   (format "ctags -f %s -e -R %s" path-to-ctags (directory-file-name dir-name)))
  )

(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  )

; Improve performance in loading large files
(require 'vlf-setup)
;(defun my-find-file-check-make-large-file-read-only-hook ()
;  "If a file is over a given size, make the buffer read only."
;  (when (> (buffer-size) (* 1024 1024))
;    (setq buffer-read-only t)
;    (buffer-disable-undo)
;    (fundamental-mode)))
;
;(add-hook 'find-file-hook 'my-find-file-check-make-large-file-read-only-hook)

;(add-to-list 'load-path "~/.emacs.d/elpa")
;(require 'xclip)
;(load "xclip")
(xclip-mode 1)
;(setq x-select-enable-clipboard t)
;(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
;(setq x-select-enable-primary nil)
