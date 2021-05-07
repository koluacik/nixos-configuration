from ranger.colorschemes.default import Default
from ranger.gui.color import bold, red, BRIGHT

class Scheme(Default):

    def use(self, context):
        fg, bg, attr = Default.use(self, context)
        if context.tag_marker and not context.selected:
                attr |= bold
                fg = red
                fg += BRIGHT
        return fg, bg, attr
