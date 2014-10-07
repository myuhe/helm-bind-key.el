(defun my-create-sources ()
  "[internal] create an helm source for orgcard."
  (let (heads 
        cur-title 
        cur-records
        last-binding)
    (dolist (binding
             (setq personal-keybindings
                   (sort personal-keybindings
                         #'(lambda (l r)
                             (car (compare-keybindings l r))))))
      (cond
       ((equal last-binding nil) nil)     ; do nothing
       ((equal (cdar binding) nil) nil)
       ((eq (cdar last-binding) (cdar binding))
        (push (cons (format "%-10s\t%s" (caar binding) (cadr binding)) (cadr binding)) cur-records))

       (t
        (setq cur-title (symbol-name(cdar last-binding)))
        (push 
         `((name . ,cur-title)
           (candidates ,@cur-records)
           (type . command))
         heads)
        (setq cur-title nil cur-records nil)
        (push (format "%-10s\t%s" (caar binding) (cadr binding)) cur-records)))
      (setq last-binding binding))
    (reverse heads)))
