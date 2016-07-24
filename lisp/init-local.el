(require-package 'yasnippet)

(when (eq system-type 'windows-nt)
  (add-to-list 'load-path "c:/Users/Shanicky/.emacs.d/site-lisp")
  (setenv "PATH" (concat (getenv "PATH") ":c:/Users/Shanicky/Workspace/go/bin"))
  (setenv "PATH" (concat (getenv "PATH") ":c:/Go/bin"))
  (setenv "GOPATH" "c:/Users/Shanicky/Workspace/go")
  (setq exec-path (append exec-path '("c:/Users/Shanicky/Workspace/go/bin"
                                      "c:/Go/bin"
                                      "c:/Users/Shanicky/Applications/Gow/bin"
                                      "c:/ProgramData/chocolatey/bin")))
  (setq default-directory "~/Workspace/")
  )


(when *is-a-mac*
  (setq default-directory "~/workspace/")
  (add-to-list 'load-path "~/.emacs.d/site-lisp/"   ))



;; scroll one line at a time (less "jumpy" than defaults)

;; (setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
;; (setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
;; (setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
;; (setq scroll-step 1) ;; keyboard scroll one line at a time
(require-package 'smooth-scrolling)
(smooth-scrolling-mode t)

(setq scroll-conservatively 101) ;; move minimum when cursor exits view, instead of recentering
(setq mouse-wheel-scroll-amount '(1)) ;; mouse scroll moves 1 line at a time, instead of 5 lines
(setq mouse-wheel-progressive-speed nil) ;; on a long mouse scroll keep scrolling by 1 line


(require 'yasnippet)
(yas-global-mode 1)

(require-package 'company)
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

(setq company-tooltip-limit 10)                      ; bigger popup window
(setq company-idle-delay 0)                        ; decrease delay before autocompletion popup shows
(setq company-echo-delay 0)                          ; remove annoying blinking
;;(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing
(setq company-minimum-prefix-length 1)

;; ;; company delay until suggestions are shown
;; (setq company-idle-delay 0.5)

;; weight by frequency

(setq company-transformers '(company-sort-by-backend-importance))

;; Add yasnippet support for all company backends
;; https://github.com/syl20bnr/spacemacs/pull/179
(defvar company-mode/enable-yas t "Enable yasnippet for all backends.")
(defun company-mode/backend-with-yas (backend)
  (if (or (not company-mode/enable-yas) (and (listp backend)    (member 'company-yasnippet backend)))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-files))


(add-hook 'prog-mode-hook 'turn-on-eldoc-mode)

;; ----------------- flycheck ----------------------------
(require-package 'flycheck-pos-tip)
(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode))
(eval-after-load 'flycheck
  '(custom-set-variables
    '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))

;; ----------------- ggtags ----------------------------
;; export GTAGSLIBPATH=$HOME/.gtags/
;; # Create a directory for holding database, since
;; # you cannot create a database in your system paths
;; mkdir ~/.gtags

;; # Create symbolic links to your external libraries
;; ln -s /usr/include usr-include
;; ln -s /usr/local/include/ usr-local-include

;; # Generate GNU Global database
;; gtags -c


;; (require-package 'ggtags)
;; (add-hook 'prog-mode-hook
;;           (lambda ()
;;             (ggtags-mode t)))

;; ----------------- common ----------------------------
(setq-default dotspacemacs-configuration-layers '(osx))
(global-subword-mode t)
(global-hl-line-mode t)                              ;; highlight current line
(auto-image-file-mode t)
;; (icomplete-mode t)
(blink-cursor-mode nil)

;;(define-key minibuffer-local-completion-map (kbd "SPC") 'minibuffer-complete-word)
(setq frame-title-format "You're here to try to understand *why* you made it")

;;(setq frame-title-format "No rest. No mercy. No matter world")
(setq read-buffer-completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)
(setq inhibit-startup-message t)                     ;; remove start animation
(setq user-full-name "Shanicky Chen")                ;; full name
(setq user-mail-address "shanickyc@gmail.com")       ;; email address
(setq default-major-mode 'text-mode)                 ;; default mode
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(mouse-avoidance-mode 'animate)                      ;; avoid the mouse
(setq auto-save-default nil)                         ;; no #filename#
(setq-default make-backup-files nil)
(setq x-select-enable-clipboard t)
(delete-selection-mode t)
(setq delete-active-region nil)

;; Let backspace and delete be defined as usual if
;; nothing is highlighted, otherwise the marked region is deleted
(defun kill-something() (interactive)
       (if (and mark-active transient-mark-mode)
           (kill-region (point) (mark))
         (backward-delete-char-untabify 1)))
;;(global-set-key [delete] 'kill-something)
(global-set-key [backspace] 'kill-something)


;; ----------------- editing ----------------------------
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(require-package 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C--") 'er/contract-region)

(require-package 'guide-key)
(setq guide-key/guide-key-sequence '("C-x" "C-c" "C-x 4" "C-x 5" "C-c ;" "C-c ; f" "C-c ' f" "C-x n" "C-x C-r" "C-x r" "C-c p" "C-c !" "C-c h"))


;; ----------------- appearance ----------------------------
;; (require-package 'sublime-themes)
;; (require 'sublime-themes)

;; gotham theme
(require-package 'gotham-theme)
(setq-default custom-enabled-themes '(gotham))
(load-theme 'gotham t)

;; (load-theme 'brin t)
;; (custom-theme-set-variables
;;  'brin
;;  '(linum-format " %i ")
;;  )


;; smart mode line
(require-package 'smart-mode-line)
(require 'smart-mode-line)
(require-package 'rich-minority)
(require 'rich-minority)
(rich-minority-mode 1)

(if after-init-time (sml/setup)
  (add-hook 'after-init-hook 'sml/setup))
(sml/apply-theme 'dark)

;; linum mode
(require 'linum+)
(global-linum-mode t)
(setq display-line-number-format "%3d||")


;; alpha
(set-frame-parameter (selected-frame) 'alpha '(97 80))
(add-to-list 'default-frame-alist '(alpha 96 80))

;; position
(setq default-frame-alistp
      '((vertical-scroll-bars)
        (tool-bar-lines . 0)
        (menu-bar-lines . 1)
        (left-fringe)))


;; font
;;(set-default-font "Terminus 15")
;;(set-default-font "Aurulent Sans Mono 13")
;;(set-default-font "FreeMono 15")
;;(set-default-font "Hasklig 13")
;;(set-default-font "Hasklig 13")

(defun windows-nt-apperence ()
  (set-default-font "Sayo UV Console HG 13")
  (set-frame-parameter nil 'fullscreen 'maximized)
  )

(defun no-windows-nt-apperence ()
  (set-default-font "Sayo UV Console HG 15")
  (setq initial-frame-alist '((top . 40) (left . 40) (width . 140) (height . 40))))

(if (eq system-type 'windows-nt)
    (windows-nt-apperence)
  (no-windows-nt-apperence))


;; popwin
(require-package 'popwin)
(require 'popwin)

(popwin-mode t)
(setq display-buffer-function 'popwin:display-buffer)

;; M-x dired-jump-other-window
(push '(dired-mode :position top) popwin:special-display-config)

;; M-!
(push "*Shell Command Output*" popwin:special-display-config)

;; M-x compile
(push '(compilation-mode :noselect t) popwin:special-display-config)

;; slime
(push "*slime-apropos*" popwin:special-display-config)
(push "*slime-macroexpansion*" popwin:special-display-config)
(push "*slime-description*" popwin:special-display-config)
(push '("*slime-compilation*" :noselect t) popwin:special-display-config)
(push "*slime-xref*" popwin:special-display-config)
(push '(sldb-mode :stick t) popwin:special-display-config)
(push 'slime-repl-mode popwin:special-display-config)
(push 'slime-connection-list-mode popwin:special-display-config)

;; vc
(push "*vc-diff*" popwin:special-display-config)
(push "*vc-change-log*" popwin:special-display-config)

;; undo-tree
(push '(" *undo-tree*" :width 0.3 :position right) popwin:special-display-config)

(global-set-key (kbd "C-z") popwin:keymap)


;; ----------------- ag ----------------------------
(setq ag-highlight-search t)
(setq ag-reuse-window t)
(setq ag-reuse-buffers t)

;; ----------------- programming common ----------------------------
;; projectile mode
                                        ; (require-package 'projectile)
                                        ; (require 'projectile)
                                        ; (projectile-global-mode)
                                        ; (add-hook 'prog-mode-hook 'projectile-mode)
                                        ; (add-hook 'ruby-mode-hook 'projectile-mode)
                                        ; (add-hook 'c++-mode-hook 'projectile-mode)
                                        ; (add-hook 'c-mode-hook 'projectile-mode)
                                        ; (setq projectile-enable-caching t)


;; ----------------- c/cpp common ----------------------------
(require-package 'dtrt-indent)
(add-hook 'c-mode-common-hook
          (lambda()
            (require 'dtrt-indent)
            (dtrt-indent-mode t)))

;; ----------------- golang ----------------------------
(when (memq window-system '(mac ns))
  (exec-path-from-shell-copy-env "GOPATH")
  (exec-path-from-shell-copy-env "GOROOT")
  (exec-path-from-shell-copy-env "PATH"))

(require-package 'go-mode)
(require 'go-mode)
(require-package 'company-go)
(require 'company-go)

(add-hook 'go-mode-hook (lambda ()
                          ;;                          (set (make-local-variable 'company-backends) (mapcar #'company-mode/backend-with-yas '(company-go)))
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode)))

(require-package 'gotest)
(require 'gotest)

;; get -u github.com/jstemmer/gotags
(require-package 'go-direx)
(require 'go-direx)

(push '("^\*go-direx:" :regexp t :position left :width 0.3 :dedicated t :stick t)
      popwin:special-display-config)

(require-package 'go-eldoc)
(add-hook 'go-mode-hook 'go-eldoc-setup)

;; go get -u sourcegraph.com/sqs/goreturns
;;(setq gofmt-command "goreturns")

(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)

;;(add-hook 'before-save-hook 'gofmt-before-save)


(require-package 'golint)
(require 'golint)


(when (not (eq system-type 'windows-nt))
  (require-package 'go-projectile)
  (require 'go-projectile)
  )

(require 'go-impl)

;;(load "rename.el")
;;(load "$GOPATH/src/code.google.com/p/go.tools/cmd/oracle/oracle.el")
;;(add-hook 'go-mode-hook 'go-oracle-mode)

(defun my-go-mode()
  (progn
    (local-set-key (kbd "C-c g") 'godef-jump)
    (local-set-key (kbd "C-c r") 'go-remove-unused-imports)
    (local-set-key (kbd "C-c i") 'go-goto-imports)
    (local-set-key (kbd "C-c b") 'pop-tag-mark)
    (local-set-key (kbd "C-c d") 'godef-describe)
    (local-set-key (kbd "C-c f") 'gofmt)
    (local-set-key (kbd "C-c e") 'go-errcheck)
    (local-set-key (kbd "C-c r") 'go-run)
    (local-set-key (kbd "C-c C-c") 'smart-compile)
    (local-set-key (kbd "C-c C-d") 'godoc-at-point)
    (local-set-key (kbd "C-c C-j") 'go-direx-pop-to-buffer)
    (local-set-key [(f4)] 'previous-error)
    (local-set-key [(f5)] 'next-error)
    )
  )

(add-hook 'go-mode-hook 'my-go-mode)
;; ----------------- ruby ----------------------------
(require-package 'rvm)
(require-package 'ruby-additional)
(require 'ruby-additional)
(require-package 'ruby-electric)
(require 'ruby-electric)
(require-package 'ruby-block)
(require 'ruby-block)
(require-package 'ruby-tools)
(require 'ruby-tools)
(require-package 'bundler)
(require 'bundler)
(ruby-block-mode nil)
(defun my-ruby-mode ()
  (setq ruby-deep-indent-paren nil)
  (ruby-block-mode t)
  (rvm-activate-corresponding-ruby)
  (local-set-key (kbd "C-c i") 'inf-ruby)
  (local-set-key (kbd "C-c a") 'rvm-activate-corresponding-ruby)
  (local-set-key (kbd "C-c g") 'ggtags-find-tag-dwim)
  (local-set-key (kbd "C-c b") 'pop-tag-mark)
  ;; (local-set-key (kbd "C-c g") 'robe-jump)
  ;;  (local-set-key (kbd "C-c d") 'robe-doc)
  (local-set-key (kbd "C-c d") 'ggtags-show-definition)
  (local-set-key (kbd "C-c r") 'ruby-compilation-this-buffer)
  )

(eval-after-load 'company
  '(add-to-list 'company-backends '(company-robe)))

;;(add-hook 'ruby-mode-hook 'robe-mode)
(add-hook 'ruby-mode-hook 'ruby-tools-mode)
(add-hook 'ruby-mode-hook 'my-ruby-mode)
(add-hook 'ruby-mode-hook 'ruby-block-mode)
(add-hook 'ruby-mode-hook 'ruby-electric-mode)


;;(add-hook 'ruby-mode-hook 'projectile-on)
                                        ;(push 'company-robe company-backends)

;; ----------------- python ----------------------------
(require-package 'python-mode)
(require 'python-mode)

(add-to-list 'package-archives
             '("elpy" . "https://jorgenschaefer.github.io/packages/"))
(require-package 'elpy)
(require 'elpy)

(defun my-python-mode ()
  (elpy-enable)
  (elpy-use-ipython)

  (local-set-key (kbd "C-c g") 'elpy-goto-definition)
  ;;  (local-set-key (kbd "C-c a") 'elpy-)
  ;;  (local-set-key (kbd "C-c r") 'run-p)
  ;;  (local-set-key (kbd "C-c b") 'elpy-back)
  (local-set-key (kbd "C-c d") 'elpy-doc)
  ;;  (local-set-key (kbd "C-c c") 'anaconda-mode-complete)
  )

(add-hook 'python-mode-hook 'my-python-mode)
(add-hook 'python-mode-hook 'elpy-mode)


;; ----------------- misc function ----------------------------


(defun open-eshell-other-buffer ()
  "Open eshell in other buffer"
  (interactive)
  (split-window-vertically)
  (eshell))


(defun ska-point-to-register()
  "Store cursorposition _fast_ in a register.
Use ska-jump-to-register to jump back to the stored
position."
  (interactive)
  (setq zmacs-region-stays t)
  (point-to-register 8))

(defun ska-jump-to-register()
  "Switches between current cursorposition and position
that was stored with ska-point-to-register."
  (interactive)
  (setq zmacs-region-stays t)
  (let ((tmp (point-marker)))
    (jump-to-register 8)
    (set-register 8 tmp)))


(defun indent-buffer ()
  "Indent the whole buffer."
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))



;; ----------------- key bindings ----------------------------

(global-set-key [f1] 'comment-or-uncomment-region)
(global-set-key [f3] 'indent-buffer)
(global-set-key [C-tab] 'other-window)
(global-set-key (kbd "<C-f9>") 'open-eshell-other-buffer)
(global-set-key (kbd "C-c ;") 'ska-point-to-register)
(global-set-key (kbd "C-c '") 'ska-jump-to-register)
(global-set-key [mouse-4] 'down-slightly)
(global-set-key [mouse-5] 'up-slightly)
(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-x a r") 'align-regexp)
(global-set-key (kbd "M-[") 'align)
(global-set-key (kbd "C-c C-p") 'md/duplicate-down)
(global-set-key (kbd "C-c C-P") 'md/duplicate-up)

;; (defun remove-ggtags-keybindings-hook ()
;;   (define-key ggtags-mode-map (kbd "M-<") nil)
;;   (define-key ggtags-mode-map (kbd "M->") nil)
;;   (global-set-key (kbd "M-<") 'beginning-of-buffer)
;;   (global-set-key (kbd "M->") 'end-of-buffer)
;;   )

;; (add-hook 'ggtags-mode-hook 'remove-ggtags-keybindings-hook)

;; (eval-after-load 'ggtags
;;   `(remove-ggtags-keybindings-hook)
;;   )


;; ----------------- funny ----------------------------
(require-package 'eredis)

(autoload 'dot-mode "dot-mode" nil t) ; vi `.' command emulation
(global-set-key [(control ?.)] (lambda () (interactive) (dot-mode 1)
                                 (message "Dot mode activated.")))

                                        ; (require-package 'dot-mode)
                                        ;(add-hook 'find-file-hooks 'dot-mode-on)

;;(flycheck-disable-checker 'ruby-rubylint)
(add-to-list 'completion-styles 'initials t)

;;(setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))

(require 'color)
(let ((bg (face-attribute 'default :background)))
  (custom-set-faces
   `(company-tooltip ((t (:inherit default :background ,(color-lighten-name bg 2)))))
   `(company-scrollbar-bg ((t (:background ,(color-lighten-name bg 10)))))
   `(company-scrollbar-fg ((t (:background ,(color-lighten-name bg 5)))))
   `(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
   `(company-tooltip-common ((t (:inherit font-lock-constant-face))))))



;; windows
;;(setq projectile-indexing-method 'alien)

(require 'init-ocaml)
(require 'init-helm)

(provide 'init-local)
