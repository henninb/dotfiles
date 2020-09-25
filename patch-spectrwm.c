--- spectrwm.c	2020-09-25 13:32:43.092631223 -0500
+++ spectrwm.c.patched	2020-09-25 13:32:38.555964631 -0500
@@ -5927,11 +5927,9 @@
 	g.y += region_padding;
 	g.w -= 2 * border_width + 2 * region_padding;
 	g.h -= 2 * border_width + 2 * region_padding;
-	if (bar_enabled && r->ws->bar_enabled) {
 		if (!bar_at_bottom)
 			g.y += bar_height;
 		g.h -= bar_height;
-	}
 
 	DNPRINTF(SWM_D_STACK, "workspace: %d (screen: %d, region: %d), (x,y) "
 	    "WxH: (%d,%d) %d x %d\n", r->ws->idx, r->s->idx,
