# path
$Env:Path = "C:\Program Files\mingw-w64\x86_64-5.1.0-posix-seh-rt_v4-rev0\mingw64\bin\;" + $Env:Path
$Env:Path = "C:\Program Files (x86)\ffmpeg\bin\;" + $Env:Path

#for application
Set-Alias vim 'C:\Program Files (x86)\vim\vim.exe'
Set-Alias gvim 'C:\Program Files (x86)\vim\gvim.exe'
Set-Alias python 'C:\Program Files (x86)\Python-3.4.3\python.exe'
Set-Alias youtube-dl 'C:\Program Files (x86)\youtube-dl\youtube-dl.exe'
Set-Alias processing-java 'C:\Program Files\processing-2.2.1\processing-java.exe'
Set-Alias TexStudio 'C:\Program Files (x86)\TeXstudio\texstudio.exe'
Set-Alias foobar2000 'C:\Program Files (x86)\foobar2000\foobar2000.exe'
Set-Alias Chrome 'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe'
Set-Alias scilab 'C:\Program Files\scilab-5.5.1\bin\WScilex.exe'
Set-Alias VirtualBox 'C:\Program Files\Oracle\VirtualBox\VirtualBox.exe'
Set-Alias Inkscape 'C:\Program Files (x86)\Inkscape\inkscape.exe'
Set-Alias Mingw 'C:\MinGW\libexec\mingw-get\guimain.exe'
Set-Alias Eclipse 'C:\eclipse\eclipse.exe'
Set-Alias CCleaner 'C:\Program Files\CCleaner\CCleaner64.exe'
Set-Alias oo-draw 'C:\Program Files (x86)\OpenOffice.org 3\program\sdraw.exe'
Set-Alias oo 'C:\Program Files (x86)\OpenOffice.org 3\program\soffice.exe'
Set-Alias ms-excel 'C:\Program Files\Microsoft Office 15\root\office15\EXCEL.EXE'
Set-Alias ms-word 'C:\Program Files\Microsoft Office 15\root\office15\WINWORD.EXE'
Set-Alias ms-powerpoint 'C:\Program Files\Microsoft Office 15\root\office15\POWERPNT.EXE'
Set-Alias Snipping-Tool 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\Snipping Tool.lnk'
Set-Alias teraterm 'C:\Program Files (x86)\teraterm\ttermpro.exe'
Set-Alias VNCviewer 'C:\Users\Takuya\Downloads\VNC-Viewer-5.2.2-Windows-64bit.exe'
Set-Alias visualstudio 'C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE\devenv.exe'
Set-Alias fusion360 'C:\Users\Takuya\AppData\Local\Autodesk\webdeploy\production\f0587cd38964118f8005389472d4fd4f3fd646f9\Fusion360.exe'
Set-Alias firefox 'C:\Program Files (x86)\Mozilla Firefox\firefox.exe'
Set-Alias kindle 'C:\Users\Takuya\AppData\Local\Amazon\Kindle\application\Kindle.exe'
Set-Alias toefl 'C:\Program Files (x86)\McGraw-Hill\TOEFL Official Guide\TOEFL.exe'
Set-Alias putty 'C:\Program Files (x86)\putty-gdi-20150228\putty.exe' 
Set-Alias LTSpice 'C:\Program Files (x86)\LTC\LTspiceIV\scad3.exe' 

#for git
$env:path += ";" + (Get-Item "Env:ProgramFiles(x86)").Value + "\Git\bin"

#Load posh-git example profile
#. 'C:\tools\poshgit\dahlbyk-posh-git-869d4c5\profile.example.ps1'

#Getting git branch
function git_branch {
  git branch 2>$null |
  where { -not [System.String]::IsNullOrEmpty($_.Split()[0]) } |
  % { $bn = $_.Split()[1]
      Write-Output "($bn)" }
}

#for console
function prompt {
	$promptString = "PS " + $(Get-Location) + ">"
	# our theme
	$cdelim = [ConsoleColor]::DarkGray
	$chost = [ConsoleColor]::DarkGray
	$cloc = [ConsoleColor]::Red
	$cgit = [ConsoleColor]::DarkCyan

	$gitbranch = git_branch

	if ( $Host.Name -eq "ConsoleHost" )
	{
		write-host '[' -n -f $cdelim
		write-host ($env:username) -n -f $chost
		#write-host "@" -n -f $cdelim
		#write-host ([net.dns]::GetHostName()) -n -f $chost
		write-host ' ' -n -f $cdelim
		write-host (shorten-path (pwd).Path).Replace("\","/") -n -f $cloc
	   	write-host ']' -n -f $cdelim
		write-Host "$gitBranch" -n -f $cgit 
	   	write-host '$' -n -f $cdelim
	}

	else
	{
		Write-Host $promptString -n
	}

	return ' '
}

#shortening path
function shorten-path([string] $path) {
   $loc = $path.Replace($HOME, '~')
   # remove prefix for UNC paths
   $loc = $loc -replace '^[^:]+::', ''
   # make path shorter like tabs in Vim,
   # handle paths starting with \\ and . correctly
   return ($loc -replace '\\(\.?)([^\\])[^\\]*(?=\\)','\$1$2')
}