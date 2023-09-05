# $args kept becoming "System.Object[]" whenever I tried using it and I ran out ideas to do it normally.
# If you can find a solution that gets rid of this file PLEASE rasie an issue!!!
# https://github.com/helpimnotdrowning/ytdl-scripts/issues
param (
    $inputArguments
)

$argstring = ''

ForEach ($arg in $inputArguments) {
    $argstring += $arg + ' '
}

return $argstring