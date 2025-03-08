#!/bin/bash
# Make sure your repository is clean and on the correct branch.
# Adjust the start_date to a Sunday to properly align with GitHub's grid.
start_date=$(date -d "2023-12-31" +%s)

# Define your pattern as an array with 7 rows (one per weekday, starting with Sunday)
# Each string should have the same length (each column corresponds to one week)
# Here’s an example pattern intended to roughly spell "Im Single <3".
# You can modify these rows to better suit your design.
pattern=(
"011101001011110010010"   # Sunday row
"100011010100001101101"   # Monday row
"100011010100001101101"   # Tuesday row
"100011010100001101101"   # Wednesday row
"100011010100001101101"   # Thursday row
"100011010100001101101"   # Friday row
"011101001011110010010"   # Saturday row
)

# Determine the number of weeks (columns) in your pattern
numWeeks=${#pattern[0]}

# Loop through each week (column) and each day (row)
for (( week=0; week<numWeeks; week++ )); do
  for (( day=0; day<7; day++ )); do
    # Extract the commit flag for the current day/week from the pattern
    cell=${pattern[day]:week:1}
    if [ "$cell" == "1" ]; then
      # Calculate the commit date by adding the appropriate number of days to the start_date
      commit_date=$(date -d "@$(( start_date + (week * 7 + day) * 86400 ))" +"%Y-%m-%d 12:00:00")
      # Make an empty commit with the desired author/committer dates
      GIT_AUTHOR_DATE="$commit_date" GIT_COMMITTER_DATE="$commit_date" \
      git commit --allow-empty -m "Commit for $commit_date"
    fi
  done
done
