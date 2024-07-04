function Increment-Version {
    param(
        [string]$version
    )
    $version_parts = $version.TrimStart('v').Split('.')
    $major = [int]$version_parts[0]
    $minor = [int]$version_parts[1]
    $patch = [int]$version_parts[2]
    $patch++
    return "v$major.$minor.$patch"
}

$current_tag = git tag --list --sort=-v:refname | Select-Object -First 1
Write-Output "Current tag: $current_tag"
if (-not $current_tag) { $current_tag = "v0.0.0" }
Write-Output "Current tag on line 16: $current_tag"

$new_tag = Increment-Version -version $current_tag

Write-Output "New tag: $new_tag"

git tag -a $new_tag -m "Version $new_tag"
git remote set-url origin https://x-access-token:${env:GITHUB_TOKEN}@github.com/mandy8055/demo-cicd-poc.git
git push origin --tags
