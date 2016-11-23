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
