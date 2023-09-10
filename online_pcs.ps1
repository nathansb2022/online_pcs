# Take a list of pcs and find out which ones are online in AD environment

#Please add login ID # below in $admin variable i.e. 0123456789 and review next comment.

$admin = '0123456789'

#Please make sure to run the script from directory that the updatedpcs.txt is stored or the name of the
#text file that has your pcs.

$computers = gc .\updatedpcs.txt;

$results = @()

foreach ($computer in $computers) {

    $counter += 1

    if (!(Test-Connection -ComputerName $computer -Count 1 -Quiet)){
	$statusOnline = $False
	echo $statusOnline
    }
    else{
        $statusOnline = $True
    }

    
    $Output = @{
        'Computer Name' = $computer
        'Online' = $statusOnline
        'Count' = $counter
    }   
    $results += New-Object PSObject -Property $Output 
    write-output ("Computer: {0} Online: {1} Count: {2}" -f $computer,$statusOnline,$counter) 
} 
$counter = 0
if ($admin -ne $null) {
	$date = (Get-Date).ToString("MMddyyyy")
	$filename = "onlinePCs" + $date + ".csv"
	$results | Export-Csv C:\users\$admin\desktop\$filename
}
