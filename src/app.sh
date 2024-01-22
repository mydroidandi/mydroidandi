################################################################################
#                                   Commbase                                   #
#                                                                              #
# AI Powered Conversational Assistant for Computers and Droids                 #
#                                                                              #
# Change History                                                               #
# 04/29/2023  Esteban Herrera Original code.                                   #
#                           Add new history entries as needed.                 #
#                                                                              #
#                                                                              #
################################################################################
################################################################################
################################################################################
#                                                                              #
#  Copyright (c) 2022-present Esteban Herrera C.                               #
#  stv.herrera@gmail.com                                                       #
#                                                                              #
#  This program is free software; you can redistribute it and/or modify        #
#  it under the terms of the GNU General Public License as published by        #
#  the Free Software Foundation; either version 3 of the License, or           #
#  (at your option) any later version.                                         #
#                                                                              #
#  This program is distributed in the hope that it will be useful,             #
#  but WITHOUT ANY WARRANTY; without even the implied warranty of              #
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the               #
#  GNU General Public License for more details.                                #
#                                                                              #
#  You should have received a copy of the GNU General Public License           #
#  along with this program; if not, write to the Free Software                 #
#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA   #

# app
# Creates the Commbase application interface, replaces the hostname and host IP
# address, and enters the Commbase session.
app() {
	# Path to the env file
	ENV_FILE="$COMMBASE_APP_DIR/env/.env";

	# Assign the host values from the operating system
	NEW_HOST_NAME=$(hostname | awk '{print $1}');
	NEW_HOST_IP_ADDRESS=$(hostname -I | awk '{print $1}');

	# The configuration file
	source $COMMBASE_APP_DIR/config/app.conf

	# Give .3 seconds to tmux to draw its content before continuing
	time=0.3;

	# Kill any existent tmux Commbase session in order to avoid duplicates
	tmux kill-session -t Commbase-0;

	# Create a new session, detach from it to continue, and sleep
	tmux new-session -d -t "Commbase" && sleep $time;

	# Create windows and panels

	# Window 0: Commbase
	# Rename the first tmux window, window 0, split it horizontally, and focus the
	# cursor in pane 0 (above).
	tmux rename-window "Commbase" && tmux split-window -v && tmux select-pane -t 1;

	# Split vertically the pane 0
	tmux split-window -h && tmux select-pane -t 1 && sleep $time;

	# Split horizontally the pane 0 
	tmux split-window -v && tmux select-pane -t 1 && sleep $time;
 
	# Pane 1
	# Focus the cursor in window 0, with pane 1 selected by default, activate the
	# conda environment if it exists, send the enter key, and sleep.
	tmux select-window -t 1 && tmux send-keys " conda activate $CONDA_ENV_NAME_IF_EXISTS" C-m && sleep $time;

	# On window 0, with pane 1 selected by default, run Python and then press the
	# enter key.
	tmux send-keys " cpulimit --limit=$STT_PROCESS_CPU_LIMIT_PERCENTAGE -- $STT_ENGINE_STRING" C-m;

	# Pane 2
	# On window 0, select pane 2, activate the conda environment if it exists,
	# send the enter key, and sleep.
	tmux select-pane -t 2 && tmux send-keys " conda activate $CONDA_ENV_NAME_IF_EXISTS" C-m && sleep $time;

	# On window 0, select pane 2, run Python and then send the enter key
	tmux select-pane -t 2 && tmux send-keys " $PYTHON_ENV_VERSION $COMMBASE_APP_DIR/bundles/built-in/broker/vu-meter/vu_meter.py" C-m;

	# Pane 3
	# On window 0, select pane 3, activate the conda environment if it exists,
	# send the enter key, and sleep.
	tmux select-pane -t 3 && tmux send-keys " conda activate $CONDA_ENV_NAME_IF_EXISTS" C-m && sleep $time;

	# On window 0, select pane 3, run alsamixer, send the enter key, and sleep
	tmux select-pane -t 3 && tmux send-keys " alsamixer --view all" C-m;

	# Pane 4
	# On window 0, select pane 4, activate the conda environment if it exists,
	# send the enter key, and sleep.
	tmux select-pane -t 4 && tmux send-keys " conda activate $CONDA_ENV_NAME_IF_EXISTS" C-m && sleep $time;

	# On window 0, select pane 4, cd the directory commbase, clear, send the enter
	# key, and sleep.
	tmux select-pane -t 4 && tmux send-keys " cd $COMMBASE_APP_DIR ; clear" C-m;

	# In this section, activate/deactivate or add custom extra windows

	if [ "$TMUX_EXTRA_WINDOWS_ON" = "True" ]; then
		if [ "$TMUX_EXTRA_WINDOW_TIMER_ON" = "True" ]; then
			# Window 1	
			# Auto-create a new window 1 for a countdown timer of 25 mins and start it
			tmux new-window -t Commbase-0:2 -n "Timer" && tmux send-keys " conda activate $CONDA_ENV_NAME_IF_EXISTS ; clear" C-m && sleep $time;
			tmux select-window -t 2 && tmux send-keys " bash $COMMBASE_APP_DIR/src/default/broker/skill_scripts/bash/t/timers/skill_script_set_a_timer_of_1_to_129_minutes/skill_script_set_a_timer_of_1_to_129_minutes -m 25" C-m;
		fi

		if [ "$TMUX_EXTRA_WINDOW_SERVER1_ON" = "True" ];then
			# Window 2
			# Auto-create a new window 2 for a ssh connection to a server 1
			tmux new-window -t Commbase-0:3 -n "Server 1" && tmux send-keys " conda activate $CONDA_ENV_NAME_IF_EXISTS ; clear" C-m && sleep $time;
		fi

		if [ "$TMUX_EXTRA_WINDOW_SERVER2_ON" = "True" ];then
			# Window 3
			# Auto-create a new window 3 for a ssh connection to a server 1
			tmux new-window -t Commbase-0:4 -n "Server 2" && tmux send-keys " conda activate $CONDA_ENV_NAME_IF_EXISTS ; clear" C-m && sleep $time;
		fi

  	if [ "$TMUX_EXTRA_WINDOW_FILES1_ON" = "True" ]; then
			# Window 4
			# Auto-create a new window 4 for a directory/file manager or text editor
			tmux new-window -t Commbase-0:5 -n "Files 1" && tmux send-keys " conda activate $CONDA_ENV_NAME_IF_EXISTS ; clear" C-m && sleep $time;
			#tmux select-window -t 2 && tmux send-keys "nnn" C-m
		fi
	fi

	# Focus the cursor in window 0, pane 4, replace hostname and host IP address,
	# values in the env file every IP_ADDRESS_UPDATE_FREQUENCY_IN_SECS, send the while to
	# the background, and then clean the pane prompt.
	tmux select-window -t 1 && tmux select-pane -t 4 && tmux send-keys " while true; do sed -i 's/^HOSTNAME=.*/HOSTNAME=$NEW_HOST_NAME/' $ENV_FILE; sed -i 's/^HOST_IP_ADDRESS=.*/HOST_IP_ADDRESS=$NEW_HOST_IP_ADDRESS/' $ENV_FILE; sleep $IP_ADDRESS_UPDATE_FREQUENCY_IN_SECS; done &; clear" C-m;

	# Clean up the command line of Window 0, pane 4
	tmux select-window -t 1 && tmux select-pane -t 4 && tmux send-keys " clear" C-m;

	# Enter the Commbase session
	tmux attach-session -t Commbase-0;

	exit 99
}
