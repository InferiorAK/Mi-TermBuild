## Facebook : fb.com/InferiorAK
## Github   : github.com/InferiorAK
## Twitter  : twitter.com/@InferiorAK
## Youtube  : youtube.com/@InferiorAK

# symbol
suc(){
	printf " ${GREEN}$1${WHITE}$2${GREEN}$3\e[0m "
}
fail(){
	printf " ${RED}$1${WHITE}$2${RED}$3\e[0m "
}
invalid(){
	fail [ x ] ; echo -e "${bgRED} Invalid Option \e[0m\n"
	sleep 1
}

# main_functions
colors(){
	clear
	banner
	echo -e "
${LIGHT_MAGENTA}[${BLUE}*${LIGHT_MAGENTA}] ${bLIGHT_MAGENTA}Theme List:\e[0m

    ${LIGHT_MAGENTA}[${BLUE}000${LIGHT_MAGENTA}] ${YELLOW}Back
    ${LIGHT_MAGENTA}[${BLUE}404${LIGHT_MAGENTA}] ${YELLOW}Reset-Theme

 ${GREEN}[${LIGHT_MAGENTA}#${GREEN}] ${LIGHT_MAGENTA}Dark: \e[0m"
	i=1
	dark=($(ls $dark_COL))
	for color in "${dark[@]}" ; do
		col=$(echo "${color}" | sed -e "s/.properties//g" -e "s/base16-//g")
		printf "    ${LIGHT_MAGENTA}[${BLUE}%02d${LIGHT_MAGENTA}] ${GREEN}${col^}\n" "$i"
		(( i++ ))
	done
	echo -e "
 ${GREEN}[${LIGHT_MAGENTA}#${GREEN}] ${BLUE}Light: \e[0m"
	light=($(ls $light_COL))
	for color in "${light[@]}" ; do
		col=$(echo "${color}" | sed -e "s/.properties//g" -e "s/base16-//g")
		printf "    ${LIGHT_MAGENTA}[${BLUE}%02d${LIGHT_MAGENTA}] ${GREEN}${col^}\n" "$i"
		(( i++ ))
	done
	echo -e ""
	suc [ \~ ] ; read -p "Choose Theme: " opt
	if [[ $opt =~ ^[0-9]+$ ]]; then
		optn=$((10#$opt))
		if [ $optn -eq 0 ] ; then
			menu
		elif [[ $optn -eq 404 ]] ; then
			rm -rf res/.active_color
			rm -rf "$TERMUX_DIR/colors.properties"
			reload "Theme Reset Done"
		elif [[ $optn -lt $i && $optn -gt 0 ]] ; then
			if [ $optn -lt 48 ] ; then
				sel=${dark[$opt-1]}
				sesh=$(echo "${sel%.*}" | sed -e "s/base16-//g")
				printf "${GREEN} [${LIGHT_MAGENTA}+${GREEN}]" ; echo -e " ${sesh^} Selected" && echo "${sesh^}" > res/.active_theme
				cp "$dark_COL/${dark[$optn-1]}"  "$TERMUX_DIR/colors.properties"
				reload "Theme Changed Successfully!"
			else
				sel=${light[$optn-48]}
				sesh=$(echo "${sel%.*}" | sed -e "s/base16-//g")
				printf "${GREEN} [${LIGHT_MAGENTA}+${GREEN}]" ; echo -e " ${sesh^} Selected" && echo "${sesh^}" > res/.active_theme
				cp "$light_COL/${light[$optn-48]}"  "$TERMUX_DIR/colors.properties"
				reload "Theme Changed Successfully!"
			fi
		else
			fail [ x ] ; echo -e "${bgRED} Choose Between 1-$((i-1)) \e[0m\n"
			sleep 1
			colors
		fi
	else
		invalid
		colors
	fi
}

fonts(){
	clear
	banner
	echo -e "
${LIGHT_MAGENTA}[${BLUE}*${LIGHT_MAGENTA}] ${bLIGHT_MAGENTA}Font List:\e[0m

    ${LIGHT_MAGENTA}[${BLUE}000${LIGHT_MAGENTA}] ${YELLOW}Back\e[0m
    ${LIGHT_MAGENTA}[${BLUE}404${LIGHT_MAGENTA}] ${YELLOW}Reset-Font\e[0m
	"
	j=1
	fonts=($(ls $FONTS_DIR))
	for font in "${fonts[@]}" ; do
		fnt=$(echo "${font}" | sed -e "s/.ttf//g")
		printf "    ${LIGHT_MAGENTA}[${BLUE}%02d${LIGHT_MAGENTA}] ${GREEN}${fnt^}\n" "$j"
		(( j++ ))
	done
	echo -e ""
	suc [ \~ ] ; read -p "Choose Font: " opf
	if [[ $opf =~ ^[0-9]+$ ]]; then
		opfn=$((10#$opf))
		if [ $opfn -eq 0 ] ; then
			menu
		elif [ $opfn -eq 404 ] ; then
			rm -rf res/.active_font
			rm -rf "$TERMUX_DIR/font.ttf"
			reload "Font Reset Done"
		elif [[ $opfn -lt $j && $opfn -gt 0 ]] ; then
			sel=${fonts[$opfn-1]}
			sesh=${sel%.*}
			printf "${GREEN} [${LIGHT_MAGENTA}+${GREEN}]" ; echo -e " ${sesh^} Selected" && echo "${sesh^}" > res/.active_font
			cp "$FONTS_DIR/${fonts[$opfn-1]}"  "$TERMUX_DIR/font.ttf"
			reload "Font Changed Successfully!" 
		else
			fail [ x ] ; echo -e "${bgRED} Choose Between 1-$((j-1)) \e[0m\n"
			sleep 1
			fonts
		fi
	else
		invalid
		fonts
	fi
}

s_keys(){
	clear
	banner
	echo -e "
${LIGHT_MAGENTA}[${BLUE}*${LIGHT_MAGENTA}] ${bLIGHT_MAGENTA}Shortcut-Key List:\e[0m

    ${LIGHT_MAGENTA}[${BLUE}000${LIGHT_MAGENTA}] ${YELLOW}Back\e[0m
    ${LIGHT_MAGENTA}[${BLUE}404${LIGHT_MAGENTA}] ${YELLOW}Reset-Keys\e[0m

    ${LIGHT_MAGENTA}[${BLUE}01${LIGHT_MAGENTA}] ${GREEN}clear,exit,python2,nano,,,pkg install
         python,#,pip install,php,bash,/sdcard,=
         ESC,/,-,HOME,↑,END,PGUP
         TAB,CTRL,ALT,←,↓,→,PGDN
    ${LIGHT_MAGENTA}[${BLUE}02${LIGHT_MAGENTA}] ${GREEN}CTRL,ALT,git clone,https://,↑,BKSP
         python,python2,bash,←,↓,→
    ${LIGHT_MAGENTA}[${BLUE}03${LIGHT_MAGENTA}] ${GREEN}F1,F2,F3,F4,F5,F6,F7
         ESC,/,-,HOME,↑,END,PGUP
         TAB,CTRL,ALT,LEFT,DOWN,RIGHT,PGDN
    ${LIGHT_MAGENTA}[${BLUE}04${LIGHT_MAGENTA}] ${GREEN}ESC,/,-,HOME,↑,END,PGUP
         TAB,CTRL,ALT,←,↓,→,PGDN
    ${LIGHT_MAGENTA}[${BLUE}05${LIGHT_MAGENTA}] ${GREEN}ESC,TAB,CTRL,ALT,{key: '-', popup: '|'},↓,↑
	"
	declare -gA keys=(
		[key1]="extra-keys = [['clear','exit','python2 ','nano ','(',')','pkg install '],['python ','#','pip install ','php ','bash ','/sdcard','='],['ESC','/','-','HOME','UP','END','PGUP'],['TAB','CTRL','ALT','LEFT','DOWN','RIGHT','PGDN']]"
		[key2]="extra-keys = [['CTRL','ALT','git clone ','https://','UP','BKSP'],['python ','python2 ','bash ','LEFT','DOWN','RIGHT']]"
		[key3]="extra-keys = [['F1','F2','F3','F4','F5','F6','F7'],['ESC','/','-','HOME','UP','END','PGUP'],['TAB','CTRL','ALT','LEFT','DOWN','RIGHT','PGDN']]"
		[key4]="extra-keys = [['ESC','/','-','HOME','UP','END','PGUP'],['TAB','CTRL','ALT','LEFT','DOWN','RIGHT','PGDN']]"
		[key5]="extra-keys = [[ESC, TAB, CTRL, ALT, {key: '-', popup: '|'}, DOWN, UP]]"
	)

	suc [ \~ ] ; read -p "Choose Keys: " opk
	if [[ $opk =~ ^[0-9]+$ ]]; then
		opkn=$((10#$opk))
		if [ $opkn -eq 0 ] ; then
			menu
		elif [ $opkn -eq 404 ] ; then
			rm -rf res/.active_key
			reset_keys
			reload "Extra-Keys Deleted Successfully!"
		elif [[ $opkn -le 5 && $opkn -gt 0 ]] ; then
			if [ -e "$TERMUX_DIR/termux.properties" ] ; then
				reset_keys
			else
				:
			fi

			if [ $opkn -eq 1 ] ; then
				echo "${keys[key1]}" >> "$TERMUX_DIR/termux.properties"
				echo "Num-${opkn}" > res/.active_key
				reload "Shortcut-Keys Added Successfully!" 
			elif [ $opkn -eq 2 ] ; then
				echo "${keys[key2]}" >> "$TERMUX_DIR/termux.properties"
				echo "Num-${opkn}" > res/.active_key
				reload "Shortcut-Keys Added Successfully!"
			elif [ $opkn -eq 3 ] ; then
				echo "${keys[key3]}" >> "$TERMUX_DIR/termux.properties"
				echo "Num-${opkn}" > res/.active_key
				reload "Shortcut-Keys Added Successfully!" 
			elif [ $opkn -eq 4 ] ; then
				echo "${keys[key4]}" >> "$TERMUX_DIR/termux.properties"
				echo "Num-${opkn}" > res/.active_key
				reload "Shortcut-Keys Added Successfully!"
			elif [ $opkn -eq 5 ] ; then
				echo "${keys[key5]}" >> "$TERMUX_DIR/termux.properties"
				echo "Num-${opkn}" > res/.active_key
				reload "Shortcut-Keys Added Successfully!"
			else
				s_keys
			fi
		else
			fail [ x ] ; echo -e "${bgRED} Choose Between 0-5 \e[0m\n"
			sleep 1
			s_keys
		fi
	else
		invalid
		s_keys
	fi
}

reset_keys(){
	for key in "${keys[@]}" ; do
		k=$(echo -n $key | sed -e "s/\[/\\\[/g")
		sed -i "s!$k!!g" "$TERMUX_DIR/termux.properties"
	done
}

reload(){
	am broadcast --user 0 -a com.termux.app.reload_style com.termux > /dev/null 2>&1
	printf "${GREEN} [${LIGHT_MAGENTA}+${GREEN}]" ; echo -e " "$1
	sleep 1.5
	menu
}

# main menu
menu(){
	if [ -e res/.active_theme ] ; then
		active_theme=`cat res/.active_theme`
	else
		:
	fi
	if [ -e res/.active_font ] ; then
		active_font=`cat res/.active_font`
	else
		:
	fi
	if [ -e res/.active_key ] ; then
		active_key=`cat res/.active_key`
	else
		:
	fi

	clear
	banner
	echo -e "
 ${LIGHT_MAGENTA}[${BLUE}*${LIGHT_MAGENTA}] ${bLIGHT_MAGENTA}Items List:\e[0m

                            ${bGREEN}*online
	${LIGHT_MAGENTA}[${BLUE}01${LIGHT_MAGENTA}] ${YELLOW}Themes         ${GREEN}${active_theme}
	${LIGHT_MAGENTA}[${BLUE}02${LIGHT_MAGENTA}] ${YELLOW}Fonts          ${GREEN}${active_font}
	${LIGHT_MAGENTA}[${BLUE}03${LIGHT_MAGENTA}] ${YELLOW}Shortcut-Keys  ${GREEN}${active_key}
	${LIGHT_MAGENTA}[${BLUE}04${LIGHT_MAGENTA}] ${YELLOW}Reset All
	${LIGHT_MAGENTA}[${BLUE}05${LIGHT_MAGENTA}] ${YELLOW}Update Tool
	${LIGHT_MAGENTA}[${BLUE}06${LIGHT_MAGENTA}] ${YELLOW}Tutorial
	${LIGHT_MAGENTA}[${BLUE}00${LIGHT_MAGENTA}] ${YELLOW}Exit
	"
	suc [ \~ ] ; read -p "Choose Option: " opm

	if [ -d $TERMUX_DIR ] ; then
		:
	else
		mkdir $TERMUX_DIR > /dev/null 2>&1
	fi
	
	if [[ $opm =~ ^[0-9]+$ ]]; then
		opmn=$((10#$opm))
		if [ $opmn -eq 0 ] ; then
			echo ""
			suc [ + ] ; echo -e "${GREEN}Tool Exited\n"
			exit 0
		elif [ $opmn -eq 1 ] ; then
			colors
		elif [ $opmn -eq 2 ] ; then
			fonts
		elif [ $opmn -eq 3 ] ; then
			s_keys
		elif [ $opmn -eq 4 ] ; then
			rm -rf res/.* "$TERMUX_DIR/colors.properties" "$TERMUX_DIR/font.ttf" ; reset_keys
			reload "Reset Done Successfully!"
		elif [ $opmn -eq 5 ] ; then
			git pull origin > /dev/null 2>&1
			printf "\n"
			echo -e "${bGREEN} Tool Updated Sccessfully\n\e[0m"
			sleep 1.5 ; clear ; menu
		elif [ $opmn -eq 6 ] ; then
			xdg-open "https://youtu.be/fCLCT1qx9mc"
			menu
		else
			fail [ x ] ; echo -e "${bgRED} Wrong Input! \e[0m\n"
			sleep 1
			menu
		fi
	else
		invalid
		menu
	fi
}
