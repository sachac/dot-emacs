;;; mc-separate-operations.el - functions that work differently on each cursor

;; Copyright (C) 2012 Magnar Sveen

;; Author: Magnar Sveen <magnars@gmail.com>
;; Keywords: editing cursors

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

;;; Commentary:

;; This file contains functions that work differently on each cursor,
;; instead of treating all of them the same.

;; Please see multiple-cursors.el for more commentary.

;;; Code:

(require 'multiple-cursors-core)

;;;###autoload
(defun mc/insert-numbers (arg)
  "Insert increasing numbers for each cursor, starting at 0 or ARG."
  (interactive "P")
  (setq mc--insert-numbers-number (or arg 0))
  (mc/for-each-cursor-ordered
   (mc/execute-command-for-fake-cursor 'mc--insert-number-and-increase cursor)))

(defvar mc--insert-numbers-number 0)

(defun mc--insert-number-and-increase ()
  (interactive)
  (insert (number-to-string mc--insert-numbers-number))
  (setq mc--insert-numbers-number (1+ mc--insert-numbers-number)))

(defun mc--ordered-region-strings ()
  (let (strings)
    (save-excursion
      (mc/for-each-cursor-ordered
       (add-to-list 'strings (buffer-substring-no-properties
                              (mc/cursor-beg cursor)
                              (mc/cursor-end cursor))))strings)
    (nreverse strings)))

(defvar mc--strings-to-replace nil)

(defun mc--replace-region-strings-1 ()
  (interactive)
  (delete-region (region-beginning) (region-end))
  (insert (car mc--strings-to-replace))
  (setq mc--strings-to-replace (cdr mc--strings-to-replace)))

(defun mc--replace-region-strings ()
  (mc/for-each-cursor-ordered
   (mc/execute-command-for-fake-cursor 'mc--replace-region-strings-1 cursor)))

;;;###autoload
(defun mc/reverse-regions ()
  (interactive)
  (if (not (use-region-p))
      (message "Mark regions to reverse first.")
    (setq mc--strings-to-replace (nreverse (mc--ordered-region-strings)))
    (mc--replace-region-strings)))

;;;###autoload
(defun mc/sort-regions ()
  (interactive)
  (if (not (use-region-p))
      (message "Mark regions to sort first.")
    (setq mc--strings-to-replace (sort (mc--ordered-region-strings) 'string<))
    (mc--replace-region-strings)))

(provide 'mc-separate-operations)
;;; mc-separate-operations.el ends here
