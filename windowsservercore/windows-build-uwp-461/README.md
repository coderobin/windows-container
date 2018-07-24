### Notes on the Name

The naming of this is __misleading__. This is for building a Portable Library targetting UWP 10.0 + .NET 4.6.1. This won't build an UWP application.

### What's New:

#### 24/07/2018

* Now we fix the base image version rather than fetching the latest tag. The new tag format is _windowsservercoreversion\_msbuildversion_

* Adopting the Microsoft Official Docker Image Dockerfile styles https://github.com/Microsoft/dotnet-framework-docker. E.g. running ngen in Docker build; set paths to msbuild and nuget; removed [cmd] from Dockerfile, etc.

#### Contents:

1. Microsoft .NET Framework 4.6.1 Developer Pack  
  NDP461-DevPack-KB3105179-ENU.exe  
  Source: Microsoft

2. Microsoft Portable Library Multi-Targeting Pack  
  Product Version: 14.0.25123.00. Product Language: 1033  
  Source: extracted from Visual Studio 2015 Update 3 ISO

3. Microsoft Portable Library Multi-Targeting Pack Language Pack - enu  
  Product Version: 14.0.25420.01. Product Language: 1033  
  Source: as #2

4. Microsoft Build Tools 2017  
  Product Version: 15.7.180.x  
  Source: Microsoft

5. NuGet.exe 4.7.0  
  Source: NuGet.org


### Legacy

Apply to Docker Hub tag: 14.0.25123.0, 14.0.25420.1

#### 21/12/2016

* We now using microsoft/windowsservercore as base OS image, instead of TP5 era windowsservercore.

* Files are now aligned with Visual Studio 2015 Update 3

#### Contents:

1. Microsoft .NET Framework 4.6.1 Developer Pack  
  NDP461-DevPack-KB3105179-ENU.exe  
  Source: Microsoft

2. Microsoft Portable Library Multi-Targeting Pack  
  Product Version: 14.0.25123.00. Product Language: 1033  
  Source: extracted from Visual Studio 2015 Update 3 ISO

3. Microsoft Portable Library Multi-Targeting Pack Language Pack - enu  
  Product Version: 14.0.25420.01. Product Language: 1033  
  Source: as #2

4. Microsoft Build Tools 2015 Update 3  
  Product Version: 14.0.25420.1.  
  Source: Microsoft

5. MSBuild/NuGet Integration 14.0 (x86)  
  Product Version: 14.0.25420. Product Language: 1033  
  Source: as #2

6. NuGet.exe  
  Source: NuGet.org
