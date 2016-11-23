                                        ;(setq-default dotspacemacs-configuration-layers '(osx))
(global-subword-mode t)
(global-hl-line-mode t)                              ;; highlight current line
(auto-image-file-mode t)
;; (icomplete-mode t)
(blink-cursor-mode nil)
(setq default-directory "~/Workspace/")
(add-to-list 'load-path "~/.emacs.d/site-lisp/")

;;(define-key minibuffer-local-completion-map (kbd "SPC") 'minibuffer-complete-word)
(setq frame-title-format "Laziness, Impatience and Hubris")
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

(setq ag-highlight-search t)
(setq ag-reuse-window t)
(setq ag-reuse-buffers t)


(remove-hook 'prog-mode-hook 'indent-guide-mode)

(provide 'init-local-misc)
