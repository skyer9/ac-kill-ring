;;; ac-kill-ring.el --- auto complete source using kill ring   -*- coding: utf-8 -*-
;;
;;; Author: skyer9 <skyer9 at gmail dot com>
;;; URL: https://github.com/skyer9/ac-kill-ring
;;; Version: 0.1
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;
;;; Commentary:

;; Usage:

;; (require 'ac-kill-ring)
;;
;; (add-hook 'xxxxxxx-mode-hook
;;   (lambda ()
;;     (setq ac-sources
;;       '(
;;         ac-source-kill-ring
;;         ;; and other sources
;;         ))
;;

;;; Code:

(require 'auto-complete)

(defgroup ac-kill-ring nil
  "ac-kill-ring auto-complete customizations"
  :prefix "ac-slime-"
  :group 'ac-kill-ring)

(defface ac-kill-ring-candidate-face
  '((t (:inherit ac-candidate-face
                 :background "sandybrown" :foreground "black")))
  "Face for kill-ring candidate."
  :group 'auto-complete)

(defface ac-kill-ring-selection-face
  '((t (:inherit ac-selection-face :background "coral3")))
  "Face for the kill-ring selected candidate."
  :group 'auto-complete)

(defcustom ac-kill-ring-max-length 100
  "max length of kill ring"
  :group 'ac-kill-ring
  )

(defcustom ac-kill-ring-skip-multi-line-kills t
  "skip multi line kills"
  :group 'ac-kill-ring)

(defun ac-kill-ring-candidates ()
  (with-no-warnings
    (let ((hashtab kill-ring)
          (i 0)
          candidate
          candidates)
      (while (< i (length hashtab))
        (setq candidate (substring-no-properties (elt hashtab i)))
        (if (or (not (string-match "\n" candidate)) (not ac-kill-ring-skip-multi-line-kills))
          (if (< (length candidate) ac-kill-ring-max-length)
            (push candidate candidates)))
        (setq i (1+ i)))
      candidates)))

(ac-define-source kill-ring
  '((candidates . ac-kill-ring-candidates)
    (candidate-face . ac-kill-ring-candidate-face)
    (selection-face . ac-kill-ring-selection-face)
    (symbol . "k")))

(provide 'ac-kill-ring)

;;; ac-kill-ring.el ends here
