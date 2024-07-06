function Increment-Version {
    param(
        [string]$version,
        [string]$type
    )
    $version_parts = $version.TrimStart('v').Split('.')
    $major = [int]$version_parts[0]
    $minor = [int]$version_parts[1]
    $patch = [int]$version_parts[2]

    switch ($type) {
        "major" { $major++; $minor = 0; $patch = 0 }
        "minor" { $minor++; $patch = 0 }
        "patch" { $patch++ }
        default { Write-Error "Invalid version bump type" }
    }

    return "v$major.$minor.$patch"
}

git fetch --tags
$current_tag = git describe --tags $(git rev-list --tags --max-count=1)
if (-not $current_tag) { $current_tag = "v0.0.0" }

$new_tag = Increment-Version -version $current_tag -type $env:VERSION_TYPE

Write-Output "New tag: $new_tag"

git tag -a $new_tag -m "Version $new_tag"
git remote set-url origin https://x-access-token:${env:GITHUB_TOKEN}@github.com/mandy8055/demo-cicd-poc.git
git push origin --tags
