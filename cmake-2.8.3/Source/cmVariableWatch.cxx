/*============================================================================
  CMake - Cross Platform Makefile Generator
  Copyright 2000-2009 Kitware, Inc., Insight Software Consortium

  Distributed under the OSI-approved BSD License (the "License");
  see accompanying file Copyright.txt for details.

  This software is distributed WITHOUT ANY WARRANTY; without even the
  implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
  See the License for more information.
============================================================================*/
#include "cmVariableWatch.h"

static const char* const cmVariableWatchAccessStrings[] =
{
    "READ_ACCESS",
    "UNKNOWN_READ_ACCESS",
    "ALLOWED_UNKNOWN_READ_ACCESS",
    "MODIFIED_ACCESS",
    "REMOVED_ACCESS",
    "NO_ACCESS"
};

const char* cmVariableWatch::GetAccessAsString(int access_type)
{
  if ( access_type < 0 || access_type >= cmVariableWatch::NO_ACCESS )
    {
    return "NO_ACCESS";
    }
  return cmVariableWatchAccessStrings[access_type];
}

cmVariableWatch::cmVariableWatch()
{
}

cmVariableWatch::~cmVariableWatch()
{
}

void cmVariableWatch::AddWatch(const std::string& variable, 
                               WatchMethod method, void* client_data /*=0*/)
{
  cmVariableWatch::Pair p;
  p.Method = method;
  p.ClientData = client_data;
  cmVariableWatch::VectorOfPairs* vp = &this->WatchMap[variable];
  cmVariableWatch::VectorOfPairs::size_type cc;
  for ( cc = 0; cc < vp->size(); cc ++ )
    {
    cmVariableWatch::Pair* pair = &(*vp)[cc];
    if ( pair->Method == method )
      {
      (*vp)[cc] = p;
      return;
      }
    }
  vp->push_back(p);
}

void cmVariableWatch::RemoveWatch(const std::string& variable, 
                                  WatchMethod method)
{
  cmVariableWatch::VectorOfPairs* vp = &this->WatchMap[variable];
  cmVariableWatch::VectorOfPairs::iterator it;
  for ( it = vp->begin(); it != vp->end(); ++it )
    {
    if ( it->Method == method )
      {
      vp->erase(it);
      return;
      }
    }
}

void  cmVariableWatch::VariableAccessed(const std::string& variable, 
                                        int access_type,
                                        const char* newValue,
                                        const cmMakefile* mf) const
{
  cmVariableWatch::StringToVectorOfPairs::const_iterator mit = 
    this->WatchMap.find(variable);
  if ( mit  != this->WatchMap.end() )
    {
    const cmVariableWatch::VectorOfPairs* vp = &mit->second;
    cmVariableWatch::VectorOfPairs::const_iterator it;
    for ( it = vp->begin(); it != vp->end(); it ++ )
      {
      it->Method(variable, access_type, it->ClientData,
        newValue, mf);
      }
    }
}
