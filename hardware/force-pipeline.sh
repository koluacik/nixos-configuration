#!/bin/sh
if [ "$TERM_PROGRAM" != "tmux" ]; then
    s="$(nvidia-settings -q CurrentMetaMode -t)"
    if [ "${s}" != "" ]; then
      s="${s#*" :: "}"
      nvidia-settings -a CurrentMetaMode="${s//\}/, ForceFullCompositionPipeline=On\}}"
    fi
fi
