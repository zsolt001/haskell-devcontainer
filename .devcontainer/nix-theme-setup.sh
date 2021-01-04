# nix-shell theme - update of the Microsoft codespaces theme
NIX_THEME_BASH="$(cat \
<<EOF
#!/usr/bin/env bash
prompt() {
    if [ "\$?" != "0" ]; then
        local arrow_color=\${bold_red}
    else
        local arrow_color=\${reset_color}
    fi
    if [ ! -z "\${GITHUB_USER}" ]; then
        local USERNAME="gh:@\${GITHUB_USER}"
    else
        local USERNAME="\$(whoami)"
    fi

    if [ ! -z "\${IN_NIX_SHELL}" ]; then
        local NIX_SHELL="\${green}nix-shell:\${IN_NIX_SHELL}\${reset_color}\n"
    else
        local NIX_SHELL=""
    fi

    local cwd="\$(pwd | sed "s|^\${HOME}|~|")"
    PS1="\${NIX_SHELL}\${green}\${USERNAME} \${arrow_color}➜\${reset_color} \${bold_blue}\${cwd}\${reset_color} \$(scm_prompt_info)\${white}$ \${reset_color}"
}
SCM_THEME_PROMPT_PREFIX="\${reset_color}\${cyan}(\${bold_red}"
SCM_THEME_PROMPT_SUFFIX="\${reset_color} "
SCM_THEME_PROMPT_DIRTY=" \${bold_yellow}✗\${reset_color}\${cyan})"
SCM_THEME_PROMPT_CLEAN="\${reset_color}\${cyan})"
SCM_GIT_SHOW_MINIMAL_INFO="true"
safe_append_prompt_command prompt
EOF
)"

sed -i -e 's/OSH_THEME=.*/OSH_THEME="nix-shell"/g' ${HOME}/.bashrc
mkdir -p ${HOME}/.oh-my-bash/custom/themes/nix-shell
echo "${NIX_THEME_BASH}" > ${HOME}/.oh-my-bash/custom/themes/nix-shell/nix-shell.theme.sh