;; alpha
;; (set-frame-parameter (selected-frame) 'alpha '(97 80))
;; (add-to-list 'default-frame-alist '(alpha 96 80))

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

(provide 'init-local-appearance)
