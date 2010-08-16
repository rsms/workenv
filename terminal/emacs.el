(add-to-list 'load-path "~/.emacs.d/")

;; start the emacsclient server
(server-start)

;; no splash screen
(setq inhibit-splash-screen t)

;; Global default settings
(setq-default indent-tabs-mode nil)
(setq-default standard-indent 2)
(setq-default tab-width 2)
(setq-default column-number-mode 1)
(setq-default show-trailing-whitespace 1)
(show-paren-mode 1)
(setq show-paren-delay 0)
(normal-erase-is-backspace-mode 1) ;; DEL deletes forward
(setq default-frame-alist (append (list
  '(top . 0) '(left . 0)
  '(width . 40) '(height . 80) ;; 40 is roughly equivalent to 80 columns(WTF?)
  '(cursor-type . bar) '(cursor-color . "Red")

  ) default-frame-alist))
(blink-cursor-mode 1)

;; Fix: delete the selected text on DEL, Ctrl-d, or Backspace
(delete-selection-mode t)

;; Preserve the owner and group of the file you're editing
(setq backup-by-copying-when-mismatch t)

;; Set up recentf so I can get a list of recent files when I start
(recentf-mode 1)
;;(recentf-open-files nil "*Recent Files*")
(setq recentf-max-saved-items 1200)

;; When you start Emacs, package Session restores various variables
;; (e.g., input histories) from your last session. It also provides a
;; menu containing recently changed/visited files and restores the
;; places (e.g., point) of such a file when you revisit it.
;;
;; C-x C-/ jumps to the position of the last change
(require 'session)
(add-hook 'after-init-hook 'session-initialize)

;; Make scripts executable on Save (saves having to do the chmod every time)
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;; Change title bar to ~/file-directory if the current buffer is a
;; real file or buffer name if it is just a buffer.
(setq frame-title-format
      '(:eval
        (if buffer-file-name
            (replace-regexp-in-string
             (getenv "HOME") "~"
             (file-name-directory buffer-file-name))
          (buffer-name))))

;; Kill default buffer without the extra emacs questions
(defun silently-kill-buffer ()
  (interactive)
  (kill-buffer (buffer-name)))

;; Key bindings (On OS X, s=Cmd)
(global-set-key (kbd "s-{") 'next-buffer) ;; inverted since pop-front
(global-set-key (kbd "s-}") 'previous-buffer)
(global-set-key (kbd "s-<right>") 'end-of-line)
(global-set-key (kbd "s-<left>") 'beginning-of-line)
(global-set-key (kbd "s-<up>") 'beginning-of-buffer)
(global-set-key (kbd "s-<down>") 'end-of-buffer)
(global-set-key (kbd "C-<backspace>") 'silently-kill-buffer)
;; windows
(global-set-key (kbd "M-w") 'delete-window)
(global-set-key (kbd "M-S-w") 'delete-other-windows)
(global-set-key (kbd "C-M-<down>") 'split-window-vertically)
(global-set-key (kbd "C-M-<right>") 'split-window-horizontally)
(global-set-key (kbd "s-]") 'other-window)
;; c/c++/etc
(add-hook 'c-mode-common-hook
  (lambda()
    (local-set-key (kbd "M-s-<up>") 'ff-find-other-file)))

;; show secluded paren match in minibuffer
(defadvice show-paren-function (after show-matching-paren-offscreen activate)
  "If the matching paren is offscreen, show the matching line in the echo area.
   Has no effect if the character before point is not of the syntax class ')'."
  (interactive)
  (let ((matching-text nil))
    ;; Only call `blink-matching-open' if the character before point
    ;; is a close parentheses type character. Otherwise, there's not
    ;; really any point, and `blink-matching-open' would just echo
    ;; "Mismatched parentheses", which gets really annoying.
    (if (char-equal (char-syntax (char-before (point))) ?\))
        (setq matching-text (blink-matching-open)))
    (if (not (null matching-text))
        (message matching-text))))

;; Theme
(set-face-background 'show-paren-match-face "#330")
(set-face-foreground 'show-paren-match-face "#ff0")
(set-face-background 'trailing-whitespace "#f52")
(custom-set-faces
 '(default ((t (:inherit nil :stipple nil :background "#171717" :foreground "#ebebeb" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight light :height 120 :width normal :foundry "apple" :family "M+_1m"))))
 ;;'(c++-mode-default ((t (:inherit autoface-default :foreground "#ebebeb" :height 130 :family "M+ 1m"))) t)
 ;;'(completion-list-mode-default ((t (:inherit autoface-default))) t)
 ;;'(cursor ((t (:background "red"))))
 '(font-lock-comment-face
   ((((class color) (min-colors 88) (background dark)) (:foreground "#888"))))
 '(font-lock-constant-face
   ((((class color) (min-colors 88) (background dark)) (:foreground "#f57aab"))))
 '(font-lock-doc-face
   ((t (:inherit font-lock-comment-face))))
 '(font-lock-function-name-face
   ((((class color) (min-colors 88) (background dark)) (:background "#232f36" :foreground "#59f5c6"))))
 '(font-lock-keyword-face
   ((((class color) (min-colors 88) (background dark)) (:foreground "#5ecefc"))))
 '(font-lock-string-face
   ((((class color) (min-colors 88) (background dark)) (:background "#1a2216" :foreground "#86ad6c"))))
 '(font-lock-type-face ((((class color) (min-colors 88) (background dark)) (:foreground "LightSalmon"))))
 '(highlight ((((class color) (min-colors 88) (background dark)) (:background "yellow" :foreground "black"))))
 ;;'(js-mode-default ((t (:inherit autoface-default :background "#191919" :foreground "#ededed"))) t)
 '(js2-external-variable-face ((t (:foreground "#be8971"))))
 '(js2-function-param-face ((t (:foreground "#e8a970"))))
 '(js2-jsdoc-value-face ((t (:foreground "#e8a970"))))
 '(region ((((class color) (min-colors 88) (background dark)) (:background "#334466"))))
 '(text-mode-default
   ((t (:inherit autoface-default :stipple nil :strike-through nil :underline nil :slant normal :weight normal :height 130 :width normal :family "Lucida Grande"))))
 '(tool-bar ((t (:box (:line-width 1 :style released-button))))))

;; auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

;; JavaScript
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(autoload 'espresso-mode "espresso")
(add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))

(defun my-js2-indent-function ()
  (interactive)
  (save-restriction
    (widen)
    (let* ((inhibit-point-motion-hooks t)
           (parse-status (save-excursion (syntax-ppss (point-at-bol))))
           (offset (- (current-column) (current-indentation)))
           (indentation (espresso--proper-indentation parse-status))
           node)

      (save-excursion

        ;; I like to indent case and labels to half of the tab width
        (back-to-indentation)
        (if (looking-at "case\\s-")
            (setq indentation (+ indentation (/ espresso-indent-level 2))))

        ;; consecutive declarations in a var statement are nice if
        ;; properly aligned, i.e:
        ;;
        ;; var foo = "bar",
        ;;     bar = "foo";
        (setq node (js2-node-at-point))
        (when (and node
                   (= js2-NAME (js2-node-type node))
                   (= js2-VAR (js2-node-type (js2-node-parent node))))
          (setq indentation (+ 4 indentation))))

      (indent-line-to indentation)
      (when (> offset 0) (forward-char offset)))))

(defun my-indent-sexp ()
  (interactive)
  (save-restriction
    (save-excursion
      (widen)
      (let* ((inhibit-point-motion-hooks t)
             (parse-status (syntax-ppss (point)))
             (beg (nth 1 parse-status))
             (end-marker (make-marker))
             (end (progn (goto-char beg) (forward-list) (point)))
             (ovl (make-overlay beg end)))
        (set-marker end-marker end)
        (overlay-put ovl 'face 'highlight)
        (goto-char beg)
        (while (< (point) (marker-position end-marker))
          ;; don't reindent blank lines so we don't set the "buffer
          ;; modified" property for nothing
          (beginning-of-line)
          (unless (looking-at "\\s-*$")
            (indent-according-to-mode))
          (forward-line))
        (run-with-timer 0.5 nil '(lambda(ovl)
                                   (delete-overlay ovl)) ovl)))))

(defun my-js2-mode-hook ()
  (require 'espresso)
  (setq espresso-indent-level 2
        indent-tabs-mode nil
        c-basic-offset 2)
  (c-toggle-auto-state 0)
  (c-toggle-hungry-state 1)
  (set (make-local-variable 'indent-line-function) 'my-js2-indent-function)
  (define-key js2-mode-map [(meta control |)] 'cperl-lineup)
  (define-key js2-mode-map [(meta control \;)]
    '(lambda()
       (interactive)
       (insert "/* -----[ ")
       (save-excursion
         (insert " ]----- */"))
       ))
  (define-key js2-mode-map [(return)] 'newline-and-indent)
  (define-key js2-mode-map [(backspace)] 'c-electric-backspace)
  (define-key js2-mode-map [(control d)] 'c-electric-delete-forward)
  (define-key js2-mode-map [(control meta q)] 'my-indent-sexp)
  (if (featurep 'js2-highlight-vars)
    (js2-highlight-vars-mode))
  (message "My JS2 hook"))

(add-hook 'js2-mode-hook 'my-js2-mode-hook)
