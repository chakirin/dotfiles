########################################
#               General                #
########################################
# module
#
Import-Module Pscx
if ($Host.Name -eq 'ConsoleHost')
{
	Import-Module PSReadLine
  # setting
  Set-PSReadlineKeyHandler -Key 'Ctrl+a' -Function BeginningOfLine
  Set-PSReadlineKeyHandler -Key 'Ctrl+e' -Function EndOfLine
  Set-PSReadlineKeyHandler -Key 'Ctrl+p' -Function HistorySearchBackward
  Set-PSReadlineKeyHandler -Key 'Ctrl+n' -Function HistorySearchForward
}


# environments
#
$Shell = $Host.UI.RawUI
$Shell.WindowTitle = "on your own"

########################################
#           Software Settings          #
########################################
$Env:Path = "C:\Program Files\mingw-w64\x86_64-5.1.0-posix-seh-rt_v4-rev0\mingw64\bin\;" + $Env:Path
$Env:Path = "C:\Program Files (x86)\ffmpeg\bin\;" + $Env:Path

# alias
Set-Alias vim 'C:\Program Files (x86)\vim\vim.exe'
Set-Alias gvim 'C:\Program Files (x86)\vim\gvim.exe'
Set-Alias git 'C:\Program Files\Git\bin\git.exe'
Set-Alias ssh 'C:\Program Files\Git\usr\bin\ssh.exe'
Set-Alias scp 'C:\Program Files\Git\usr\bin\scp.exe'
Set-Alias python 'C:\Program Files (x86)\Python-3.4.3\python.exe'
Set-Alias youtube-dl 'C:\Program Files (x86)\youtube-dl\youtube-dl.exe'
Set-Alias notepad++ 'C:\Program Files (x86)\Notepad++\notepad++.exe'
Set-Alias acrobat 'C:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\AcroRd32.exe'

########################################
#               Display                #
########################################
# prompt
#
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
		write-host "@" -n -f $cdelim
		write-host ([net.dns]::GetHostName()) -n -f $chost
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

function git_branch {
  git branch 2>$null |
  where { -not [System.String]::IsNullOrEmpty($_.Split()[0]) } |
  % { $bn = $_.Split()[1]
      Write-Output "($bn)" }
}

function shorten-path([string] $path) {
   $loc = $path.Replace($HOME, '~')
   # remove prefix for UNC paths
   $loc = $loc -replace '^[^:]+::', ''
   # make path shorter like tabs in Vim,
   # handle paths starting with \\ and . correctly
   return ($loc -replace '\\(\.?)([^\\])[^\\]*(?=\\)','\$1$2')
}

