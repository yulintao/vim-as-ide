(package-initialize)
(setq use-package-always-ensure t)

;;setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
;;			("melpa" . "http://elpa.emacs-china.org/melpa/" t)))

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

;; helm package
;;(use-package helm
;;  :diminish helm-mode
;;  :init
;;  (progn
;;    (require 'helm-config)
;;    (setq helm-candidate-number-limit 100)
;;    ;; From https://gist.github.com/antifuchs/9238468
;;    (setq helm-idle-delay 0.0 ; update fast sources immediately (doesn't).
;;          helm-input-idle-delay 0.01  ; this actually updates things
;;                                        ; reeeelatively quickly.
;;          helm-yas-display-key-on-candidate t
;;          helm-quick-update t
;;          helm-M-x-requires-pattern nil
;;          helm-ff-skip-boring-files t)
;;    (helm-mode))
;;  :bind (("C-c h" . helm-mini)
;;         ("C-h a" . helm-apropos)
;;         ("C-x C-b" . helm-buffers-list)
;;         ("C-x b" . helm-buffers-list)
;;         ("M-y" . helm-show-kill-ring)
;;         ("M-x" . helm-M-x)
;;         ("C-x c o" . helm-occur)
;;         ("C-x c s" . helm-swoop)
;;         ("C-x c y" . helm-yas-complete)
;;         ("C-x c Y" . helm-yas-create-snippet-on-region)
;;         ("C-x c b" . my/helm-do-grep-book-notes)
;;         ("C-x c SPC" . helm-all-mark-rings)))
;;(ido-mode -1) ;; Turn off ido mode in case I enabled it accidentally
;;

