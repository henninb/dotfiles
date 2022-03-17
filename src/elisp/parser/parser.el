  (defun org-read-csv ()
  (interactive)
  (progn
    (find-file (read-file-name "CSV location:"))
    (org-mode)
    (goto-char (point-min))
    (insert "|")
    (while (re-search-forward "\n" nil t)
      (replace-match "|\n|"))
    (delete-char -1)
    (while (re-search-backward "," nil t)
      (replace-match "|"))
    (org-table-align)
    ))

(org-read-csv)

 (with-temp-buffer
   (insert-file-contents-literally "input.csv")
   (split-string (buffer-string) "\n"))
