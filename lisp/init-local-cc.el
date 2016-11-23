;; ----------------- c/cpp common ----------------------------

(require-package 'dtrt-indent)
(add-hook 'c-mode-common-hook
          (lambda()
            (require 'dtrt-indent)
            (dtrt-indent-mode t)))

(require 'cedet)
;;(load-file "~/.emacs.d/binary/cedet/cedet-devel-load.el")
;;(load-file "~/.emacs.d/binary/cedet/contrib/cedet-contrib-load.el")

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


;; (eval-after-load 'company
;;   '(add-to-list 'company-backends 'company-capf))

(require-package 'company-irony-c-headers)
(require 'company-irony-c-headers)





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



;;(require 'eassist)
(require 'semantic)
(require 'semantic-c nil 'noerror)
;;(require 'semantic/bovine/c nil 'noerror)

(add-hook 'semantic-init-hooks (lambda ()
                                 (imenu-add-to-menubar "TAGS")))


(defconst cedet-user-include-dirs
  (list "." ".." "../include" "../inc" "../common" "../public" "/usr/local/include"
        "../.." "../../include" "../src" "../../inc" "../../common" "../../public"))

(defun my-c-common-mode()
  (eval-after-load 'company
    '(add-to-list 'company-backends 'company-irony))

  (eval-after-load 'company
    '(add-to-list 'company-backends 'company-irony-c-headers))

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

  (local-set-key (kbd "C-c G") 'ggtags-find-tag-dwim)
  (local-set-key (kbd "C-c g") 'semantic-ia-fast-jump)
  (local-set-key (kbd "C-c b") 'pop-tag-mark)
  (local-set-key (kbd "C-c B") 'semantic-ia-fast-jump-back)

  (local-set-key (kbd "C-c D") 'ggtags-show-definition)
  (local-set-key (kbd "C-c d") 'semantic-ia-show-doc)
  (local-set-key (kbd "C-c R") 'ggtags-find-reference)
  (local-set-key (kbd "C-c r") 'semantic-symref-symbol)

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

(provide 'init-local-cc)
