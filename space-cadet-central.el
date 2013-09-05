;;;  Space Cadet Central
;;
;;          being
;;
;;   A Bunch of Widgets
;;
;;         part of
;;
;;           the
;;
;; '(emacs liberation :fron t)
;;
;;


(defvar space-cadet-central-version "$Id: 0.01 SNAPSHOT $")

(defgroup space-cadet-central nil
  "space-cadet-central"
  :group 'emacs)


(require 'widget)

(eval-when-compile
    (require 'wid-edit))

(defvar space-cadet-toplist '("Q" "W" "E" "R" "T" "Y" "U" "I" "O" "P" "{" "}" "|"))

(defvar space-cadet-midlist '("A" "S" "D" "F" "G" "H" "J" "K" "L" ":" "\""))

(defvar space-cadet-bottomlist '("Z" "X" "C" "V" "B" "N" "M" "<" ">" "?"))

(defvar space-cadet-central-selected)

(defvar space-cadet-right-window)

(defvar -:-magic-button)
(defvar -:-space-bar)

(defvar space-cadet-keymap widget-keymap)

(defun space-cadet-key-notified (self &rest ignore)
  "Self-describe key and other notification actions"
  (describe-key (widget-get self :value)))

(defun space-cadet-make-keywidgets (keylist)
  "Make self-describing buttons from a list of keys"
  (let ((key-char (car keylist)))
    (widget-create 'push-button
                   :notify #'space-cadet-key-notified
                   key-char))
  (when (cdr keylist)
    (progn (widget-insert " ") (space-cadet-make-keywidgets (cdr keylist)))))

(defun space-cadet-make-keyboard ()
  "Create the Space Cadet Keyboard"
  (progn (widget-insert "\n                **Space Cadet Central**\n\n\n")
  (widget-create 'push-button "TAB")
  (widget-insert " ")
  (space-cadet-make-keywidgets space-cadet-toplist)
  (widget-insert "\n\n")
  (widget-create 'push-button "CAPS")
  (widget-insert "  ")
  (space-cadet-make-keywidgets space-cadet-midlist)
  (widget-insert "\n\n         ")
  (space-cadet-make-keywidgets space-cadet-bottomlist)
  (widget-insert "\n\n                  ")
  (setq -:-space-bar (widget-create 'push-button
                                    :notify (lambda (&rest ignore)
                                              (widget-put -:-magic-button :value
                                                          "MUCH MORE MAGIC")
                                              (widget-setup)
                                              (message "hit me!"))
                                    "Space Cadet Bar"))
  (widget-insert "\n\n\n")))

(defun space-cadet-central ()
  "Space Cadet Central.
You are the Keymaster.
Emacs is the Gatekeeper. Have at it."
  (interactive)
  (switch-to-buffer "*Space Cadet Central*")
  (kill-all-local-variables)
  (make-local-variable 'space-cadet-central-repeat)
  (let ((inhibit-read-only t))
     (erase-buffer))
  (remove-overlays)
  (delete-other-windows)
  (setq space-cadet-right-window (split-window-right))
  (set-window-buffer space-cadet-right-window (help-buffer) t)
  (describe-function 'space-cadet-central)
  (space-cadet-make-keyboard)
  (setq -:-magic-button (widget-create 'push-button "MAGIC"))
  (widget-insert "\n\n")
  (widget-create 'checkbox t)
  (widget-insert "Ctrl\n")
  (widget-create 'checkbox nil)
  (widget-insert "Hyper\n")
  (widget-create 'checkbox nil)
  (widget-insert "Meta\n")
  (widget-create 'checkbox nil)
  (widget-insert "Shift\n")
  (widget-create 'checkbox nil)
  (widget-insert "Super\n")
  (use-local-map space-cadet-keymap)
  (widget-setup)
  (zone))

;(space-cadet-make-keywidgets '("Q" "W"))[Q][W]

;(type-of (car space-cadet-keylist))
(provide 'space-cadet-central)
