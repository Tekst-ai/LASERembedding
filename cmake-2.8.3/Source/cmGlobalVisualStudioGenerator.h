/*============================================================================
  CMake - Cross Platform Makefile Generator
  Copyright 2000-2009 Kitware, Inc., Insight Software Consortium

  Distributed under the OSI-approved BSD License (the "License");
  see accompanying file Copyright.txt for details.

  This software is distributed WITHOUT ANY WARRANTY; without even the
  implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
  See the License for more information.
============================================================================*/
#ifndef cmGlobalVisualStudioGenerator_h
#define cmGlobalVisualStudioGenerator_h

#include "cmGlobalGenerator.h"

/** \class cmGlobalVisualStudioGenerator
 * \brief Base class for global Visual Studio generators.
 *
 * cmGlobalVisualStudioGenerator provides functionality common to all
 * global Visual Studio generators.
 */
class cmGlobalVisualStudioGenerator : public cmGlobalGenerator
{
public:
  cmGlobalVisualStudioGenerator();
  virtual ~cmGlobalVisualStudioGenerator();

  /**
   * Basic generate implementation for all VS generators.
   */
  virtual void Generate();

  /**
   * Configure CMake's Visual Studio macros file into the user's Visual
   * Studio macros directory.
   */
  virtual void ConfigureCMakeVisualStudioMacros();

  /**
   * Where does this version of Visual Studio look for macros for the
   * current user? Returns the empty string if this version of Visual
   * Studio does not implement support for VB macros.
   */
  virtual std::string GetUserMacrosDirectory();

  /**
   * What is the reg key path to "vsmacros" for this version of Visual
   * Studio?
   */
  virtual std::string GetUserMacrosRegKeyBase();

  enum MacroName {MacroReload, MacroStop};

  /**
   * Call the ReloadProjects macro if necessary based on
   * GetFilesReplacedDuringGenerate results.
   */
  virtual void CallVisualStudioMacro(MacroName m,
                                     const char* vsSolutionFile = 0);
  
  // return true if target is fortran only
  bool TargetIsFortranOnly(cmTarget& t);

  /** Get the top-level registry key for this VS version.  */
  std::string GetRegistryBase();

  /** Return true if the generated build tree may contain multiple builds.
      i.e. "Can I build Debug and Release in the same tree?" */
  virtual bool IsMultiConfig() { return true; }

  struct TargetCompare
  {
    bool operator()(cmTarget const* l, cmTarget const* r) const;
  };
  class OrderedTargetDependSet: public std::multiset<cmTarget*, TargetCompare>
  {
  public:
    OrderedTargetDependSet(cmGlobalGenerator::TargetDependSet const&);
  };

protected:
  // Does this VS version link targets to each other if there are
  // dependencies in the SLN file?  This was done for VS versions
  // below 8.
  virtual bool VSLinksDependencies() const { return true; }

  virtual const char* GetIDEVersion() = 0;

  virtual bool ComputeTargetDepends();
  class VSDependSet: public std::set<cmStdString> {};
  class VSDependMap: public std::map<cmTarget*, VSDependSet> {};
  VSDependMap VSTargetDepends;
  void ComputeVSTargetDepends(cmTarget&);

  bool CheckTargetLinks(cmTarget& target, const char* name);
  std::string GetUtilityForTarget(cmTarget& target, const char*);
  virtual std::string WriteUtilityDepend(cmTarget*) = 0;
  std::string GetUtilityDepend(cmTarget* target);
  typedef std::map<cmTarget*, cmStdString> UtilityDependsMap;
  UtilityDependsMap UtilityDepends;
};

#endif
