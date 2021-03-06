(require 'init-clojure)

(when (maybe-require-package 'cider)

  ;;  (require-package 'ac-cider)

  (setq nrepl-popup-stacktraces nil)

  (after-load 'cider

    ;;    (add-hook 'cider-repl-mode-hook 'ac-cider-setup)
    ;;  (add-hook 'cider-mode-hook 'ac-cider-setup)
    ;; (after-load 'auto-complete
    ;;   (add-to-list 'ac-modes 'cider-repl-mode))

    (add-hook 'cider-repl-mode-hook #'company-mode)
    (add-hook 'cider-mode-hook #'company-mode)
    ;; (add-hook 'cider-repl-mode-hook 'set-auto-complete-as-completion-at-point-function)
    ;; (add-hook 'cider-mode-hook 'set-auto-complete-as-completion-at-point-function)
    ;;    (add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

    (add-hook 'cider-mode-hook 'eldoc-mode)

    (add-hook 'cider-repl-mode-hook 'subword-mode)
    (add-hook 'cider-repl-mode-hook 'paredit-mode)
    ;;    (define-key cider-mode-map (kbd "C-c C-d") 'ac-cider-popup-doc)

    (add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

    ;; nrepl isn't based on comint
    (add-hook 'cider-repl-mode-hook 'sanityinc/no-trailing-whitespace))

  ;; (require-package 'flycheck-clojure)
  ;; (after-load 'clojure-mode
  ;;   (after-load 'flycheck
  ;;     (flycheck-clojure-setup))))
  )


(provide 'init-clojure-cider)
