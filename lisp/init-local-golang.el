(require-package 'go-mode)
(require 'go-mode)
(require-package 'company-go)
(require 'company-go)

(add-hook 'go-mode-hook (lambda ()
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode)))

(require-package 'gotest)
(require 'gotest)

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

;; (load "rename.el")
;; (load "$GOPATH/src/code.google.com/p/go.tools/cmd/oracle/oracle.el")
;; (add-hook 'go-mode-hook 'go-oracle-mode)

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
    ;;    (local-set-key (kbd "C-c C-j") 'go-direx-pop-to-buffer)
    (local-set-key [(f4)] 'previous-error)
    (local-set-key [(f5)] 'next-error)
    )
  )

(add-hook 'go-mode-hook 'my-go-mode)

(provide 'init-local-golang)
