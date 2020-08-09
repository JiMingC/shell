#!/bin/bash
time=$(date "+%m-%d")
#echo $time

var=$1
mnt="/mnt/nfsroot/jiming.cai"
cur_path=$(pwd)

#current project name
cur_pro=${cur_path:24:10}
cur_pro=${cur_pro%/*}

#current pro subdir
subpath=${cur_path:24}
subpath=${subpath#*/}

#patch_name
patch_name=${cur_path#*jiming.cai/}
patch_name=$time-${patch_name//\//-}
#echo $patch_name
#echo $subpath $cur_pro

#if argv is null
if [ -z $1 ] ;then
	cd $mnt
	ls
elif [ $var = "help" ] ;then
	echo "help"
else
	#check weather stay in a project
	if [[ $cur_pro != "aosp" ]] && 
		[[ $cur_pro != "tvbase" ]] && 
		[[ $cur_pro != "tcl" ]] && 
		[[ $cur_pro != "cvte" ]] &&
		[[ $cur_pro != "featlist" ]] &&
		[[ $cur_pro != "new_sky" ]] &&
		[[ $cur_pro != "skyworth" ]] &&
		[[ $cur_pro != "skyworth_server" ]] &&
		[[ $cur_pro != "fae" ]];then
		echo "not in a project dir"
	else
		if [ $cur_pro = "cvte" ] ;then
			cur_pro="cvte/android"
		fi

		if [ $cur_pro = "aosp" ] ;then
			dts="common/arch/arm/boot/dts/amlogic"
		else
			dts="common/customer/arch/arm/boot/dts"
		fi
		#echo $cur_pro
		
		#switch argv to select shell
		case $var in
			#######################################################################
			#cd freq dir
			vdin) cd /mnt/nfsroot/jiming.cai/$cur_pro/common/drivers/amlogic/media/vin/tvin/vdin;;
			auge) cd /mnt/nfsroot/jiming.cai/$cur_pro/common/sound/soc/amlogic/auge ;;
			fw) cd /mnt/nfsroot/jiming.cai/$cur_pro/vendor/amlogic/common/frameworks ;;
			sys) cd /mnt/nfsroot/jiming.cai/$cur_pro/vendor/amlogic/common/frameworks/services/systemcontrol;;
			tv) cd /mnt/nfsroot/jiming.cai/$cur_pro/vendor/amlogic/common/tv;;
			dts) cd /mnt/nfsroot/jiming.cai/$cur_pro/$dts;;
			hal) cd /mnt/nfsroot/jiming.cai/$cur_pro/hardware/amlogic/audio/audio_hal;;
			out) cd /mnt/nfsroot/jiming.cai/$cur_pro/out/target/product/;;
			vdin) cd /mnt/nfsroot/jiming.cai/$cur_pro/common/drivers/amlogic/media/vin/tvin/vdin;;
			libtv) cd /mnt/nfsroot/jiming.cai/$cur_pro/vendor/amlogic/common/tv/tvserver/libtv;;
			hwc) cd /mnt/nfsroot/jiming.cai/$cur_pro/hardware/amlogic/hwcomposer;;
			pro) cd /mnt/nfsroot/jiming.cai/$cur_pro/;;
			ub) cd /mnt/nfsroot/jiming.cai/$cur_pro/bootloader/uboot-repo;;
			libtv) cd /mnt/nfsroot/jiming.cai/$cur_pro/vendor/amlogic/common/tv/tvserver/libtv;;
			skytv) cd /mnt/nfsroot/jiming.cai/$cur_pro/vendor/amlogic/tv/skyhdi/driverBase/hal3.0/skyhal/platform/amlogic/tv;;
            ##for skyworth
            skyhal) cd /mnt/nfsroot/jiming.cai/$cur_pro/vendor/skyworth/driverBase/hal3.0/skyhal/platform/amlogic/tv;;
            skycat) cd /mnt/nfsroot/jiming.cai/$cur_pro/vendor/amlogic/apps/TvCastleRelease;;
            #######################################################################
			#change pro_dir
			tvbase) cd $mnt/$var/$subpath;;
			aosp) cd $mnt/$var/$subpath;;
			tcl) cd $mnt/$var/$subpath;;
			cvte) cd $mnt/$var/android/$subpath;;
			fae) cd $mnt/$var/$subpath;;
			new_sky) cd $mnt/$var/$subpath;;
            skyworth) cd $mnt/$var/$subpath;;
			#######################################################################
			#make
			make)
				if [ $2 ] ;then
					case $2 in
						bootimage) cd $mnt/$cur_pro
							make bootimage -j8
							cd -;;
						dtbimage) cd $mnt/$cur_pro
							make dtbimage -j8
							cd -;;
						otapackage) cd $mnt/$cur_pro
							make otapackage -j8
							cd -;;
					esac
				fi
				;;
			#######################################################################
			#diff  for git diff patch
			diff)
				patch_name=$mnt/bake_patch/$cur_pro/$patch_name
				if [ $2 ] ; then
					git diff $2 > $patch_name-${2%.*}.diff
					echo $patch_name-${2%.*}.diff
				else
					git diff > ${patch_name}.patch
					echo ${patch_name}.patch
				fi
				;;
			#######################################################################
			#cp		for cp file to other pro path
			cp)
				N=0
				for i in "$@"
				do
					((N++))
					#echo $N
					if [ $N -gt 1 ] && [ $N -lt $# ]
					then
						dst_path=/mnt/nfsroot/jiming.cai/${@: -1}/$subpath
						cp $i $dst_path
						echo "$i has been cp to $dst_path"
						#echo $i
					fi
				done
				#echo "${@: -1}" #the last parameter
				#dst_path=/mnt/nfsroot/jiming.cai/${@: -1}/$subpath
				#echo $dst_path
				#cp $2 $dst_path
				#echo "$2 has been cp to $dst_path"
				;;
			#######################################################################
			#mv file to /mnt/nfsroot/jiming.cai/tmp
			mv)
				mv $2 /mnt/nfsroot/jiming.cai/tmp/
			;;
			help)
				echo "cjm help";;
		esac
	fi
fi
#!
