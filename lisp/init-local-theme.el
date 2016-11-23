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
;;(require 'linum+)
;;(global-linum-mode t)
;;(setq display-line-number-format "%3d||")

(provide 'init-local-theme)
