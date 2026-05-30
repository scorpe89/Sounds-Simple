# Sounds Simple

Sounds Simple is a native macOS soundboard and music companion. It can play local audio clips from keyboard shortcuts, open linked music services, record custom audio, edit clips, and manage local playlists.

## What You Need

- A Mac.
- The `Sounds Simple.zip` file.
- Internet access if you want account login, metadata lookup, linked music, or sharing features.

## Install

1. Download `Sounds Simple.zip`.
2. Double-click the zip file to unzip it.
3. Open the unzipped `Sounds Simple Share` folder.
4. Double-click `install_to_applications.command`.
5. If macOS asks for permission, choose `Open`.
6. When Finder opens `/Applications`, double-click `Sounds Simple`.

If macOS says the app cannot be opened because it is from an unidentified developer:

1. Right-click `Sounds Simple.app`.
2. Choose `Open`.
3. Click `Open` again.

## First Launch

Sounds Simple requires an account screen before the app can be used.

Normal use:

1. Enter a username, email, and password.
2. Click `Create Account`, or enter an existing email/password and click `Sign In`.

## Add A Sound

1. Go to the `List` tab.
2. Click `Add Sound`.
3. Pick an audio file.
4. Enter a name.
5. Enter a keyboard key, like `A` or `1`.
6. Choose a sound type: `SFX`, `Music`, or `Other`.
7. Optionally choose a custom image.
8. Click `Save`.

Press the assigned key while the app is focused to play the sound.

## Add A Linked Music Item

1. Go to the `List` tab.
2. Click `Add Link`.
3. Paste any music URL.

Examples:

- YouTube playlist
- Spotify song or playlist link
- Apple Music link
- SoundCloud link
- Bandcamp link
- Web radio page

Linked music opens in your default browser or the service app registered on your Mac. Sounds Simple does not bypass paid-service restrictions.

## Use Tap Pads

1. Go to the `Pads` tab.
2. Click a pad to play/open the assigned item.
3. Custom images appear inside the pad when assigned.

## Record Audio

1. Go to the `Recording` tab.
2. Click `Start Recording`.
3. Click `Stop + Add` when done.
4. Save it as a soundboard item.

Recent recordings appear on the recording page. Double-click a recording to play it. Right-click a recording for extra actions like showing it in Finder or deleting it.

## Edit Audio

1. Go to the `Editor` tab.
2. Choose `Use Recording`, `Use App Sound`, or `Import External`.
3. Use the waveform timeline to choose the section you want to keep. Drag the `Start` or `End` handle on the waveform, or use the trim sliders for precise adjustments.
4. Use `Wave Zoom` to expand the waveform when you need to see a smaller section more clearly. Scroll horizontally when zoomed in.
5. Set the volume.
6. Click `Preview Edit`.
7. Click `Save Edited Clip`.

The saved clip can be added to the soundboard.

## Music Player

1. Go to the `Music` tab.
2. `All Songs` is always listed at the top. It shows every song from every playlist.
3. Click `Add Playlist`.
4. Select a playlist, then click `Add Songs` to import music files from your computer.
5. Click `Add From Playlist` to copy a song from another playlist into the selected playlist.
6. Double-click a song to play it.
7. Use the playback buttons for previous, rewind, play/pause, fast-forward, and next.

The music table columns are:

`Track # | Title | Album | Artist | Duration`

Click a column header to sort. Right-click a song and choose `Edit Song Data` to edit track number, title, album, artist, or duration. Right-click a song and choose `Add to Playlist...` to copy that song into another playlist.

When you remove a song from a normal playlist, choose `This playlist only` if you want it to stay in `All Songs`. Removing from the `All Songs` library removes that song from every playlist too.

## Playlist Sharing

In the `Music` tab:

- `Export Playlist` creates a shareable playlist package with copied audio/artwork files.
- `Import Playlist` imports a package from someone else.

## Supabase Setup

The app is already configured with the Sounds Simple project URL and publishable key in code. If the app says Supabase is not configured:

1. Open `Sounds Simple` menu.
2. Choose `Configure Supabase`.
3. Project URL:
   `https://vygzpfdplpmetdfoions.supabase.co`
4. Publishable key:
   `sb_publishable_V1LJorrIxrYz3hpPo5RZwg_4s5vRgKr`

## Where Files Are Stored

The app stores user data here:

`~/Library/Application Support/Sounds Simple/`

Important files:

- `soundboard.json`
- `music-playlists.json`
- `Sounds/`
- `Images/`

## Troubleshooting

If login freezes:

- Wait up to 20 seconds. The app should show an error if Supabase cannot be reached check your internet connection.

If login says invalid credentials:

- The email or password is wrong, or the account has not been confirmed if email confirmation is enabled.

If a linked music service will not play:

- Open the link in a browser first.
- Make sure you are signed into that service if needed.
- Some services require paid accounts for full playback.
