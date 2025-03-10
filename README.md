## Getting Started
To get started with the Hangman Game, follow these steps:

**1. Clone the Repository:**
      <div class="highlight highlight-source-shell notranslate position-relative overflow-auto" dir="auto"><pre>your@pc:<span class="pl-k">~</span>$  git clone https://github.com/your-username/hangman.git</pre><div class="zeroclipboard-container"><clipboard-copy aria-label="Copy" class="ClipboardButton btn btn-invisible js-clipboard-copy m-2 p-0 tooltipped-no-delay d-flex flex-justify-center flex-items-center" data-copy-feedback="Copied!" data-tooltip-direction="w" value="your@pc:~$ git clone git@github.com:Fisola91/hangman.git" tabindex="0" role="button">
      <div class="highlight highlight-source-shell notranslate position-relative overflow-auto" dir="auto"><pre>your@pc:<span class="pl-k">~</span>$ cd hangman</pre><div class="zeroclipboard-container"><clipboard-copy aria-label="Copy" class="ClipboardButton btn btn-invisible js-clipboard-copy m-2 p-0 tooltipped-no-delay d-flex flex-justify-center flex-items-center" data-copy-feedback="Copied!" data-tooltip-direction="w" value="your@pc:~$ git clone git@github.com:Fisola91/hangman.git" tabindex="0" role="button">
         
**2. Run the Game:**
     Execute the following command to start the game:
         <div class="highlight highlight-source-shell notranslate position-relative overflow-auto" dir="auto"><pre>your@pc:<span class="pl-k">~</span>$ ruby bin/play</pre><div class="zeroclipboard-container"><clipboard-copy aria-label="Copy" class="ClipboardButton btn btn-invisible js-clipboard-copy m-2 p-0 tooltipped-no-delay d-flex flex-justify-center flex-items-center" data-copy-feedback="Copied!" data-tooltip-direction="w" value="your@pc:~$ git clone git@github.com:Fisola91/hangman.git" tabindex="0" role="button">
     
**3. Follow On-screen Instructions:** The game will prompt you to enter characters to guess the word. Follow the on-screen instructions to play.

## How to Play
<ul dir="auto">
  <li>
    Guess the word by entering characters one at a time.
  </li>
  <li>
   Incorrect guesses will result in the display of incorrect letters and game attempts left.
  </li>
   <li>
   You have a limited number of chances to guess the word.
  </li>
   <li>
  Save your progress during the game and resume later.
  </li>
 <li>
   Save and Load.
  </li>
 <li>
  When prompted, you can choose to save your progress and leave the game.
  </li>
 <li>
 To resume a saved game, select the option to restart and choose the saved game file.
  </li>
</ul


## File Structure
<ul dir="auto">
  <li>
    hangman_game.rb: Main Ruby script containing the game logic.
  </li>
 <li>
   google-10000-english-no-swears.txt: Text file containing a list of English words.
  </li>
 <li>
    save.json: JSON file used to store save game data.
  </li>
</ul    



