# This file must be used with ". bin/activate.fish" *from fish* (http://fishshell.org)
# you cannot run it directly

function deactivate  -d "Exit virtualenv and return to normal shell environment"

    if test -n "$_OLD_FISH_PROMPT_OVERRIDE"
        functions -e fish_prompt
        set -e _OLD_FISH_PROMPT_OVERRIDE
        functions -c _old_fish_prompt fish_prompt
        functions -e _old_fish_prompt
    end

    set -e VIRTUAL_SYMFONY
    if test "$argv[1]" != "nondestructive"
        # Self destruct!
        functions -e deactivate console doctrine
    end
end

function console --description 'Run bin/console relative to the current dir. If not found it shows an error message'
  if test ! -f "$VIRTUAL_SYMFONY/bin/console"
    echo "Console not found! You are not in an project root, or the console is not located under bin/console." 1>&2
    return 1
  end
  echo $argv
  eval command "$VIRTUAL_SYMFONY/bin/console" $argv
end

function doctrine --description 'Run bin/console doctrine relative to the current dir. The first argument is prepended with "doctrine:", so "doctrine schema:update --dump-sql" will be executed as "bin/console doctrine:schema:update --dump-sql".'
  console doctrine:"$argv"
end


# unset irrelevant variables
deactivate nondestructive

set -gx VIRTUAL_SYMFONY (pwd)

# set -gx _OLD_VIRTUAL_PATH $PATH
# set -gx PATH "$VIRTUAL_SYMFONY" $PATH


if test -z "$VIRTUAL_SYMFONY_DISABLE_PROMPT"
    # fish uses a function instead of an env var to generate the prompt.

    # save the current fish_prompt function as the function _old_fish_prompt
    functions -c fish_prompt _old_fish_prompt

    # with the original prompt function renamed, we can override with our own.
    function fish_prompt
        # Save the return status of the last command
        set -l old_status $status

        printf "%s(%s)%s" (set_color -b green white) (basename "$VIRTUAL_SYMFONY") (set_color normal)

        # Restore the return status of the previous command.
        echo "exit $old_status" | .
        _old_fish_prompt
    end

    set -gx _OLD_FISH_PROMPT_OVERRIDE "$VIRTUAL_SYMFONY"
end
