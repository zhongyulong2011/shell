#!/bin/bash
#print_format1
function printf_format1(){
        Separator=$1
        List1=$2
        List2=$3
        List3=$4
        List4=$5
        printf  "${Separator}%-12s${Separator}%12s${Separator}%8s${Separator}%8s${Separator}\n" "$List1"  "$List2" "$List3" "$List4"
}

Loadavg=`uptime |awk -F[\ \,] '{print  $(NF-2)}'`
Cpu_idle=`vmstat |awk 'NR==3{print $(NF-2)}'`
Mem_total=`free -m|awk 'NR==2{print $2}'`
Mem_used=`free -m|awk 'NR==3{print $3}'`
Mem_idle=`free |awk 'NR==3{sum=$3+$4;idle=$4/sum}END{print idle*100}'|cut -d. -f1`
Swap_total=`free -m|awk 'NR==4{print $2}'`
Swap_used=`free -m|awk 'NR==4{print $3}'`
Swap_idle=`free -m|awk 'NR==4{print $4/$2*100}'`
Disk_root_total=`df -h|grep -w /|awk '{print $2}'`
Disk_root_used=`df -h|grep -w /|awk '{print $3}'`
Disk_root_idle=`df -h|grep -w /|awk '{print 100-($5+0)}'`

echo
echo "............list info for server ............"
printf_format1 + ------------ ------------ -------- --------
printf_format1 \| Name Total Used Idle
printf_format1 + ------------ ------------ -------- --------
printf_format1 \| CPU ""  "$Loadavg" "${Cpu_idle}%"
printf_format1 \| Mem "${Mem_total}M" "${Mem_used}M" "${Mem_idle}%"
printf_format1 \| Swap "${Swap_total}M" "${Swap_used}M" "${Swap_idle}%"
printf_format1 \| \/ "${Disk_root_total}" "${Disk_root_used}" "${Disk_root_idle}%"
printf_format1 + ------------ ------------ -------- --------
#######################
