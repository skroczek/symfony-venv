# This file must be used with ". bin/activate.fish" *from fish* (http://fishshell.org)
# you cannot run it directly

function deactivate  -d "Exit virtualenv and return to normal shell environment"
    # reset old environment variables
    if test -n "$_OLD_VIRTUAL_PATH"
        set -gx PATH $_OLD_VIRTUAL_PATH
        set -e _OLD_VIRTUAL_PATH
    end
    if test -n "$_OLD_FISH_PROMPT_OVERRIDE"
        functions -e fish_prompt
        set -e _OLD_FISH_PROMPT_OVERRIDE
        functions -c _old_fish_prompt fish_prompt
        functions -e _old_fish_prompt
    end

    set -e VIRTUAL_SYMFONY
    if test "$argv[1]" != "nondestructive"
        # Self destruct!
        functions -e deactivate console doctrine artisan e
    end
end

function e  -d "Set application environment"
    if test -n "$APP_ENV"
        set -gx APP_ENV "$argv[1]"
        set -gx SYMFONY_ENV "$argv[1]"
    end
end

function ccc  -d "Calls console cache:clear"
    $VIRTUAL_SYMFONY/bin/console cache:clear
end

# unset irrelevant variables
deactivate nondestructive

set -gx VIRTUAL_SYMFONY (pwd)

set -gx _OLD_VIRTUAL_PATH $PATH
if test -d "$VIRTUAL_SYMFONY/bin"
    set -gx PATH "$VIRTUAL_SYMFONY/bin" $PATH
    set -gx APP_ENV "dev"
    set -gx SYMFONY_ENV "dev"
    if type -q symfony-autocomplete
        symfony-autocomplete "$VIRTUAL_SYMFONY/bin/console" | source
    end
end

if type -q "$VIRTUAL_SYMFONY/artisan"
    function artisan --description 'Run artisan.'
      $VIRTUAL_SYMFONY/artisan "$argv"
    end
    set -gx APP_ENV "local"
    if type -q symfony-autocomplete
        symfony-autocomplete "$VIRTUAL_SYMFONY/artisan" | source
    end
end



if test -z "$VIRTUAL_SYMFONY_DISABLE_PROMPT"
    # fish uses a function instead of an env var to generate the prompt.

    # save the current fish_prompt function as the function _old_fish_prompt
    functions -c fish_prompt _old_fish_prompt

    # with the original prompt function renamed, we can override with our own.
    function fish_prompt
        # Save the return status of the last command
        set -l old_status $status

        printf "%s%s (%s)%s" (set_color -b green white) (basename "$VIRTUAL_SYMFONY") "$APP_ENV" (set_color normal)

        # Restore the return status of the previous command.
        echo "exit $old_status" | .
        _old_fish_prompt
    end

    set -gx _OLD_FISH_PROMPT_OVERRIDE "$VIRTUAL_SYMFONY"
end
