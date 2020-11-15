;;; cue-mode.el --- Major mode for cuelang

;; Copyright © 2020, by Paul Haerle

;; Author: Paul Haerle (emacs@phaer.org)
;; Version: 0.0.1
;; Keywords: languages

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; This package provides a major mode to work with files written
;; in https://cuelang.org

;;; Code:

(defvar cue-mode-font-lock-keywords)
(setq cue-mode-font-lock-keywords
      `(
        ("\\(//\\)\\(.*\\)$"
         (1 font-lock-comment-delimiter-face t)
         (2 font-lock-comment-face t))
        ("\\([\\{\\}\(\)]\\)"  (1 font-lock-keyword-face))
        ("\\(package\\|import\\|&\\||\\|*\\)"  (1 font-lock-keyword-face))
        ("\\([A-Za-z0-1\\ ]+: \\)"   (1 font-lock-variable-name-face))
        ("\\([A-Za-z0-1\\ ]+:: \\)"  (1 font-lock-constant-face))))

;;;###autoload
(define-derived-mode cue-mode prog-mode
  "cue"
  "Major mode for cuelang."
  (kill-all-local-variables)
  (set (make-local-variable 'font-lock-defaults) '(cue-mode-font-lock-keywords))
  (setq mode-name "Cue"
        indent-line-function 'js-indent-line))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.cue\\'" . cue-mode))

;; add the mode to the `features' list
(provide 'cue-mode)

;; Local Variables:
;; coding: utf-8
;; End:

;;; cue-mode.el ends here
