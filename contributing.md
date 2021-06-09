#Guideline for contributing to this repository

## Overview
- We will track phyloflow and FAVE-phylo bugs in this repo's *issues*.
- Large improvements should get an issue as well, so we can discuss before real coding happens.
- Submit Pull Requests with any improvements. They are most welcome. (see below)
- Please write detailed descriptions in PRs. We are more likely to track PRs than issues or commit 
messages in the long term (eg when making changelogs for releases).

## Wiki Resources

- If you are very new to git, please read the [Git Basics](https://github.com/ncsa/phyloflow/wiki/Git-Basics) doc that covers
  the minimal subset of git concepts this project uses.
- For an example of making a new branch and pushing it back to Github so that a Pull Request can be made, see [Git-Crash-Course-Walkthrough-for-Students](https://github.com/ncsa/phyloflow/wiki/Git-Crash-Course-Walkthrough-for-Students).

## Pull Requests

Once you have pushed a branch up to this repository, you can make a pull
request through the github website. Some pointers: 
1. Name your branch with
your own initials, eg 'pg/readme_format' if your initials are pg and the  
changes are about the formatting in the README. Do not worry too much about the name
otherwise, just something short.
2. Never commit directly to the `master` branch, always create a PR and click
'merge' in the github website.
3. However, you can approve and merge your own pull requests in an emergency
(or a tight deadline and it's 3am). Just make a PR so there is a record of it.
You can't do anything that can't be undone.
4. **Try** to only have one functional change per PR. A functional change
usually involves multiple files, so if there are multiple functional changes it takes a
lot of documentation and mental effor for the reviewer to understand each
changed file they see. EG, if you fix two bugs in one PR, and 10 files
changed, the reviewer has a harder time understanding what each change is
doing.  
5. However, you will be forgiven if there is a lot in one PR (it won't
be rejected). Just please be generous with explanations.
6. If a PR is related to an issue, please make note of it in the PR
description.  
6. Please write a good overview of the changes as the `description`. If details
need explanation, it is easier to understand if they are put as comments on the
diff. (I think you have to make the PR first, and then you can add comments
inline).  6. You can make a PR even if it's not done. Just make a note in the
description. 
7. Normally we will reject PRs (or withold approval) only if
they seem really broken. More common is we will comment on things we think
could be better and then approve it. The submitter can either make more changes
or open new issues to work on them later. The submitter can click the 'merge'
button. This avoids the submitter waiting on a second review if possible.
8. At some point we will set up continuous-integration tests using
Github Actions. At that point you will be obligated to get all tests passing on
your branch before merging it.

