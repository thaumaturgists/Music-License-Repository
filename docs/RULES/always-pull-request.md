# Always Pull Request
Creating another branch and pushing to that, so the branches can be merged by the maintainer.

==================================================
```
Am I able to make a pull request then push my content?

git push origin main
Enumerating objects: 31, done.
Counting objects: 100% (31/31), done.
Delta compression using up to 2 threads
Compressing objects: 100% (22/22), done.
Writing objects: 100% (26/26), 22.13 KiB | 3.16 MiB/s, done.
Total 26 (delta 7), reused 0 (delta 0), pack-reused 0 (from 0)
remote: Resolving deltas: 100% (7/7), completed with 3 local objects.
remote: error: GH013: Repository rule violations found for refs/heads/main.
remote: Review all repository rules at https://github.com/thaumaturgists/Music-License-Repository/rules?ref=refs%2Fheads%2Fmain
remote: 
remote: - Required status check "Enforce License Acceptance" is expected.
remote: 
remote: - Cannot update this protected ref.
remote: 
remote: - Changes must be made through a pull request.
remote: 
To https://github.com/thaumaturgists/Music-License-Repository
 ! [remote rejected] main -> main (push declined due to repository rule violations)
error: failed to push some refs to 'https://github.com/thaumaturgists/Music-License-Repository'
```
==================================================

The error message you're encountering indicates that the repository has certain rules and protections in place that prevent you from pushing directly to the `main` branch. Specifically, it mentions:

1. **Required Status Check**: The repository requires a status check called "Enforce License Acceptance" to pass before changes can be merged.
2. **Protected Branch**: The `main` branch is protected, meaning that direct pushes to it are not allowed.
3. **Pull Request Requirement**: Changes must be made through a pull request (PR).

### Steps to Make a Pull Request

Since you cannot push directly to the `main` branch, you can follow these steps to create a pull request:

1. **Create a New Branch**:
   First, create a new branch for your changes. This is where you will make your modifications before submitting a pull request.
   ```bash
   git checkout -b my-feature-branch
   ```

2. **Make Your Changes**:
   Make the necessary changes to your files in this new branch.

3. **Stage and Commit Your Changes**:
   After making your changes, stage and commit them:
   ```bash
   git add .
   git commit -m "Description of my changes"
   ```

4. **Push Your Branch to the Remote Repository**:
   Push your new branch to the remote repository:
   ```bash
   git push origin my-feature-branch
   ```

5. **Create a Pull Request**:
   After pushing your branch, go to the GitHub repository in your web browser. You should see a prompt to create a pull request for your newly pushed branch. Click on it and fill out the necessary details, then submit the pull request.

6. **Address Any Required Checks**:
   If there are any required status checks (like the "Enforce License Acceptance"), ensure that you comply with them. This may involve accepting a license or passing certain tests.

7. **Review and Merge**:
   Once your pull request is created, it can be reviewed by the repository maintainers. If everything is in order, they can merge your changes into the `main` branch.

### Conclusion
By following these steps, you can successfully make your changes and submit them for review through a pull request, complying with the repository's rules and protections. If you have any further questions or need assistance with any specific step, feel free to ask!

==================================================
```
tal 31 (delta 9), reused 0 (delta 0), pack-reused 0 (from 0)
remote: Resolving deltas: 100% (9/9), completed with 3 local objects.
remote: error: GH013: Repository rule violations found for refs/heads/my-feature-branch.
remote: Review all repository rules at https://github.com/thaumaturgists/Music-License-Repository/rules?ref=refs%2Fheads%2Fmy-feature-branch
remote: 
remote: - Required status check "Enforce License Acceptance" is expected.
remote: 
remote: - Cannot create ref due to creations being restricted.
remote: 
remote: - This branch must not contain merge commits.
remote:   Found 1 violation:
remote: 
remote:   f65c22f60eb9707709631e73e91ebb22dcaf1b43
remote: 
To https://github.com/thaumaturgists/Music-License-Repository
 ! [remote rejected] my-feature-branch -> my-feature-branch (push declined due to repository rule violations)
error: failed to push some refs to 'https://github.com/thaumaturgists/Music-License-Repository'
```
==================================================

# MAKE SURE YOU SIGN YOUR COMMITS
```
git commit -S -m "your-commit-here"
```
# MAKE SURE YOU PUSH TO YOUR NEW BRANCH
```
git push origin my-feature-branch
```

> Bellow is from the prompt

The error message you're encountering indicates that there are additional repository rules in place that are preventing you from pushing your feature branch. Here’s a breakdown of the issues and how to resolve them:

### Issues Identified

1. **Required Status Check**: The repository requires a status check called "Enforce License Acceptance" to pass before changes can be merged.
2. **Branch Creation Restrictions**: The repository has restrictions on creating new branches.
3. **Merge Commits Not Allowed**: The branch you are trying to push contains a merge commit, which is not allowed by the repository rules.

### Steps to Resolve the Issues

#### 1. **Check Out a New Branch from Main**
To avoid the merge commit issue, you should create your feature branch directly from the latest commit on the `main` branch. First, ensure your local `main` branch is up to date:

```bash
git checkout main
git pull origin main
```

Then, create a new branch from the updated `main`:

```bash
git checkout -b my-new-feature-branch
```

#### 2. **Make Your Changes**
Make the necessary changes in this new branch.

#### 3. **Stage and Commit Your Changes**
Stage and commit your changes without creating a merge commit:

```bash
git add .
git commit -m "Description of my changes"
```

#### 4. **Push Your New Branch**
Now, push your new branch to the remote repository:

```bash
git push origin my-new-feature-branch
```

#### 5. **Create a Pull Request**
After successfully pushing your new branch, go to the GitHub repository in your web browser. You should see a prompt to create a pull request for your newly pushed branch. Click on it and fill out the necessary details, then submit the pull request.

#### 6. **Address Required Checks**
Make sure to comply with any required checks, such as the "Enforce License Acceptance." This may involve accepting a license or passing certain tests.

### Conclusion
By following these steps, you should be able to create a new branch without merge commits and push it to the repository, allowing you to submit a pull request. If you encounter any further issues or have questions about specific steps, feel free to ask!