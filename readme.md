#### Keyboard drummer

---

**Prerequisites**

- ruby 2.3
- system depencencies: `apt-get install mpg123 lame alsamixer arecord ffmpeg vorbis-tools`
- a decent processor. I have an intel i5 and the load is fairly low. But
keep in mind that every drum hit opens a thread and tells `mpg123` to play a
mp3 file. 

**Install**

- clone
- bundle

**Usage**

- run `ruby sounds.rb` and read the instructions page that is printed
- try hitting the keys r,f,v,t,g,b,y,h,n (all in the center of the keyboard) to play some drum sounds.

**Extending and Customizing**

Start with [keymap.yml](./keymap.yml).

To define 'sound effects', work in the [lib/effects.rb](lib/effects.rb) file.
You can call these method from the keymap file

To add mp3 sounds, save the files into the [mp3/](./mp3/) folder.
If you call `play('hihat')` from code that will look for `mp3/hihat.mp3`.

When the CLI is running, all keystrokes are interpreted as musical hits with
two exceptions:

  - `control+c` will exit
  - `/` begins a 'special command'

See [lib/special_commands.rb](./lib/special_commands.rb) for reference, but here
are some examples:

  - `/r` turns on/off recording
  - `/p` turns on/off looped playback of the last recorded sound
  - `/u` turns on/off metronome
  - `/td` launches a prompt to decrease the tempo (for metronome)
    - `/tu` and `/t=` work similarly
  - `/s` prompts for a new time signature (used by metronome)
  - `/h` prints the help page
  - `/k` prints the keymap

**Feaures in development**

Arpeggios:

- see the keymap for an example of starting an arpeggio.
- define a new arpeggio in [lib/arpeggio_scales.rb](./lib/arpeggio_scales.rb).
Also see `Integer#to_musical_scale_step` defined in [core_util.rb](./core_util.rb)
and the methods in [lib/musical_scale_step.rb](./lib/musical_scale_step.rb).
- The first time an arpeggio is run, it will create a bunch of files. These are copies
of the trigger mp3 sound, pitch shifted to whatever the arpeggio requires.
- From time to time `rm -rf mp3/arpeggios/*` can be run to clear out old arpeggio files
if the folder's getting large. The arpeggio files can be recreated at runtime, anyway. 