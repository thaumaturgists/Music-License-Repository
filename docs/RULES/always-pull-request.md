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