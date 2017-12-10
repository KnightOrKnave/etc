$base_dir="D:\target\directory"
$targets=@{}

$boader_line=90


if(! Test-Path $base_dir)
{
	exit 1
}

foreach ($d in $targets){
	$search_target_dir=$base_dir/$d

	if(! Test-Path $search_target_dir)
	{
		continue;
	}

	if ((Get-ChildItem -Recurse "$base_dir/$d" | Where-Object {! $_.PSIsContainer  -and ((Get-Date) - $_.CreationTime).Days -ge 0 }).Length -eq 0)
	{
	    echo "not exist"
	}
	else
	{
		echo "exist"
	}
}
