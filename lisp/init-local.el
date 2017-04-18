(require 'init-local-misc)
(require 'init-local-company)
(require 'init-local-theme)
(require 'init-local-appearance)

(setenv "PATH" (concat (getenv "PATH") ":/home/shanicky/Workspace/go/bin"))
(setenv "GOPATH" "/home/shanicky/Workspace/go")
(setenv "GOROOT" "/home/shanicky/.gvm/gos/go1.7.1")
(setq default-directory "/home/shanicky/Workspace/")

(exec-path-from-shell-copy-env "GOPATH")
(exec-path-from-shell-copy-env "GOROOT")
(exec-path-from-shell-copy-env "PATH")

(require 'init-local-golang)
(require 'init-local-cc)
(require 'init-local-rust)



(global-set-key [f1] 'comment-or-uncomment-region)
(global-set-key [f3] 'indent-buffer)
(global-set-key [C-tab] 'other-window)
(global-set-key (kbd "<C-f9>") 'open-eshell-other-buffer)
(global-set-key (kbd "C-c ;") 'ska-point-to-register)
(global-set-key (kbd "C-c '") 'ska-jump-to-register)
;;(global-set-key [mouse-4] 'down-slightly)
;;(global-set-key [mouse-5] 'up-slightly)
(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-x a r") 'align-regexp)
(global-set-key (kbd "M-[") 'align)
(global-set-key (kbd "C-c C-p") 'md/duplicate-down)
(global-set-key (kbd "C-c C-P") 'md/duplicate-up)

;;(require 'go-impl)

                                        ;(add-hook 'c++-mode-hook 'irony-mode)

                                        ;(add-hook 'c-mode-hook 'irony-mode)
                                        ;(add-hook 'objc-mode-hook 'irony-mode)



;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
                                        ;(defun my-irony-mode-hook ()
                                        ;  (define-key irony-mode-map [remap completion-at-point]
                                        ;    'irony-completion-at-point-async)
                                        ;  (define-key irony-mode-map [remap complete-symbol]
                                        ;    'irony-completion-at-point-async))
                                        ;(add-hook 'irony-mode-hook 'my-irony-mode-hook)
                                        ;(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)




(provide 'init-local)
