/* -*- C++ -*- */
/*************************************************************************
 * Copyright(c) 1995~2005  Masaharu Goto (root-cint@cern.ch)
 *
 * For the licensing terms see the file COPYING
 *
 ************************************************************************/

#ifdef __MAKECINT__

#pragma link off class allocator<char>;
#pragma link off class allocator<wchar_t>;
#pragma link off class basic_string<char,char_traits<char>,allocator<char> >;
#pragma link MACRO function char_traits<char>::assign(char_type*,size_t,const char_type);
#pragma link C++ nestedtypedef;
#endif
