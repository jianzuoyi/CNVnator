# Source this script to set up the ROOT build that this script is part of.
#
# Conveniently an alias like this can be defined in .bashrc:
#   alias thisroot=". bin/thisroot.sh"
#
# This script if for the bash like shells, see thisroot.csh for csh like shells.
#
# Author: Fons Rademakers, 18/8/2006

drop_from_path()
{
   # Assert that we got enough arguments
   if test $# -ne 2 ; then
      echo "drop_from_path: needs 2 arguments"
      return 1
   fi

   p=$1
   drop=$2

   newpath=`echo $p | sed -e "s;:${drop}:;:;g" \
                          -e "s;:${drop};;g"   \
                          -e "s;${drop}:;;g"   \
                          -e "s;${drop};;g"`
}

if [ -n "${ROOTSYS}" ] ; then
   old_rootsys=${ROOTSYS}
fi

if [ "x${BASH_ARGV[0]}" = "x" ]; then
    if [ -f bin/thisroot.sh ]; then
        ROOTSYS="$PWD"; export ROOTSYS
    elif [ -f ./thisroot.sh ]; then
        ROOTSYS=$(cd ..  > /dev/null; pwd); export ROOTSYS
    else
        echo ERROR: must "cd where/root/is" before calling ". bin/thisroot.sh" for this version of bash!
        ROOTSYS=; export ROOTSYS
        return 1
    fi
    ROOTSYS="$PWD"; export ROOTSYS
else
    # get param to "."
    thisroot=$(dirname ${BASH_ARGV[0]})
    ROOTSYS=$(cd ${thisroot}/.. > /dev/null;pwd); export ROOTSYS
fi

if [ -n "${old_rootsys}" ] ; then
   if [ -n "${PATH}" ]; then
      drop_from_path "$PATH" ${old_rootsys}/bin
      PATH=$newpath
   fi
   if [ -n "${LD_LIBRARY_PATH}" ]; then
      drop_from_path $LD_LIBRARY_PATH ${old_rootsys}/lib
      LD_LIBRARY_PATH=$newpath
   fi
   if [ -n "${DYLD_LIBRARY_PATH}" ]; then
      drop_from_path $DYLD_LIBRARY_PATH ${old_rootsys}/lib
      DYLD_LIBRARY_PATH=$newpath
   fi
   if [ -n "${SHLIB_PATH}" ]; then
      drop_from_path $SHLIB_PATH ${old_rootsys}/lib
      SHLIB_PATH=$newpath
   fi
   if [ -n "${LIBPATH}" ]; then
      drop_from_path $LIBPATH ${old_rootsys}/lib
      LIBPATH=$newpath
   fi
   if [ -n "${PYTHONPATH}" ]; then
      drop_from_path $PYTHONPATH ${old_rootsys}/lib
      PYTHONPATH=$newpath
   fi
   if [ -n "${MANPATH}" ]; then
      drop_from_path $MANPATH ${old_rootsys}/man
      MANPATH=$newpath
   fi
fi

if [ -z "${MANPATH}" ]; then
   # Grab the default man path before setting the path to avoid duplicates 
   if `which manpath > /dev/null 2>&1` ; then
      default_manpath=`manpath`
   else
      default_manpath=`man -w 2> /dev/null`
   fi
fi

if [ -z "${PATH}" ]; then
   PATH=$ROOTSYS/bin; export PATH
else
   PATH=$ROOTSYS/bin:$PATH; export PATH
fi

if [ -z "${LD_LIBRARY_PATH}" ]; then
   LD_LIBRARY_PATH=$ROOTSYS/lib; export LD_LIBRARY_PATH       # Linux, ELF HP-UX
else
   LD_LIBRARY_PATH=$ROOTSYS/lib:$LD_LIBRARY_PATH; export LD_LIBRARY_PATH
fi

if [ -z "${DYLD_LIBRARY_PATH}" ]; then
   DYLD_LIBRARY_PATH=$ROOTSYS/lib; export DYLD_LIBRARY_PATH   # Mac OS X
else
   DYLD_LIBRARY_PATH=$ROOTSYS/lib:$DYLD_LIBRARY_PATH; export DYLD_LIBRARY_PATH
fi

if [ -z "${SHLIB_PATH}" ]; then
   SHLIB_PATH=$ROOTSYS/lib; export SHLIB_PATH                 # legacy HP-UX
else
   SHLIB_PATH=$ROOTSYS/lib:$SHLIB_PATH; export SHLIB_PATH
fi

if [ -z "${LIBPATH}" ]; then
   LIBPATH=$ROOTSYS/lib; export LIBPATH                       # AIX
else
   LIBPATH=$ROOTSYS/lib:$LIBPATH; export LIBPATH
fi

if [ -z "${PYTHONPATH}" ]; then
   PYTHONPATH=$ROOTSYS/lib; export PYTHONPATH
else
   PYTHONPATH=$ROOTSYS/lib:$PYTHONPATH; export PYTHONPATH
fi

if [ -z "${MANPATH}" ]; then
   MANPATH=`dirname $ROOTSYS/man`:${default_manpath}; export MANPATH
else
   MANPATH=`dirname $ROOTSYS/man`:$MANPATH; export MANPATH
fi

if [ "x`root-config --arch | grep -v win32gcc | grep -i win32`" != "x" ]; then
  ROOTSYS="`cygpath -w $ROOTSYS`"
fi

if [ "x`root-config --arch | grep -v win64gcc | grep -i win64`" != "x" ]; then
  ROOTSYS="`cygpath -w $ROOTSYS`"
fi

unset old_rootsys
unset thisroot

#export LD_LIBRARY_PATH=/opt/bio/speedseq/src/root/lib:/opt/lib64:/opt/lib:/usr/local/lib64:/opt/gridengine/lib/linux-x64:/opt/openmpi/lib:/opt/python/lib:/opt/bio/glibc/lib:/opt/bio/glibc/lib
#export LD_LIBRARY_PATH=/its1/GB_BT2/jianzuoyi/biosoft/speedseq/src/root/lib:/opt/bio/local/lib:/opt/bio/local/lib64::/opt/sge/lib/lx-amd64
export LD_LIBRARY_PATH=/its1/GB_BT2/jianzuoyi/biosoft/CNVnator/CNVnator_v0.3.3/src/root/lib:/opt/bio/local/lib:/opt/bio/local/lib64::/opt/sge/lib/lx-amd64
