(require-package 'yasnippet)
(require 'yasnippet)
(yas-global-mode 1)

;; (require-package 'company)
;; (require 'company)
;; (add-hook 'after-init-hook 'global-company-mode)

(setq company-tooltip-limit 10)                      ; bigger popup window
(setq company-idle-delay 0)                        ; decrease delay before autocompletion popup shows
(setq company-echo-delay 0)                          ; remove annoying blinking
;;(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing
(setq company-minimum-prefix-length 1)
(setq company-tooltip-align-annotations t)


(provide 'init-local-company)
