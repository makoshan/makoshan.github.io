# Newsletter Cleanup Script
# Remove redundant files from scripts directory

Write-Host "Starting cleanup..." -ForegroundColor Cyan

$deletedCount = 0

# Delete redundant documentation files
Write-Host "`nDeleting documentation files..." -ForegroundColor Yellow
$docFiles = @(
    "ANNOTATION_GUIDE.md", "CONTRIBUTING.md", "CONTRIBUTORS.md",
    "DATA-SOURCES.md", "DEPLOY.md", "DEPLOYMENT.md",
    "HAKYLL_COMPILE_GUIDE.md", "NEWSLETTER_WORKFLOW.md",
    "QUICKSTART.md", "README.md", "SECURITY.md"
)

foreach ($file in $docFiles) {
    if (Test-Path $file) {
        Remove-Item $file -Force
        Write-Host "  Deleted: $file" -ForegroundColor Gray
        $deletedCount++
    }
}

# Delete template files
Write-Host "`nDeleting template files..." -ForegroundColor Yellow
$templateFiles = @(
    "temp_annotation_section.md",
    "gwern-net-design.md",
    "hacker-podcast-analysis.md",
    "daily-intel-pipeline-README.m",
    "Feed.hs"
)

foreach ($file in $templateFiles) {
    if (Test-Path $file) {
        Remove-Item $file -Force
        Write-Host "  Deleted: $file" -ForegroundColor Gray
        $deletedCount++
    }
}

# Delete redundant Python scripts
Write-Host "`nDeleting redundant Python scripts..." -ForegroundColor Yellow
$pythonFiles = @(
    "daily-intel-pipeline.py",
    "daily-intel-pipeline-enhanced.py",
    "daily_intel_enhanced.py",
    "content_enhancer.py",
    "hn_comment_analyzer.py",
    "fetcher.py",
    "summarizer.py",
    "main.py",
    "daily_newsletter_page.py",
    "rss_fetcher.py",
    "requirements.txt"
)

foreach ($file in $pythonFiles) {
    if (Test-Path $file) {
        Remove-Item $file -Force
        Write-Host "  Deleted: $file" -ForegroundColor Gray
        $deletedCount++
    }
}

# Delete conversion scripts
Write-Host "`nDeleting conversion scripts..." -ForegroundColor Yellow
$convertFiles = @(
    "convert_to_page.py",
    "convert_all_posts.sh",
    "markdown-lint.sh",
    "newsletter_requirements.txt"
)

foreach ($file in $convertFiles) {
    if (Test-Path $file) {
        Remove-Item $file -Force
        Write-Host "  Deleted: $file" -ForegroundColor Gray
        $deletedCount++
    }
}

# Delete cache
Write-Host "`nDeleting cache..." -ForegroundColor Yellow
if (Test-Path "__pycache__") {
    Remove-Item "__pycache__" -Recurse -Force
    Write-Host "  Deleted: __pycache__" -ForegroundColor Gray
    $deletedCount++
}

Write-Host "`nCleanup complete!" -ForegroundColor Green
Write-Host "Total files deleted: $deletedCount" -ForegroundColor Green

Write-Host "`nKept Newsletter files:" -ForegroundColor Cyan
Write-Host "  newsletter/generator.py"
Write-Host "  newsletter/rss_fetcher.py"
Write-Host "  newsletter/requirements.txt"
Write-Host "  newsletter/README.md"
Write-Host "  NEWSLETTER_QUICKSTART.md"
