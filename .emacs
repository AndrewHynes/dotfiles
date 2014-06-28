;;Unprefixed Common Lisp expressions for use throughout the file
(require 'cl)
;;Could do (require 'cl-lib), but prefixing "cl-" to everything for some standard functions 
;;is tedious and should not be required

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

;;copy buffer function -
(global-set-key (kbd "C-A") #'(lambda () (interactive) (kill-new (buffer-substring (point-min) (point-max)))))

;;Can now see keystrokes as you're typing them...
(setq echo-keystrokes 0.1)

;;;;using EMMS as a music player - https://www.gnu.org/software/emms/
;;Setup
(require 'emms-setup)
(require 'emms-player-mplayer)
(emms-all)
(emms-default-players)
;;Allowing emms to be able to execute mplayer
(setq exec-path (append exec-path '("/usr/bin")))
(define-emms-simple-player mplayer '(file url)
      (regexp-opt '(".ogg" ".mp3" ".wav" ".mpg" ".mpeg" ".wmv" ".wma"
                    ".mov" ".avi" ".divx" ".ogm" ".asf" ".mkv" "http://" "mms://"
                    ".rm" ".rmvb" ".mp4" ".flac" ".vob" ".m4a" ".flv" ".ogv" ".pls"))
      "mplayer" "-slave" "-quiet" "-really-quiet" "-fullscreen")
(push 'emms-player-mplayer emms-player-list)
(emms-add-directory-tree "~/Music/")
(emms-shuffle)
;;Keybindings - NOW GLOBAL thanks to xbindkeys
;;These are kept here in case I ever want to de-globalify
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

;;For some reason, this breaks the above but it was included in the website
;;I got the above off so I'm leaving it here for good measure
;;(setq emms-track-description-function 'emms-info-track-description)

;;for better integration with printing externally
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

;;Used for trimming some whitespace
;;Main use is to trim whitespace around the current
;;playing time for EMMS
(defun trim-first-and-last (string)
  (substring string 1 (- (length string) 1)))

;;for Common Lisp in Emacs
(setq inferior-lisp-program "clisp -modern -I")

;;Only type y or n, rather than "yes" or "no"
(defalias 'yes-or-no-p 'y-or-n-p)

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

;;LaTeX style \ commands
(set-input-method 'TeX)
;;note, to change back, do
;;M-x set-input-method RET british
;;for some reason, "english" assumes Dvorak

;Keeps 'TeX as the default method everywhere
(defadvice switch-to-buffer (after activate-input-method activate)
  (activate-input-method 'TeX))

;;;cleaner UI
;;removal of bars
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

;;added a toggle in case I ever need to make the menu bar visible
(global-set-key [f9] 'toggle-menu-bar-mode-from-frame)

;;removes ugly vertical border
(set-face-foreground 'vertical-border "gray10")

;;Visual thingies that should be standard
(global-visual-line-mode t)
(show-paren-mode t)

;;Shows the expression rather than just the brackets
(setq show-paren-style 'expression)

;;Enabling Ido mode and setting it to everywhere
(require 'ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;;Smex mode - M-x Ido, essentially
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;;(global-set-key (kbd "C-c M-x") 'execute-extended-command) ; OLD M-x

;;hrngr sexy unicode
(setq smex-prompt-string "λ » ")
;;(setq smex-auto-update nil)
;;(smex-auto-update 60)

;;backups stored in ~/.emacs.d rather than normal dir
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (concat user-emacs-directory "places")
      backup-directory-alist `(("." . ,(concat user-emacs-directory
                                               "backups"))))

;;escape is now quit/stop (what C-g is)
(define-key isearch-mode-map [escape] 'isearch-abort)   ;; for isearch
(global-set-key [escape] 'keyboard-escape-quit)         ;; everywhere else

;;uniquifies file names
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;;reasonable scroll length
(setq scroll-step 1)

;;makes Control W kill word backwards, like normal
(global-set-key "\C-w" 'backward-kill-word)

;;;OCaml things
;;F6 is now eval buffer for Tuareg Mode
(global-set-key [f6] 'tuareg-eval-buffer)

;; stuff pertaining to Merlin
;; (push
;; (concat (substring (shell-command-to-string "opam config var share") 0 -1) "/emacs/site-lisp") load-path)
;; (setq merlin-command (concat (substring (shell-command-to-string "opam config var bin") 0 -1) "/ocamlmerlin"))
;; (autoload 'merlin-mode "merlin" "Merlin mode" t)
;; (add-hook 'tuareg-mode-hook 'merlin-mode)
;; (add-hook 'caml-mode-hook 'merlin-mode)

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

;;Agda
(load-file "/home/andrew/.cabal/share/x86_64-linux-ghc-7.6.3/Agda-2.3.2.2/emacs-mode/agda2.el")
;;To make use of the Agda standard library, add /usr/lib/agda to the Agda search path, either using the --include-path flag 
;;or by customising the Emacs mode variable agda2-include-dirs (M-x customize-group RET agda2 RET).

;;starting fullscreen for non-tiling WMs/DEs (if I ever want this) -
;(add-to-list 'default-frame-alist '(fullscreen . fullboth))

;;relative line numbers -
;;adapted from https://stackoverflow.com/questions/6874516/relative-line-numbers-in-emacs

(require 'linum)
(defvar my-linum-format-suffix "%3d")

(add-hook 'linum-before-numbering-hook 'my-linum-get-format-suffix)

(defun my-linum-get-format-suffix ()
  (let* ((width (1+ (length (number-to-string
                             (count-lines (point-min) (point-max))))))
         (format (concat (number-to-string width) "d")))
    (setq my-linum-format-suffix format)))

(defvar my-linum-current-line-number 0)

(setq linum-format 'my-linum-relative-line-numbers)

(defun my-linum-relative-line-numbers (line-number)
  (let* ((offset (abs (- line-number my-linum-current-line-number)))
   (offset-or-abs (if (= offset 0) my-linum-current-line-number offset)))
    (propertize (format (concat (if (= offset 0) "%-" "%") my-linum-format-suffix) offset-or-abs) 'face 
      '(:foreground "#33AAFF" :background "gray15"))))
;;the above denotes the foreground and background colour for the linum numbers on the left.
;;;Example colours -
;;(insert (propertize "bar" 'face '(:foreground "red")))
;;(insert (propertize "bar" 'face '(:background "gray30")))
;;(insert (propertize "bar" 'face '(:foreground "#33AAFF")))
;;(insert (propertize "bar" 'face '(:foreground "orange" :background "purple")))

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

;;;;MY CUSTOM EMACS FUNCTIONS THAT DON'T FIT ANYWHERE ELSE START
(defun diff ()
  "Removes non-unique lines from a buffer."
  (interactive)
  (let ((end-of-this-file (point-max)))
    (save-excursion
      (goto-char (point-min))
      (while (< (point) end-of-this-file)
	(let ((line (buffer-substring-no-properties 
		     (line-beginning-position) (line-end-position)))
	      (line-start-pos (line-beginning-position)))
	  (forward-line 1)
	  (let ((unique t))
	    (save-excursion
	      (goto-char (point-min))
	      (while (< (point) end-of-this-file)
		(let ((currentline (buffer-substring-no-properties 
				    (line-beginning-position) (line-end-position))))
		  (when (string= line currentline)
		    (when (not (= line-start-pos (line-beginning-position))) (setf unique nil)))
		  (forward-line 1))))
	    (when unique
	      (save-excursion (goto-char (point-max))
			      (insert line)
			      (newline)))))))
    (delete-region (point-min) end-of-this-file)))


(defun to-ocaml-list ()
  "Turns a buffer full of strings into an OCaml compatable
   list of strings."
  (interactive)
  (save-excursion
  (goto-char (point-min))
  (insert "[\n")
  (while (not (eobp))
    (if (not (= (line-number-at-pos) 2))
	(insert ";"))
    (insert "\"")
    (end-of-line)
    (insert "\"")
    (forward-line))
  (insert "]")))


;;;;MY CUSTOM EMACS FUNCTIONS THAT DON'T FIT ANYWHERE ELSE END

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
 '(rainbow-delimiters-depth-9-face ((t (:foreground "dark slate gray"))))
 '(show-paren-match ((t (:background "gray20"))))) ;;paren matching is gray rather than ugly ugly blue

