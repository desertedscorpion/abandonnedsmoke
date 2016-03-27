#!/bin/bash

(cat <<EOF
I don't know why testing this is so hard,
but I doubt it is important that things get pushed more than once per day
so we will manually test it and
use this to set a flag
that can control whether to merge or not.
true = go ahead and merge
false = no to merge
EOF
) &&
    true
