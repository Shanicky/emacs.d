(require-package 'rust-mode)
(require 'rust-mode)

(require-package 'racer)
(require 'racer)

(setq racer-rust-src-path (concat (getenv "HOME") "/Workspace/rust/rustc-1.12.0/src"))
(setenv "PATH" (concat (getenv "PATH") ":/home/shanicky/.cargo/bin"))
(setenv "RUST_SRC_PATH" (concat (getenv "HOME") "/Workspace/rust/rustc-1.12.0/src"))

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)

;; cargo install racer
;; cargo install rustfmt
(require 'company-racer)

(setq flycheck-disabled-checker 'rust-cargo)


;;(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)

(defun my-rust-mode()
  (progn
    (with-eval-after-load 'company
      (add-to-list 'company-backends 'company-racer))

    (local-set-key (kbd "C-c g") 'racer-find-definition)
    (local-set-key (kbd "C-c b") 'pop-tag-mark)
    (local-set-key (kbd "C-c d") 'racer-describe)
    ;;    (local-set-key (kbd "C-c C-j") 'go-direx-pop-to-buffer)
    (local-set-key [(f4)] 'previous-error)
    (local-set-key [(f5)] 'next-error)
    )
  )

(add-hook 'rust-mode-hook 'my-rust-mode)


(provide 'init-local-rust)
