using FFMPEG
imagesdirectory = plotsdir("orbit", "orbitdiagram")
framerate = 3
gifname = "output.gif"
FFMPEG.ffmpeg_exe(`-framerate $(framerate) -f image2 -i $(imagesdirectory)/%04d.png -vf "scale=1080:-1:flags=lanczos" -y $(gifname)`)