#!/bin/bash
cd ~/software/TSCM_5.1.1.37/TSCM_5.1.1.37
java -cp "jars/jacgui.jar:jars/guiPII.jar:jars/server.jar:jars/jlog.jar" -Djava.net.preferIPv4Stack=true -DSCMHOME=~/software/TSCM_5.1.1.37/TSCM_5.1.1.37 com.ibm.jac.gui.ConfigClient
