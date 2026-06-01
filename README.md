## Changes

### Build 1.5

- Added time markers to the editor waveform.
- Added the main audio file to the editor layers panel.
- Added internal scrolling to the users/friends panel.
- Made `Space` pause or resume audio playback throughout the app.
- Started tracking build changes in this README.

# Sounds Simple

Sounds Simple is a native macOS soundboard and music companion. It can play local audio clips from keyboard shortcuts, open linked music services, record custom audio, edit clips, and manage local playlists.

## What You Need

- A Mac.
- The `Sounds Simple.zip` file.
- Internet access if you want account login, metadata lookup, linked music, or sharing features.

## Install

1. Download `Sounds Simple v. 1.5.zip`.
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

Sounds Simple works locally without an account. If you see the account window, you can sign in, create an account, close it, or choose `Use App Without Account`.

Accounts are only needed for online features such as friends and sharing.

You can also open account options later from `Sounds Simple > Account...`.

## Add Friends

Use the `Add Friend` button in the `Active Friends` panel. Enter your friend's Sounds Simple username or email address, then send the request.

The same panel also shows active users and active friends. If you are signed in, you appear in the active users section. After 5 minutes without activity, your status changes to idle.

Use `Message Friend` to send a direct message. Messages only work with accepted friends.

## Send Feedback

Open `Sounds Simple > Send Feedback...`.

Enter either your email address or your Sounds Simple username, then type your message and click `Send`. If you use a username, the app checks that the username exists before sending.

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

1. Click `Open Sound Editor` on the right side of the main window.
2. Click the top drop box to choose an audio file, or drag an audio file into it.
3. Use the control bar below the drop box for recording/app sound imports, preview, save, layers, zoom, and fine trim controls.
4. Click and drag across the waveform to select the section you want to keep.
5. Drag the volume control inside the waveform to adjust loudness.
6. Use the zoom buttons to expand or shrink the waveform. Scroll horizontally when zoomed in.
7. Click `Add Layer` to place another audio file over the main track.
8. Right-click a layer to edit its start time, volume, show it in Finder, or remove it.
9. Click `Preview Mix` to hear the layered edit.
10. Click `Save Edited Clip`.

Editor keyboard commands:

- `Space`: pause or resume playback.
- `Command-S`: save the edited clip.
- `Command-L`: add a layer.
- `Command-+`: zoom in.
- `Command--`: zoom out.
- `Delete`: remove the selected layer.

The saved clip can be added to the soundboard.

## Music Player

1. Go to the `Music` tab.
2. `All Songs` is always listed at the top. It shows every song from every playlist.
3. Click `Add Playlist`.
4. Select a playlist, then click `Add Songs` to import music files from your computer.
5. Click `Add From Playlist` to copy a song from another playlist into the selected playlist.
6. Double-click a song to play it.
7. Use the playback buttons for previous, rewind, play/pause, fast-forward, and next.
8. Click `Share Playlist` to create one soundboard item that starts the entire playlist from one hotkey or pad.
9. Click `Share Friend` to share the selected playlist with an accepted friend.
10. Click `Get Shared` to import playlists friends have shared with you.

The music table columns are:

`Track # | Title | Album | Artist | Duration`

Click a column header to sort. Right-click a song and choose `Edit Song Data` to edit track number, title, album, artist, or duration. Right-click a song and choose `Add to Playlist...` to copy that song into another playlist. Right-click a playlist and choose `Share Playlist to Soundboard` to create one soundboard item for the whole playlist.

When you remove a song from a normal playlist, choose `This playlist only` if you want it to stay in `All Songs`. Removing from the `All Songs` library removes that song from every playlist too.

Friend playlist sharing sends the playlist data through your account. Linked songs travel cleanly. Local audio files still need to exist on the receiving device unless account media sync has been set up.

## Playlist Sharing

In the `Music` tab:

- `Export Playlist` creates a shareable playlist package with copied audio/artwork files.
- `Import Playlist` imports a package from someone else.

## Where Files Are Stored

The app stores user data here:

`~/Library/Application Support/Sounds Simple/`

Important files:

- `soundboard.json`
- `music-playlists.json`
- `Sounds/`
- `Images/`

## Share With Someone Else

Send them `Sounds Simple.zip`.

They should unzip it, open `Sounds Simple Share`, and run `install_to_applications.command`.

## Troubleshooting

If account sign-in does not work:

- Choose `Use App Without Account` to keep using local soundboard features.
- Check your internet connection.
- Try signing in again later.

If login says invalid credentials:

- The email or password is wrong, or the account has not been confirmed if email confirmation is enabled.

If a linked music service will not play:

- Open the link in a browser first.
- Make sure you are signed into that service if needed.
- Some services require paid accounts for full playback.
