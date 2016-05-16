(require-package 'yasnippet)
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

;;(setq company-transformers '(company-sort-by-backend-importance))


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


(require-package 'ggtags)
(add-hook 'prog-mode-hook
          (lambda ()
            (ggtags-mode t)))

;; ----------------- common ----------------------------
(setq-default dotspacemacs-configuration-layers '(osx))
(global-subword-mode t)
(global-hl-line-mode t)                              ;; highlight current line
(auto-image-file-mode t)
;; (icomplete-mode t)
(blink-cursor-mode nil)

(setq default-directory "~/workspace/")
(add-to-list 'load-path "~/.emacs.d/site-lisp/")

;;(define-key minibuffer-local-completion-map (kbd "SPC") 'minibuffer-complete-word)
(setq frame-title-format "No sin is hidden to the soul")
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


;; ----------------- ido ----------------------------
;; (require-package 'flx-ido)
;; (require 'flx-ido)
;; (ido-mode 1)
;; (ido-everywhere 1)
;; (flx-ido-mode 1)
;; ;; disable ido faces to see flx highlights.
;; (setq ido-enable-flex-matching t)
;; (setq ido-use-faces nil)


;; (require-package 'ido-vertical-mode)
;; (require 'ido-vertical-mode)
;; (ido-vertical-mode t)
;; (setq ido-decorations (quote ("\n=> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))


;; (defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
;; (add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
;; (defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
;;   (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
;;   (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))
;; (add-hook 'ido-setup-hook 'ido-define-keys)

;; ----------------- editing ----------------------------
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(require-package 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C--") 'er/contract-region)

(require-package 'guide-key)
(setq guide-key/guide-key-sequence '("C-x" "C-c" "C-x 4" "C-x 5" "C-c ;" "C-c ; f" "C-c ' f" "C-x n" "C-x C-r" "C-x r" "C-c p" "C-c !" "C-c h"))


;; ----------------- appearance ----------------------------
(require-package 'sublime-themes)
(require 'sublime-themes)

;; gotham theme
(require-package 'gotham-theme)
(setq-default custom-enabled-themes '(gotham))
(load-theme 'gotham t)

;; (require-package 'darktooth-theme)
;; (load-theme 'darktooth t)

;; (load-theme 'spacemacs-dark)
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

;; (defun ac-linum-workaround ()
;;   "linum-mode tries to display the line numbers even for the
;; completion menu. This workaround stops that annoying behavior."
;;   (interactive)
;;   (defadvice linum-update (around ac-linum-update-workaround activate)
;;     (unless ac-completing
;;       ad-do-it)))

;;(ac-linum-workaround)

;; alpha
(set-frame-parameter (selected-frame) 'alpha '(97 80))
(add-to-list 'default-frame-alist '(alpha 96 80))

;; position
(setq default-frame-alistp
      '((vertical-scroll-bars)
        (tool-bar-lines . 0)
        (menu-bar-lines . 1)
        (left-fringe)))
(setq initial-frame-alist '((top . 40) (left . 40) (width . 140) (height . 40)))


;; font
;;(set-default-font "Terminus 15")
;;(set-default-font "Aurulent Sans Mono 13")
;;(set-default-font "FreeMono 15")
;;(set-default-font "Hasklig 13")
;;(set-default-font "Hasklig 13")
(set-default-font "Sayo UV Console HG 15")

;; popwin
(require-package 'popwin)
(require 'popwin)

(popwin-mode t)
(setq display-buffer-function 'popwin:display-buffer)
;; M-x anything
;; (setq anything-samewindow nil)
;; (push '("*anything*" :height 20) popwin:special-display-config)

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
(require-package 'projectile)
(require 'projectile)
(projectile-global-mode)
(add-hook 'prog-mode-hook 'projectile-mode)
                                        ;(add-hook 'ruby-mode-hook 'projectile-mode)
                                        ;(add-hook 'c++-mode-hook 'projectile-mode)
                                        ;(add-hook 'c-mode-hook 'projectile-mode)
(setq projectile-enable-caching t)


;; ----------------- c/cpp common ----------------------------

(require-package 'dtrt-indent)
(add-hook 'c-mode-common-hook
          (lambda()
            (require 'dtrt-indent)
            (dtrt-indent-mode t)))

;;(require 'cedet)
(load-file "~/.emacs.d/binary/cedet/cedet-devel-load.el")
(load-file "~/.emacs.d/binary/cedet/contrib/cedet-contrib-load.el")

;; ----------------- cpp ----------------------------

(require-package 'irony)
(require 'irony)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))

(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;;"-lglog" "-lfolly"
(setq irony-lang-compile-option-alist
      '((c++-mode . ("c++" "-std=c++11" "-lstdc++" "-lm" "-I/usr/local/include/" "-L/usr/local/lib"))
        (c-mode . ("c" "-std=c99" "-lm" "-I/usr/local/include/" "-L/usr/local/lib"))
        (objc-mode . '("objective-c"))))

(defun irony--lang-compile-option ()
  (irony--awhen (cdr-safe (assq major-mode irony-lang-compile-option-alist))
    (append '("-x") it)))

(require-package 'company-irony)
(require 'company-irony)

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-capf))

(require-package 'company-irony-c-headers)
(require 'company-irony-c-headers)

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony-c-headers))

(defun get-include-dirs ()
  (let* ((command-result (shell-command-to-string "echo \"\" | g++ -v -x c++ -E -"))
         (start-string "#include <...> search starts here:\n")
         (end-string "End of search list.\n")
         (start-pos (string-match start-string command-result))
         (end-pos (string-match end-string command-result))
         (include-string (substring command-result (+ start-pos (length start-string)) end-pos)))
    (split-string include-string)))

(defun get-project-include-dirs ()
  (append  (list ".."
                 "../.."
                 "../inc"
                 "../../inc"
                 "../include"
                 "../../include"
                 "../deps"
                 "../../deps"
                 "../common"
                 "../../common"
                 "../public"
                 "../../public"
                 "../src")
           (get-include-dirs)))

(defun get-all-include-dirs ()
  (append  (list "/usr/local/include")
           (get-project-include-dirs)))



(require 'eassist)
(require 'semantic)
(require 'semantic-c nil 'noerror)
;;(require 'semantic/bovine/c nil 'noerror)

(add-hook 'semantic-init-hooks (lambda ()
                                 (imenu-add-to-menubar "TAGS")))



(defconst cedet-user-include-dirs
  (list "." ".." "../include" "../inc" "../common" "../public" "/usr/local/include"
        "../.." "../../include" "../src" "../../inc" "../../common" "../../public"))

(defun my-c-common-mode()
  (setq flycheck-clang-include-path (get-all-include-dirs))
  (setq-local imenu-create-index-function #'ggtags-build-imenu-index)
  (exec-path-from-shell-copy-env "GTAGSLIBPATH")
  (semantic-mode t)
  (let ((include-dirs cedet-user-include-dirs))
    (mapc (lambda (dir)
            (semantic-add-system-include dir 'c++-mode)
            (semantic-add-system-include dir 'c-mode))
          include-dirs))

  (global-semantic-mru-bookmark-mode t)

  (defadvice push-mark (around semantic-mru-bookmark activate)
    (semantic-mrub-push semantic-mru-bookmark-ring (point) 'mark)
    ad-do-it)
  (defun semantic-ia-fast-jump-back ()
    (interactive)
    (if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
        (error "semantic bookmark ring is currently empty"))
    (let* ((ring (oref semantic-mru-bookmark-ring ring))
           (alist (semantic-mrub-ring-to-assoc-list ring))
           (first (cdr (car alist))))

      (if (semantic-equivalent-tag-p (oref first tag) (semantic-current-tag))
          (setq first (cdr (car (cdr alist)))))
      (semantic-mrub-switch-tags first)))

  (global-semanticdb-minor-mode t)
  (global-semantic-idle-scheduler-mode t)
  ;;(global-semantic-idle-summary-mode t)
  (global-semantic-highlight-func-mode t)
  ;;(global-semantic-stickyfunc-mode t)
  (global-semantic-highlight-edits-mode (if window-system 1 -1))
  ;;(global-semantic-show-unmatched-syntax-mode t)
  (global-semantic-show-parser-state-mode t)

  (local-set-key (kbd "C-c g") 'ggtags-find-tag-dwim)
  (local-set-key (kbd "C-c G") 'semantic-ia-fast-jump)
  (local-set-key (kbd "C-c b") 'pop-tag-mark)
  (local-set-key (kbd "C-c B") 'semantic-ia-fast-jump-back)

  (local-set-key (kbd "C-c d") 'ggtags-show-definition)
  (local-set-key (kbd "C-c D") 'semantic-ia-show-doc)
  (local-set-key (kbd "C-c r") 'ggtags-find-reference)
  (local-set-key (kbd "C-c R") 'semantic-symref-symbol)

  ;;  (local-set-key (kbd "C-c D") 'semantic-ia-describe-class)
  (local-set-key (kbd "C-c s") 'semantic-ia-show-summary)
  (local-set-key (kbd "C-c c") 'eassist-switch-h-cpp)

  ;;(local-set-key (kbd "C-c B") 'semantic-mrub-switch-tags)
  (local-set-key (kbd "C-c m") 'eassist-list-methods)
  (local-set-key (kbd "C-c i") 'semantic-analyze-proto-impl-toggle)
  (local-set-key (kbd "C-c u") 'senator-go-to-up-reference)
                                        ;  (local-set-key (kbd "C-c R") 'semantic-symref)
  (local-set-key [(f9)] 'smart-compile))

(add-hook 'c-mode-hook 'my-c-common-mode)
(add-hook 'c++-mode-hook 'my-c-common-mode)

(defun my-c-mode ()
  (setq flycheck-clang-language-standard "c99"))

(add-hook 'c-mode-hook 'my-c-mode)

(defun my-cpp-mode ()
  (setq flycheck-clang-language-standard "c++11")
  (setq flycheck-clang-standard-library "libc++"))

(add-hook 'c++-mode-hook 'my-cpp-mode)

(require-package 'flycheck-google-cpplint)
(require 'flycheck-google-cpplint)

;; (require-package 'flycheck-irony)
;; (require 'flycheck-irony)

;; (eval-after-load 'flycheck
;;   '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

(require-package 'irony-eldoc)
(add-hook 'irony-mode-hook 'irony-eldoc)

;; (require-package 'cpputils-cmake)
;; (require 'cpputils-cmake)
;; (add-hook 'c-mode-common-hook
;;           (lambda ()
;;             (if (derived-mode-p 'c-mode 'c++-mode)
;;                 (cppcm-reload-all)
;;               )))


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
                          (set (make-local-variable 'company-backends) (mapcar #'company-mode/backend-with-yas '(company-go)))
                          ;;                          (set (make-local-variable 'company-backends) '(company-go))
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

(require-package 'golint)
(require 'golint)
(require-package 'go-projectile)
(require 'go-projectile)

(require 'go-impl)

(load "rename.el")
(load "$GOPATH/src/code.google.com/p/go.tools/cmd/oracle/oracle.el")
(add-hook 'go-mode-hook 'go-oracle-mode)

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

;; (eval-after-load 'company
;;   '(add-to-list 'company-backends '(company-robe)))

;;(add-hook 'ruby-mode-hook 'robe-mode)
(add-hook 'ruby-mode-hook 'ruby-tools-mode)
(add-hook 'ruby-mode-hook 'my-ruby-mode)
(add-hook 'ruby-mode-hook 'ruby-block-mode)
(add-hook 'ruby-mode-hook 'ruby-electric-mode)

(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(ruby-rubylint)))

;;(add-hook 'ruby-mode-hook 'projectile-on)

                                        ;(push 'company-robe company-backends)

;; ----------------- python ----------------------------
;; (add-to-list 'package-archives
;;              '("elpy" . "https://jorgenschaefer.github.io/packages/"))
;; (require-package 'elpy)
;; (require 'elpy)

;; (defun my-python-mode ()
;;   (elpy-enable)
;; ;;  (elpy-use-ipython)
;;   )

;; (add-hook 'python-mode-hook 'my-python-mode)

(require-package 'anaconda-mode)
(require-package 'company-anaconda)
(eval-after-load "company"
  '(progn
     (add-to-list 'company-backends 'company-anaconda)))

(defun my-python-mode ()
  (local-set-key (kbd "C-c g") 'anaconda-mode-find-definitions)
  (local-set-key (kbd "C-c a") 'anaconda-mode-find-assignments)
  (local-set-key (kbd "C-c r") 'anaconda-mode-find-references)
  (local-set-key (kbd "C-c b") 'anaconda-mode-go-back)
  (local-set-key (kbd "C-c d") 'anaconda-mode-show-doc)
  (local-set-key (kbd "C-c c") 'anaconda-mode-complete)
  )
(add-hook 'python-mode-hook 'eldoc-mode)
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'my-python-mode)


;; ----------------- misc function ----------------------------

(defun smart-compile()
  "smart compile"
  (interactive)
  (let ((candidate-make-file-name '("makefile" "Makefile" "GNUmakefile"))
        (command nil))
    (if (not (null
              (find t candidate-make-file-name :key
                    '(lambda (f) (file-readable-p f)))))
        (setq command "make -k -j3")
      (if (null (buffer-file-name (current-buffer)))
          (message "Buffer not attached to a file, won't compile!")
        (if (eq major-mode 'c-mode)
            (setq command
                  (concat "clang -Wall -o "
                          (file-name-sans-extension
                           (file-name-nondirectory buffer-file-name))
                          " "
                          (file-name-nondirectory buffer-file-name)
                          " -g -std=c99 -pedantic -pthread -lm -I/usr/local/include -L/usr/local/lib"))
          (if (eq major-mode 'c++-mode)
              (setq command
                    (concat "clang++ -Wall -o "
                            (file-name-sans-extension
                             (file-name-nondirectory buffer-file-name))
                            " "
                            (file-name-nondirectory buffer-file-name)
                            " -g -std=c++11 -pedantic -pthread -lm -I/usr/local/include -L/usr/local/lib "))
            (if (eq major-mode 'go-mode)
                (setq command "colorgo build -v")
              (message "Unknow mode, won't compile!"))))))
    (save-buffer)
    (if (not (null command))
        (let ((command (read-from-minibuffer "Compile command: " command)))
          (compile command)))))

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

(defun remove-ggtags-keybindings-hook ()
  (define-key ggtags-mode-map (kbd "M-<") nil)
  (define-key ggtags-mode-map (kbd "M->") nil)
  (global-set-key (kbd "M-<") 'beginning-of-buffer)
  (global-set-key (kbd "M->") 'end-of-buffer)
  )

(add-hook 'ggtags-mode-hook 'remove-ggtags-keybindings-hook)

(eval-after-load 'ggtags
  `(remove-ggtags-keybindings-hook)
  )


;; ----------------- funny ----------------------------
(require-package 'eredis)

(autoload 'dot-mode "dot-mode" nil t) ; vi `.' command emulation
(global-set-key [(control ?.)] (lambda () (interactive) (dot-mode 1)
                                 (message "Dot mode activated.")))

                                        ; (require-package 'dot-mode)
                                        ;(add-hook 'find-file-hooks 'dot-mode-on)

;;(flycheck-disable-checker 'ruby-rubylint)
(add-to-list 'completion-styles 'initials t)


;; ----------------- ocaml ----------------------------


(require-package 'tuareg)
(require-package 'utop)
(require-package 'merlin)
(add-hook 'tuareg-mode-hook 'tuareg-imenu-set-imenu)
(setq auto-mode-alist
      (append '(("\\.ml[ily]?$" . tuareg-mode)
                ("\\.topml$" . tuareg-mode))
              auto-mode-alist))
(autoload 'utop-setup-ocaml-buffer "utop" "Toplevel for OCaml" t)
(add-hook 'tuareg-mode-hook 'utop-setup-ocaml-buffer)
(add-hook 'tuareg-mode-hook 'merlin-mode)

;; -- Tweaks for OS X -------------------------------------
;; Tweak for problem on OS X where Emacs.app doesn't run the right
;; init scripts when invoking a sub-shell
(cond
 ((eq window-system 'ns) ; macosx
  ;; Invoke login shells, so that .profile or .bash_profile is read
  (setq shell-command-switch "-lc")))

;; -- opam and utop setup --------------------------------
;; Setup environment variables using opam
(dolist
    (var (car (read-from-string
               (shell-command-to-string "opam config env --sexp"))))
  (setenv (car var) (cadr var)))
;; Update the emacs path
(setq exec-path (split-string (getenv "PATH") path-separator))
;; Update the emacs load path
(push (concat (getenv "OCAML_TOPLEVEL_PATH")
              "/../../share/emacs/site-lisp") load-path)
;; Automatically load utop.el
(autoload 'utop "utop" "Toplevel for OCaml" t)
(autoload 'utop-minor-mode "utop" "Minor mode for utop" t)
(add-hook 'tuareg-mode-hook 'utop-minor-mode)

;; (require-package 'merlin)
;; (setq opam-share (substring (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))
;; (add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))
;; (add-hook 'tuareg-mode-hook 'merlin-mode)

;; ; Make company aware of merlin
;; (with-eval-after-load 'company
;;  (add-to-list 'company-backends 'merlin-company-backend))
;; ; Enable company on merlin managed buffers
;; (add-hook 'merlin-mode-hook 'company-mode)
                                        ; Or enable it globally:
                                        ; (add-hook 'after-init-hook 'global-company-mode)


(setq opam-share (substring (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))
(add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))
;;(require 'merlin)

;; (with-eval-after-load 'company
;;   (add-to-list 'company-backends 'merlin-company-backend))
                                        ; Enable company on merlin managed buffers


(add-hook 'merlin-mode-hook (lambda ()
                              (set (make-local-variable 'company-backends) '(merlin-company-backend))
                              (company-mode)))

;;(add-hook 'merlin-mode-hook 'company-mode)

(eval-after-load 'merlin-mode
  '(merlin-use "core"))

(setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))

(require 'color)
(let ((bg (face-attribute 'default :background)))
  (custom-set-faces
   `(company-tooltip ((t (:inherit default :background ,(color-lighten-name bg 2)))))
   `(company-scrollbar-bg ((t (:background ,(color-lighten-name bg 10)))))
   `(company-scrollbar-fg ((t (:background ,(color-lighten-name bg 5)))))
   `(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
   `(company-tooltip-common ((t (:inherit font-lock-constant-face))))))


;; ----------------- helm ----------------------------
(require-package 'helm)
(require 'helm-config)

(helm-mode 1)
(helm-autoresize-mode 1)

(when (executable-find "ack")
  (setq helm-grep-default-command "ack -Hn --no-group --no-color %e %p %f"
        helm-grep-default-recurse-command "ack -H --no-group --no-color %e %p %f"))

(global-set-key (kbd "M-x") 'helm-M-x)
(setq helm-M-x-fuzzy-match t)

(global-set-key (kbd "M-y") 'helm-show-kill-ring)

(global-set-key (kbd "C-x b") 'helm-mini)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)

(global-set-key (kbd "C-x C-f") 'helm-find-files)
(setq helm-ff-auto-update-initial-value t)


(setq helm-mode-fuzzy-match t)
(setq helm-completion-in-region-fuzzy-match t)

(setq helm-semantic-fuzzy-match t
      helm-imenu-fuzzy-match    t)

(require-package 'helm-projectile)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(setq helm-locate-fuzzy-match t)
(setq helm-apropos-fuzzy-match t)


(global-set-key (kbd "C-c h o") 'helm-occur)
(global-set-key (kbd "C-c h g") 'helm-google-suggest)

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)


(add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)

(require 'helm-descbinds)
(helm-descbinds-mode)

(require-package 'helm-ag)

(custom-set-variables
 '(helm-ag-base-command "ag --nocolor --nogroup --ignore-case")
 '(helm-ag-command-option "--all-text")
 '(helm-ag-insert-at-point 'symbol))

(global-set-key (kbd "M-?") 'helm-ag)

;; windows
;;(setq projectile-indexing-method 'alien)

(provide 'init-local)
