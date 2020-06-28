#!/bin/zsh -
# Variable                               	 Value                   	 Meaning                                                                                                                                                            	 WebKit ports
# GIGACAGE_ENABLED                       	 0                       	 Disable gigacage (needed to use valgrind)                                                                                                                          	 ALL
# JavaScriptCoreUseJIT                   	 0                       	 Disable the JavaScript JIT                                                                                                                                         	 ALL
# JSC_useFTLJIT                          	 0                       	 Disable the JavaScript FTL JIT                                                                                                                                     	 ALL
# JSC_dumpOptions                        	 3                       	 Dumps all the JSC options available to tweak                                                                                                                       	 ALL
# JSC_${option from previous command}    	 ${value}                	 ${check with JSC_dumpOptions=3}                                                                                                                                    	 ALL
# Malloc                                 	 1                       	 Disable bmalloc memory allocator and use the system default one instead. On Darwin systems, also set __XPC_Malloc in order to pass on the value to child processes 	 ALL
# WEBKIT_FORCE_COMPOSITING_MODE          	 1                       	 Force Accelerated Compositing mode to be always on                                                                                                                 	 WebKitGTK+ (since 2.10.5)
# WEBKIT_DISABLE_COMPOSITING_MODE        	 1                       	 Force Accelerated Compositing mode to be always off                                                                                                                	 WebKitGTK+ (since 2.10.9)
# WEBKIT_INSPECTOR_SERVER                	 ${ip.ad.dre.ss}:${port} 	 Enables the Remote WebInspector at http://${ip.ad.dre.ss}:${port} (NOTE: Use the same version of WebKit to load the address)                                       	 WebKitGTK+
# WEBKIT_SHOW_FPS                        	 1                       	 Shows a small square with the FPS measured at the top-right corner of the web view                                                                                 	 WebKitGTK+ and WPE WebKit
# WEBKIT_SAMPLE_MEMORY                   	 1                       	 Generates in /tmp some text files with memory stats.                                                                                                               	 WebKitGTK+ (since 2.15.2) and WPE WebKit
# WEBKIT_FORCE_SANDBOX                   	 1                       	 Force enables the web process sandbox                                                                                                                              	 WebKitGTK+ (since 2.23.1), not yet available for WPE WebKit
# WEBKIT_ENABLE_DBUS_PROXY_LOGGING       	 1                       	 Use for debugging the the sandbox's D-Bus proxy                                                                                                                    	 WebKitGTK+ (since 2.23.1), not yet available for WPE WebKit
# WEBKIT_WEBRTC_DISABLE_UNIFIED_PLAN     	 1                       	 Use to disable Unified Plan as SDP format                                                                                                                          	 WebKitGTK+ and WPE WebKit (since 2.23.1)
# WEBKIT_FORCE_COMPLEX_TEXT              	 0                       	 Confusing! Use only to disable complex text codepath                                                                                                               	 WebKitGTK+ (since 2.22.0), not available for WPE WebKit
# WEBKIT_DISABLE_MEMORY_PRESSURE_MONITOR 	 1                       	 Use to disable memory pressure monitor                                                                                                                             	 WebKitGTK+ and WPE WebKit (since 2.22.0)
# WEBKIT_GST_DISABLE_FAST_MALLOC         	 1                       	 Use to disable the GStreamer FastMalloc allocator                                                                                                                  	 WebKitGTK+ and WPE WebKit
# WEBKIT_GST_MAX_AVC1_RESOLUTION         	                         	 Set to 1080P, 720P or 480P to max out the H264/AVC1 resolution advertised as supported by the GStreamer media-capabilities backend                                 	 WebKitGTK+ and WPE WebKit (since 2.25.2)
# WEBKIT_GST_USE_PLAYBIN3                	 1                       	 Enable the next-generation playbin3 element for media playback (MSE not supported yet)                                                                             	 WebKitGTK+ and WPE WebKit
# WEBKIT_EGL_PIXEL_LAYOUT                	 RGB565                  	 Set the EGL pixel format used for rendering                                                                                                                        	 WPE WebKit
# WEBKIT_DEBUG                           	 all or ${channel}       	 Enable debugging channels. Check WebKitGTK/Debugging#Loggingsupport for more info                                                                                  	 WebKitGTK+ and WPE WebKit


#export GIGACAGE_ENABLED=0
#export JavaScriptCoreUseJIT=0
#export JSC_useFTLJIT=0
#export JSC_dumpOptions
#export JSC_${option from previous command}
#export Malloc=1
#export WEBKIT_FORCE_COMPOSITING_MODE=1
export WEBKIT_DISABLE_COMPOSITING_MODE=1
#export WEBKIT_INSPECTOR_SERVER
export WEBKIT_SHOW_FPS=1
export WEBKIT_SAMPLE_MEMORY=1
export WEBKIT_FORCE_SANDBOX=0
export WEBKIT_ENABLE_DBUS_PROXY_LOGGING=1
#export WEBKIT_WEBRTC_DISABLE_UNIFIED_PLAN
#export WEBKIT_FORCE_COMPLEX_TEXT
#export WEBKIT_DISABLE_MEMORY_PRESSURE_MONITOR
#export WEBKIT_GST_DISABLE_FAST_MALLOC
#export WEBKIT_GST_MAX_AVC1_RESOLUTION
#export WEBKIT_GST_USE_PLAYBIN3
#export WEBKIT_EGL_PIXEL_LAYOUT
export WEBKIT_DEBUG=all
