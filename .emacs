;;adds hjkl movement and remaps their old keys to the old movement keys
;; ; (backward-char) C-b <- C-h is the help map (help-command)  
;; ; (next-line)     C-n <- C-j is (newline-and-indent)         
;; ; (previous-line) C-p <- C-k is (kill-line)                  
;; ; (forward-char)  C-f <- C-l is (recenter-top-bottom)        
(global-set-key "\C-b" 'help-command)                        
(global-set-key "\C-n" 'newline-and-indent)                  
(global-set-key "\C-p" 'kill-line)                           
(global-set-key "\C-f" 'recenter-top-bottom)                 
(global-set-key "\C-h" 'backward-char)                       
(global-set-key "\C-j" 'next-line)                                                                                     
(global-set-key "\C-k" 'previous-line)                       
(global-set-key "\C-l" 'forward-char)      

;; turns control shift F into format buffer -
(global-set-key (kbd "C-F") #'(lambda () (interactive) (indent-region (point-min) (point-max))))

;;;;using EMMS as a music player - https://www.gnu.org/software/emms/
;;Setup
(require 'emms-setup)
(emms-all)
(emms-default-players)
(define-emms-simple-player mplayer '(file url)
      (regexp-opt '(".ogg" ".mp3" ".wav" ".mpg" ".mpeg" ".wmv" ".wma"
                    ".mov" ".avi" ".divx" ".ogm" ".asf" ".mkv" "http://" "mms://"
                    ".rm" ".rmvb" ".mp4" ".flac" ".vob" ".m4a" ".flv" ".ogv" ".pls"))
      "mplayer" "-slave" "-quiet" "-really-quiet" "-fullscreen")
(emms-add-directory-tree "~/Music/")
(emms-shuffle)
;;Keybindings - NOW GLOBAL thanks to xbindkeys
;(global-set-key (kbd "<kp-subtract>") 'emms-previous)
;(global-set-key (kbd "<kp-add>") 'emms-next)
;(global-set-key (kbd "<kp-multiply>") 'emms-start)
;(global-set-key (kbd "<kp-divide>") 'emms-pause)

;; Libtag support
(require 'emms-info-libtag)
(setq emms-info-functions '(emms-info-libtag))

;; Stolen from https://www.gnu.org/software/emms/configs/lb-emms.el
(defun emms-info-track-description (track)
  "Return a description of the current track."
  (if (and (emms-track-get track 'info-artist)
           (emms-track-get track 'info-title))
      (let ((pmin (emms-track-get track 'info-playing-time-min))
            (psec (emms-track-get track 'info-playing-time-sec))
            (ptot (emms-track-get track 'info-playing-time))
            (art  (emms-track-get track 'info-artist))
            (tit  (emms-track-get track 'info-title)))
        (cond ((and pmin psec) (format "%s - %s [%02d:%02d]" art tit pmin psec))
              (ptot (format  "%s - %s [%02d:%02d]" art tit (/ ptot 60) (% ptot 60)))
              (t (emms-track-simple-description track))))))

;For some reason, this breaks the above but it was included in the website
;I got the above off so I'm leaving it here for good measure
;(setq emms-track-description-function 'emms-info-track-description)

;for better integration with printing externally
(defun emms-no-show ()
  "Modified the original emms-show from http://git.savannah.gnu.org/cgit/emms.git/tree/lisp/emms.el
  will return the song name without printing in minibuffer (for querying purposes).
  Would not have been possible with proprietary software!"
  (interactive "P")
  (if emms-player-playing-p
    (format emms-show-format
            (emms-track-description
              (emms-playlist-current-selected-track)))
    "Nothing playing right now"))

;;for Common Lisp
(setq inferior-lisp-program "clisp -modern -I")

;;; Colour theme and transparency
;;colour theme
(add-to-list 'default-frame-alist '(foreground-color . "gray"))
(add-to-list 'default-frame-alist '(background-color . "gray10"))
(add-to-list 'default-frame-alist '(cursor-color . "white"))
;;transparency
;first arg = focussed, second arg = unfocussed
(add-to-list 'default-frame-alist '(alpha . (85 80))) 

;; clean scratch, no more startup screen
;now defaults to the scratch instead of the startup screen.
(setq initial-scratch-message nil)
(setq inhibit-startup-message t)

;;LaTeX style \ commands everywhere
(set-input-method 'TeX)

;;cleaner UI
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-visual-line-mode t)
(show-paren-mode t)
;(menu-bar-mode 1)

;;Enabling Ido mode and setting it to everywhere
(require 'ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;;backups stored in ~/.emacs.d rather than normal dir
(setq save-place-file (concat user-emacs-directory "places")
      backup-directory-alist `(("." . ,(concat user-emacs-directory
                                               "backups"))))

;;escape is now quit/stop (what C-g is)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;;uniquifies file names
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;;reasonable scroll length
(setq scroll-step 1)

;;makes Control W kill word backwards, like normal
(global-set-key "\C-w" 'backward-kill-word)

;;;OCaml things
;; stuff pertaining to Merlin and OPAM
(push
 (concat (substring (shell-command-to-string "opam config var share") 0 -1) "/emacs/site-lisp") load-path)
(setq merlin-command (concat (substring (shell-command-to-string "opam config var bin") 0 -1) "/ocamlmerlin"))
(autoload 'merlin-mode "merlin" "Merlin mode" t)
(add-hook 'tuareg-mode-hook 'merlin-mode)
(add-hook 'caml-mode-hook 'merlin-mode)
;;F6 is now eval buffer for Tuareg Mode
(global-set-key [f6] 'tuareg-eval-buffer)

;EVIL mode
;(require 'evil)
;(setq evil-cross-lines t)
;(evil-mode 1)

;;sensible copy/paste keys
(cua-mode t)
(setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
(transient-mark-mode 1) ;; No region when it is not highlighted
(setq cua-keep-region-after-copy t) ;; Standard Windows behaviour

;;adding package archives
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(require 'package)
(add-to-list 'package-archives 
	     '("marmalade" .
	       "http://marmalade-repo.org/packages/"))
(package-initialize)

;;Agda
(load-file "/home/andrew/.cabal/share/x86_64-linux-ghc-7.6.3/Agda-2.3.2.2/emacs-mode/agda2.el")
;;To make use of the Agda standard library, add /usr/lib/agda to the Agda search path, either using the --include-path flag or by customising the Emacs mode variable agda2-include-dirs (M-x customize-group RET agda2 RET).

;;starting fullscreen for non-tiling WMs/DEs (if I ever want this) -
;(add-to-list 'default-frame-alist '(fullscreen . fullboth)) 

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

;; Set auto-mode-alist for various modes and autload others

(setq auto-mode-alist (append '(("\\.fish\\'" . shell-script-mode)
				;in case I ever need more, there are
				;some other examples below
				("\\.rkt\\'" . scheme-mode)
				("\\.pl\\'" . prolog-mode))
			      auto-mode-alist))

;;kindly taken from http://emacs-fu.blogspot.co.uk/2009/10/writing-presentations-with-org-mode-and.html
;;unsure if I need this, but keeping it in for good measure
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

;(provide 'pretty-colors)
;;;;UNCOMMENT THE ABOVE AND LINES AT THE END FOR PRETTY COLOURS
;;PRETTY COLORS MODE END
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(agda2-include-dirs (quote ("/usr/lib/agda .")))
 '(exec-path (quote ("/home/andrew/.opam/system/bin" "/home/andrew/.opam/system/bin" "/usr/lib/lightdm/lightdm" "/usr/local/sbin" "/usr/local/bin" "/usr/sbin" "/usr/bin" "/sbin" "/bin" "/usr/games" "/usr/local/games" "/usr/lib/emacs/24.2/x86_64-linux-gnu" "/home/andrew/.cabal/bin")))
 '(haskell-mode-hook (quote (turn-on-haskell-simple-indent)))
 '(send-mail-function (quote smtpmail-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:foreground "white"))))
 '(mode-line-highlight ((t nil)))
 '(mode-line-inactive ((t (:inherit mode-line :foreground "dim gray" :weight light))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "magenta"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "dark slate blue"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "cyan"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "white smoke"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "purple"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "red1"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "VioletRed3"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "navajo white"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "dark slate gray")))))

;(rainbow-delimiters-mode t)
;(pretty-colors-mode t)

;;global pretty colours - off temporarily
;(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
;(add-hook 'prog-mode-hook 'pretty-colors-mode)
