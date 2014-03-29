;; ; (backward-char) C-b <- C-h is the help map (help-command)  
;; ; (next-line) C-n     <- C-j is (newline-and-indent)         
;; ; (previous-line) C-p <- C-k is (kill-line)                  
;; ; (forward-char) C-f  <- C-l is (recenter-top-bottom)        
(global-set-key "\C-b" 'help-command)                        
(global-set-key "\C-n" 'newline-and-indent)                  
(global-set-key "\C-p" 'kill-line)                           
(global-set-key "\C-f" 'recenter-top-bottom)                 
(global-set-key "\C-h" 'backward-char)                       
(global-set-key "\C-j" 'next-line)                                                                                     
(global-set-key "\C-k" 'previous-line)                       
(global-set-key "\C-l" 'forward-char)      

;;relative line numbers -
;;adapted from https://stackoverflow.com/questions/6874516/relative-line-numbers-in-emacs

(defvar my-linum-format-string "%3d")

(add-hook 'linum-before-numbering-hook 'my-linum-get-format-string)

(defun my-linum-get-format-string ()
  (let* ((width (1+ (length (number-to-string
                             (count-lines (point-min) (point-max))))))
         (format (concat "%" (number-to-string width) "d")))
    (setq my-linum-format-string format)))

(defvar my-linum-current-line-number 0)

(setq linum-format 'my-linum-relative-line-numbers)

(defun my-linum-relative-line-numbers (line-number)
    (let* ((offset (abs (- line-number my-linum-current-line-number)))
           (offset-or-abs (if (= offset 0) my-linum-current-line-number offset)))
    (propertize (format my-linum-format-string offset-or-abs) 'face 'linum)))

(defadvice linum-update (around my-linum-update)
  (let ((my-linum-current-line-number (line-number-at-pos)))
    ad-do-it))
(ad-activate 'linum-update)         

(global-linum-mode t)

;;(setq inferior-lisp-program "clisp -modern -I")
;;require slime?

;; color theme and font
(add-to-list 'default-frame-alist '(foreground-color . "gray"))
(add-to-list 'default-frame-alist '(background-color . "gray10"))
(add-to-list 'default-frame-alist '(cursor-color . "white"))
;; Load VIP
;;(load "vip")
;;(global-set-key "\C-n" 'vip-change-mode-to-vi)
;; clean *scratch*, no more startup screen
(setq initial-scratch-message nil)
(setq inhibit-startup-message t)
(set-input-method 'TeX)
(tool-bar-mode -1)

;; for non-tiling wms (if I ever want to use them) -
(defun fullscreen (&optional f)
       (interactive)
       (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
               '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
       (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
               '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))
(fullscreen)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-visual-line-mode t)
(show-paren-mode t)

(add-hook 'java-mode-hook (lambda () (setq c-basic-offset 8)))

(setq scroll-step 1)

(global-set-key [f6] 'tuareg-eval-buffer)

(global-set-key "\C-w" 'backward-kill-word)

(push
 (concat (substring (shell-command-to-string "opam config var share") 0 -1) "/emacs/site-lisp") load-path)
(setq merlin-command (concat (substring (shell-command-to-string "opam config var bin") 0 -1) "/ocamlmerlin"))
(autoload 'merlin-mode "merlin" "Merlin mode" t)
(add-hook 'tuareg-mode-hook 'merlin-mode)
(add-hook 'caml-mode-hook 'merlin-mode)
  
(add-to-list 'default-frame-alist '(alpha . (85 80)))

    (cua-mode t)
    (setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
    (transient-mark-mode 1) ;; No region when it is not highlighted
    (setq cua-keep-region-after-copy t) ;; Standard Windows behaviour

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(require 'package)
(add-to-list 'package-archives 
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)

;;kindly taken from http://emacs-fu.blogspot.co.uk/2009/10/writing-presentations-with-org-mode-and.html
;; #+LaTeX_CLASS: beamer in org files
(unless (boundp 'org-export-latex-classes)
  (setq org-export-latex-classes nil))
(add-to-list 'org-export-latex-classes
  ;; beamer class, for presentations
  '("beamer"
     "\\documentclass[11pt]{beamer}\n
      \\mode<{{{beamermode}}}>\n
      \\usetheme{{{{beamertheme}}}}\n
      \\usecolortheme{{{{beamercolortheme}}}}\n
      \\beamertemplateballitem\n
      \\setbeameroption{show notes}
      \\usepackage[utf8]{inputenc}\n
      \\usepackage[T1]{fontenc}\n
      \\usepackage{hyperref}\n
      \\usepackage{color}
      \\usepackage{listings}
      \\lstset{numbers=none,language=[ISO]C++,tabsize=4,
  frame=single,
  basicstyle=\\small,
  showspaces=false,showstringspaces=false,
  showtabs=false,
  keywordstyle=\\color{blue}\\bfseries,
  commentstyle=\\color{red},
  }\n
      \\usepackage{verbatim}\n
      \\institute{{{{beamerinstitute}}}}\n          
       \\subject{{{{beamersubject}}}}\n"

     ("\\section{%s}" . "\\section*{%s}")
     
     ("\\begin{frame}[fragile]\\frametitle{%s}"
       "\\end{frame}"
       "\\begin{frame}[fragile]\\frametitle{%s}"
       "\\end{frame}")))

  ;; letter class, for formal letters

  (add-to-list 'org-export-latex-classes

  '("letter"
     "\\documentclass[11pt]{letter}\n
      \\usepackage[utf8]{inputenc}\n
      \\usepackage[T1]{fontenc}\n
      \\usepackage{color}"
     
     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ("\\paragraph{%s}" . "\\paragraph*{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))


;;;Author's GitHub package link - https://github.com/trillioneyes/pretty-colors-mode
;;PRETTY COLORS MODE START
(eval-when-compile (require 'rainbow-delimiters))
 
(defvar rainbow-delimiters-faces-list
 '("rainbow-delimiters-depth-1-face"
    "rainbow-delimiters-depth-2-face"
    "rainbow-delimiters-depth-3-face"
    "rainbow-delimiters-depth-4-face"
    "rainbow-delimiters-depth-5-face"
    "rainbow-delimiters-depth-6-face"
    "rainbow-delimiters-depth-7-face"
    "rainbow-delimiters-depth-8-face"
    "rainbow-delimiters-depth-9-face"))
(defvar pretty-colors-open-delims '(?\( ?\[ ?\{))
(defvar pretty-colors-close-delims '(?\) ?\] ?\}))
 
(defun depth-from-base (loc base base-depth)
  (+ (car (parse-partial-sexp base loc)) base-depth))
 
(defun pretty-colors-colorize-region (start end)
  (interactive "r")
  (save-excursion
    (with-silent-modifications
      (pretty-colors-uncolorize-region start end)
      (font-lock-fontify-region start end)
      (goto-char start)
      (let ((start-depth (rainbow-delimiters-depth (point))))
       (while (< (point) end)
         (let ((depth (depth-from-base (point) start start-depth)))
           (when (and (memq (char-after (point)) pretty-colors-open-delims)
                      (not (rainbow-delimiters-char-ineligible-p (point))))
             (setq depth (1+ depth)))
           (unless (and (not (get-text-property (point) 'pretty-color))
                        (or (and (get-text-property (point) 'font-lock-face))
                            (get-text-property (point) 'face)))
             (add-text-properties
              (point) (1+ (point))
              `(font-lock-face ,(rainbow-delimiters-depth-face
                                 depth)
                               pretty-color t))))
         (setf (point) (1+ (point))))))))
 
(defun pretty-colors-uncolorize-region (start end)
 (save-excursion
   (with-silent-modifications
     (remove-text-properties start end
                              '(font-lock-face rainbow
                                               pretty-color t)))))
 
(define-minor-mode pretty-colors-mode
  "Highlight parenthesis-like delimiters and their contents according to their depth."
  nil "" nil
  (if (not pretty-colors-mode)
      (progn
        (jit-lock-unregister 'pretty-colors-colorize-region)
        (pretty-colors-uncolorize-region (point-min) (point-max)))
   (rainbow-delimiters-mode-disable) ; ironically, rainbow-delimiters gets
                                     ; in the way
   (jit-lock-register 'pretty-colors-colorize-region t)
    ;(pretty-colors-colorize-region (point-min) (point-max))
    ))
 
(provide 'pretty-colors)
;;PRETTY COLORS MODE END
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(agda2-include-dirs (quote ("./ /usr/lib/agda")))
 '(exec-path (quote ("/home/andrew/.opam/system/bin" "/home/andrew/.opam/system/bin" "/usr/lib/lightdm/lightdm" "/usr/local/sbin" "/usr/local/bin" "/usr/sbin" "/usr/bin" "/sbin" "/bin" "/usr/games" "/usr/local/games" "/usr/lib/emacs/24.2/x86_64-linux-gnu" "/home/andrew/.cabal/bin")))
 '(haskell-mode-hook (quote (turn-on-haskell-simple-indent)))
 '(send-mail-function (quote smtpmail-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(rainbow-delimiters-depth-1-face ((t (:foreground "magenta"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "dark slate blue"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "cyan"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "white smoke"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "purple"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "red1"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "VioletRed3"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "navajo white"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "dark slate gray")))))

(rainbow-delimiters-mode t)
(pretty-colors-mode t)

(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook 'pretty-colors-mode)

(load-file "/home/andrew/.cabal/share/x86_64-linux-ghc-7.6.3/Agda-2.3.2.2/emacs-mode/agda2.el")

;;To make use of the Agda standard library, add /usr/lib/agda to the Agda search path, either using the --include-path flag or by customising the Emacs mode variable agda2-include-dirs (M-x customize-group RET agda2 RET).

