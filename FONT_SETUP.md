# Font Setup Instructions

## Download Noto Sans Fonts

1. Go to https://fonts.google.com/noto/specimen/Noto+Sans
2. Download the following font files:
   - NotoSans-Regular.ttf
   - NotoSans-Bold.ttf
   - NotoSans-SemiBold.ttf

3. Place them in: `assets/fonts/`

## Alternative: Quick Download

Run this command to download fonts directly:

```bash
# For Windows PowerShell
$fonts = @(
  "https://github.com/notofonts/notofonts.github.io/raw/main/fonts/NotoSans/unhinted/ttf/NotoSans-Regular.ttf",
  "https://github.com/notofonts/notofonts.github.io/raw/main/fonts/NotoSans/unhinted/ttf/NotoSans-Bold.ttf",
  "https://github.com/notofonts/notofonts.github.io/raw/main/fonts/NotoSans/unhinted/ttf/NotoSans-SemiBold.ttf"
)

foreach ($url in $fonts) {
  $filename = $url.Split('/')[-1]
  Invoke-WebRequest -Uri $url -OutFile "assets/fonts/$filename"
}
```

After downloading, run:
```bash
flutter pub get
flutter clean
flutter pub get
```

Then rebuild your app.
