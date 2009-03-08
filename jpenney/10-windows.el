(if (string-match jcp-systype "windows")
    (progn
      (setq browse-url-browser-function
            'browse-url-default-windows-browser)
      )
  )
