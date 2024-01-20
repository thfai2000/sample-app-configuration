#!/bin/bash

export HOST_YAML="hosts/dit1.web1.example.com.yaml"
export GROUP_YAML_DIR="groups"
export HOST_COMPONENT="web1"

# Check if all required environment variables are set
if [[ -z "$HOST_YAML" || -z "$GROUP_YAML_DIR" || -z "$HOST_COMPONENT" ]]; then
    echo "Please set the required environment variables: HOST_YAML, GROUP_YAML_DIR, HOST_COMPONENT"
    exit 1
fi

# Read the host_groups from the Host YAML file
HOST_GROUPS=$(yq eval '.host_groups' "$HOST_YAML")

# Create a temporary file to store the merged output
MERGED_FILE=$(mktemp)

# Merge the children elements of "props" with Group YAML contents
for group in $HOST_GROUPS; do
    GROUP_YAML="$GROUP_YAML_DIR/${group}.yaml"

    # Merge the Host YAML and Group YAML using yq tool
    yq eval-all 'select(fileIndex == 0) * select(fileIndex == 1)' "$HOST_YAML" "$GROUP_YAML" > "$MERGED_FILE"
    mv "$MERGED_FILE" "$HOST_YAML"
done

# Merge the children elements of "props" of a specific "host_component"
SPECIFIC_PROPS=$(yq eval ".host_components[] | select(.name == \"$HOST_COMPONENT\") | .props" "$HOST_YAML")

# Merge the Host YAML and specific props using yq tool
yq eval-all 'select(fileIndex == 0) * select(fileIndex == 1)' "$HOST_YAML" <(echo "$SPECIFIC_PROPS") > "$MERGED_FILE"
mv "$MERGED_FILE" "$HOST_YAML"

echo "Merging completed. Merged output saved to $HOST_YAML"