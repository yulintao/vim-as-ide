(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
			   ("melpa" . "http://elpa.emacs-china.org/melpa/"))))

;; common lisp externsion
(require 'cl)

;; add my packages
(defvar my/packages '(
	;; --- Auto-completion --
	company
	;; -- Better Editor ---
	hungry-delete
	swiper
	counsel
	smartparens
	;; --- Themes ---
	monokai-theme
	;; solarized-theme
	) "Default packages")

(setq package-selected-packages my/packages)
(defun my/packages-installed-p ()
  (loop for pkg in my/packages
	when (not (package-installed-p pkg)) do (return nil)
	finally (return t)))

(unless (my/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg my/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

(add-to-list 'my/packages 'monokai-theme)
(load-theme 'monokai 1)

;; display line num
(global-linum-mode 1)
(setq linum-format "%d| ")

;; 关闭自动备份
(setq make-backup-files nil)
;; backup directory
;; (setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; save disk space
(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))

;; history 
(setq savehist-file "~/.emacs.d/savehist")
(savehist-mode 1)
(setq history-length t)
(setq history-delete-duplicates t)
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring))

;; window config close toolbar（工具栏）
(tool-bar-mode -1)

;; 默认全屏
(setq initial-frame-alist (quote ((fullscreen . maximized))))

;; 当前行高亮
(global-hl-line-mode 1)

;; 关闭文件滑动控件
;;(scrool-bar-mod -1)

;; 关闭启动帮助界面
(setq inhibit-splash-screen 1)

;; 更改显示字体大小 13pt
(set-face-attribute 'default nil :height 130)

;; 快速打开配置文件,将函数 open-init-file 绑定到 <f2> 键上
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "<f2>") 'open-init-file)

;; display time at modeline
;; (display-time-mode 1)

;;;; 改变Emacs主题
;;(custom-set-variables
;; ;; custom-set-variables was added by Custom.
;; ;; If you edit it by hand, you could mess it up, so be careful.
;; ;; Your init file should contain only one such instance.
;; ;; If there is more than one, they won't work right.
;; '(custom-enabled-themes (quote (adwaita))))
;;(custom-set-faces
;; ;; custom-set-faces was added by Custom.
;; ;; If you edit it by hand, you could mess it up, so be careful.
;; ;; Your init file should contain only one such instance.
;; ;; If there is more than one, they won't work right.
;; )
