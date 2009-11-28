# DataMatrix.Net

# DataMatrix.Net - .net library for decoding DataMatrix codes.
# Copyright (C) 2009 Michael Faschinger

# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public
# License as published by the Free Software Foundation; either
# version 3.0 of the License, or (at your option) any later version.

# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.

# You should have received a copy of the GNU General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

# Contact: Michael Faschinger - michfasch@gmx.at

if($args.Length.equals(0) -or $args[0].equals("-?") -or $args[0].equals("-H") -or $args[0].equals("-h"))
{
    "Please provide the current version of DataMatrix.net as an argument to the script!"
    return
}
$version = $args[0]

$binFolderName = "DataMatrixNet-bin-" + $version
$toolsFolderName = "DataMatrixNet-bintools-" + $version
$srcFolderName = "DataMatrixNet-src-" + $version

if(!(Test-Path $binFolderName))
{
    "Generating output folder " + $binFolderName
    New-Item $binFolderName -type directory | out-null
}
else
{
    "Clearing output folder " + $binFolderName
    Remove-Item ($binFolderName + "\*") -Recurse
}

if(!(Test-Path $toolsFolderName))
{
    "Generating output folder " + $toolsFolderName
    New-Item $toolsFolderName -type directory | out-null
}
else
{
    "Clearing output folder " + $toolsFolderName
    Remove-Item ($toolsFolderName + "\*") -Recurse
}

if(!(Test-Path $srcFolderName))
{
    "Generating output folder " + $srcFolderName
    New-Item $srcFolderName -type directory | out-null
}
else
{
    "Clearing output folder " + $srcFolderName
    Remove-Item ($srcFolderName + "\*") -Recurse
}

"Filling bin-folder"
Copy-Item ..\DataMatrix.net\bin\Debug\DataMatrix.net.dll $binFolderName
Copy-Item ..\DataMatrix.net\gpl.txt $binFolderName

"Filling tools-folder"
Copy-Item ..\DataMatrix.net\bin\Debug\DataMatrix.net.dll $toolsFolderName
Copy-Item ..\CodePdfCreator\bin\Debug\CodePdfCreator.exe $toolsFolderName
Copy-Item ..\CodePdfCreator\bin\Debug\itextsharp.dll $toolsFolderName
Copy-Item ..\DataMatrixTest\bin\Debug\DmtxDecodeTest.exe $toolsFolderName
Copy-Item ..\DataMatrix.net\gpl.txt $toolsFolderName

"Filling source-folder"
New-Item ($srcFolderName + "\DataMatrix.net") -type Directory | out-null
Copy-Item ..\DataMatrix.net.sln $srcFolderName
Copy-Item ..\DataMatrix.net\*.cs ($srcFolderName + "\DataMatrix.net")
Copy-Item ..\DataMatrix.net\DataMatrix.net.csproj ($srcFolderName + "\DataMatrix.net")
Copy-Item ..\DataMatrix.net\*.txt ($srcFolderName + "\DataMatrix.net")
New-Item ($srcFolderName + "\DataMatrix.net\Properties") -type Directory | out-null
Copy-Item ..\DataMatrix.net\Properties\AssemblyInfo.cs ($srcFolderName + "\DataMatrix.net\Properties")

New-Item ($srcFolderName + "\DataMatrixTest") -type Directory | out-null
Copy-Item ..\DataMatrixTest\Program.cs ($srcFolderName + "\DataMatrixTest\")
Copy-Item ..\DataMatrixTest\DataMatrixTest.csproj ($srcFolderName + "\DataMatrixTest\")
New-Item ($srcFolderName + "\DataMatrixTest\Properties") -type Directory | out-null
Copy-Item ..\DataMatrixTest\Properties\AssemblyInfo.cs ($srcFolderName + "\DataMatrixTest\Properties\")

New-Item ($srcFolderName + "\CodePdfCreator") -type Directory | out-null
Copy-Item ..\CodePdfCreator\*.cs ($srcFolderName + "\CodePdfCreator") 
Copy-Item ..\CodePdfCreator\CodePdfCreator.csproj ($srcFolderName + "\CodePdfCreator") 
Copy-Item ..\CodePdfCreator\MainForm.resx ($srcFolderName + "\CodePdfCreator") 
New-Item ($srcFolderName + "\CodePdfCreator\Properties") -type Directory | out-null
Copy-Item ..\CodePdfCreator\Properties\AssemblyInfo.cs ($srcFolderName + "\CodePdfCreator\Properties\")
Copy-Item ..\CodePdfCreator\Properties\Resources.Designer.cs ($srcFolderName + "\CodePdfCreator\Properties\")
Copy-Item ..\CodePdfCreator\Properties\Resources.resx ($srcFolderName + "\CodePdfCreator\Properties\")
Copy-Item ..\CodePdfCreator\Properties\Settings.settings ($srcFolderName + "\CodePdfCreator\Properties\")
Copy-Item ..\CodePdfCreator\Properties\Settings.Designer.cs ($srcFolderName + "\CodePdfCreator\Properties\")
New-Item ($srcFolderName + "\CodePdfCreator\binaries") -type Directory | out-null
Copy-Item ..\CodePdfCreator\binaries\itextsharp.dll ($srcFolderName + "\CodePdfCreator\binaries\")

"Output folder generation complete"

$currentPath = Get-Location
$currentPath = $currentPath.Path + "\"
$sharpZipLibPath = $currentPath + "ICSharpCode.SharpZipLib.dll"

[void] [System.Reflection.Assembly]::LoadFrom($sharpZipLibPath)
$zip = new-object ICSharpCode.SharpZipLib.Zip.FastZip

"Creating zip files"
$zip.CreateZip($currentPath + $binFolderName + ".zip", $currentPath + $binFolderName, $true, "")
$zip.CreateZip($currentPath + $toolsFolderName + ".zip", $currentPath + $toolsFolderName, $true, "")
$zip.CreateZip($currentPath + $srcFolderName + ".zip", $currentPath + $srcFolderName, $true, "")
"Created all zip files, ready to upload!"
