## R CMD check results
For a CRAN submission we recommend that you fix all NOTEs, WARNINGs and ERRORs.
## Test environments
- R-hub windows-x86_64-devel (r-devel)
- R-hub ubuntu-gcc-release (r-release)
- R-hub fedora-clang-devel (r-devel)

## R CMD check results
❯ On windows-x86_64-devel (r-devel)
  checking CRAN incoming feasibility ... NOTE
  Maintainer: 'zhexuan gu <22054513g@connect.polyu.hk>'
  
  Possibly misspelled words in DESCRIPTION:
    Cho (16:24)
    Js (16:29)
    al (16:36)
    et (16:33)

❯ On windows-x86_64-devel (r-devel)
  checking for non-standard things in the check directory ... NOTE
    ''NULL''
  Found the following files/directories:

❯ On windows-x86_64-devel (r-devel)
  checking for detritus in the temp directory ... NOTE
  Found the following files/directories:
    'lastMiKTeXException'

❯ On ubuntu-gcc-release (r-release)
  checking CRAN incoming feasibility ... [7s/16s] NOTE
  Maintainer: ‘zhexuan gu <22054513g@connect.polyu.hk>’
  
  Possibly misspelled words in DESCRIPTION:
    al (16:36)
    Cho (16:24)
    et (16:33)
    Js (16:29)

❯ On ubuntu-gcc-release (r-release), fedora-clang-devel (r-devel)
  checking HTML version of manual ... NOTE
  Skipping checking HTML validation: no command 'tidy' found

❯ On fedora-clang-devel (r-devel)
  checking CRAN incoming feasibility ... [8s/18s] NOTE
  Maintainer: ‘zhexuan gu <22054513g@connect.polyu.hk>’
  
  Possibly misspelled words in DESCRIPTION:
    Cho (16:24)
    Js (16:29)
    al (16:36)
    et (16:33)

0 errors ✔ | 0 warnings ✔ | 6 notes ✖

All the potential misspelled words are just the authors of the reference paper, they're not misspelled.

For the rest notes, they're just because of the crashed environment of the server which can be ignored.
