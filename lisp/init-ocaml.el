;; ----------------- ocaml ----------------------------


;; (require-package 'tuareg)
;; (require-package 'utop)
;; (require-package 'merlin)
;; (add-hook 'tuareg-mode-hook 'tuareg-imenu-set-imenu)
;; (setq auto-mode-alist
;;       (append '(("\\.ml[ily]?$" . tuareg-mode)
;;                 ("\\.topml$" . tuareg-mode))
;;               auto-mode-alist))
;; (autoload 'utop-setup-ocaml-buffer "utop" "Toplevel for OCaml" t)
;; (add-hook 'tuareg-mode-hook 'utop-setup-ocaml-buffer)
;; (add-hook 'tuareg-mode-hook 'merlin-mode)

;; ;; -- Tweaks for OS X -------------------------------------
;; ;; Tweak for problem on OS X where Emacs.app doesn't run the right
;; ;; init scripts when invoking a sub-shell
;; (cond
;;  ((eq window-system 'ns) ; macosx
;;   ;; Invoke login shells, so that .profile or .bash_profile is read
;;   (setq shell-command-switch "-lc")))

;; ;; -- opam and utop setup --------------------------------
;; ;; Setup environment variables using opam
;; (dolist
;;     (var (car (read-from-string
;;                (shell-command-to-string "opam config env --sexp"))))
;;   (setenv (car var) (cadr var)))
;; ;; Update the emacs path
;; (setq exec-path (split-string (getenv "PATH") path-separator))
;; ;; Update the emacs load path
;; (push (concat (getenv "OCAML_TOPLEVEL_PATH")
;;               "/../../share/emacs/site-lisp") load-path)
;; ;; Automatically load utop.el
;; (autoload 'utop "utop" "Toplevel for OCaml" t)
;; (autoload 'utop-minor-mode "utop" "Minor mode for utop" t)
;; (add-hook 'tuareg-mode-hook 'utop-minor-mode)

;; ;; (require-package 'merlin)
;; ;; (setq opam-share (substring (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))
;; ;; (add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))
;; ;; (add-hook 'tuareg-mode-hook 'merlin-mode)

;; ;; ; Make company aware of merlin
;; ;; (with-eval-after-load 'company
;; ;;  (add-to-list 'company-backends 'merlin-company-backend))
;; ;; ; Enable company on merlin managed buffers
;; ;; (add-hook 'merlin-mode-hook 'company-mode)
;;                                         ; Or enable it globally:
;;                                         ; (add-hook 'after-init-hook 'global-company-mode)


;; (setq opam-share (substring (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))
;; (add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))
;; ;;(require 'merlin)

;; ;; (with-eval-after-load 'company
;; ;;   (add-to-list 'company-backends 'merlin-company-backend))
;;                                         ; Enable company on merlin managed buffers


;; (add-hook 'merlin-mode-hook (lambda ()
;;                               (set (make-local-variable 'company-backends) '(merlin-company-backend))
;;                               (company-mode)))

;; ;;(add-hook 'merlin-mode-hook 'company-mode)

;; (eval-after-load 'merlin-mode
;;   '(merlin-use "core"))

(provide 'init-ocaml)
